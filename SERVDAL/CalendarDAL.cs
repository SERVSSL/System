﻿using System;
using System.Collections.Generic;
using SERVDataContract.DbLinq;
using System.Linq;

namespace SERVDAL
{
	public class CalendarDAL : IDisposable
	{

		static Logger log = new Logger();
		private SERVDataContract.DbLinq.SERVDB db;

		public CalendarDAL()
		{
			db = new SERVDataContract.DbLinq.SERVDB(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
		}

		public Calendar Get(int calendarId)
		{
			SERVDataContract.DbLinq.Calendar cal = (from c in db.Calendar where c.CalendarID == calendarId select c).FirstOrDefault();
			return cal;
		}

		public int CreateCalendarEntry(int calendarID, int memberID, DateTime date, bool adHoc)
		{
			log.LogStart();
			CalendarEntry e = new CalendarEntry()
			{
				CreateDateTime = DateTime.Now,
				CalendarID = calendarID,
				EntryDate = date,
				MemberID = memberID,
				CoverNeeded = 0,
				CoverCalendarEntryID = null,
				AdHoc = adHoc ? (sbyte)1: (sbyte)0,
				ManuallyAdded = adHoc ? (sbyte)1: (sbyte)0,
			};
			db.CalendarEntry.InsertOnSubmit(e);
			db.SubmitChanges();
			return e.CalendarEntryID;
		}

		public bool SaveCalendarProps(int calendarId, string calendarName, int sortOrder, int requiredTagId, int defaultRequirement)
		{
			Calendar cal = (from c in db.Calendar
			                where c.CalendarID == calendarId
			                select c).FirstOrDefault();
			if (cal == null)
			{
				return false;
			}
			cal.Name = calendarName;
			cal.SortOrder = sortOrder;
			cal.RequiredTagID = requiredTagId;
			cal.DefaultRequirement = defaultRequirement;
			db.SubmitChanges();
			return true;
		}

		public List<CalendarEntry> ListCalendarEntries(DateTime date)
		{
			DateTime start = log.LogStart();
			List<CalendarEntry> ret = (from e in db.CalendarEntry where e.EntryDate == date orderby e.CalendarID, e.AdHoc select e).ToList();
			log.LogPerformace(start);
			return ret;
		}

		public List<CalendarEntry> ListCalendarEntries(DateTime startDate, DateTime endDate)
		{
			DateTime start = log.LogStart();
			List<CalendarEntry> ret = (from e in db.CalendarEntry where e.EntryDate >= startDate && e.EntryDate <= endDate orderby e.CalendarID, e.EntryDate, e.AdHoc select e).ToList();
			log.LogPerformace(start);
			return ret;
		}

		public void RemoveCalendarEntry(int calendarEntryID)
		{
			log.LogStart();
			string sql = string.Format("delete from CalendarEntry where CalendarEntryID = {0}", calendarEntryID);
			db.ExecuteCommand(sql);
		}

		public CalendarEntry GetCalendarEntry(DateTime date, int calendarId, int memberId, int adHoc)
		{
			return (from e in db.CalendarEntry where e.EntryDate == date && e.CalendarID == calendarId && e.MemberID == memberId && e.AdHoc == adHoc select e).FirstOrDefault();
		}

		public CalendarEntry GetCalendarEntry(DateTime date, int calendarId, int memberId)
		{
			return (from e in db.CalendarEntry where e.EntryDate == date && e.CalendarID == calendarId && e.MemberID == memberId select e).FirstOrDefault();
		}

		public CalendarEntry GetCalendarEntry(int calendarEntryId)
		{
			return (from e in db.CalendarEntry where e.CalendarEntryID == calendarEntryId select e).FirstOrDefault();
		}

		public bool MarkShiftSwapNeeded(int calendarId, int memberId, DateTime shiftDate)
		{
			log.LogStart();
			CalendarEntry e = (from ce in db.CalendarEntry
			                   where ce.CalendarID == calendarId && ce.MemberID == memberId && ce.EntryDate == shiftDate
			                   select ce).FirstOrDefault();
			if (e == null)
			{
				return false;
			}
			e.CoverNeeded = 1;
			db.SubmitChanges();
			return true;
		}

		public bool MarkShiftSwapNoLongerNeeded(int calendarEntryID)
		{
			log.LogStart();
			CalendarEntry e = (from ce in db.CalendarEntry
				where ce.CalendarEntryID == calendarEntryID
				select ce).FirstOrDefault();
			if (e == null)
			{
				return false;
			}
			e.CoverNeeded = 0;
			db.SubmitChanges();
			return true;
		}
			
		public int Create(Calendar c)
		{
			log.LogStart();
			db.Calendar.InsertOnSubmit(c);
			db.SubmitChanges();
			return c.CalendarID;
		}

		public void RosterVolunteer(int calendarId, int memberId, string rosteringWeek, int rosteringDay)
		{
			log.LogStart();
			db.MemberCalendar.InsertOnSubmit(new MemberCalendar(){ MemberID = memberId, CalendarID = calendarId, SetDayNo = rosteringDay, Week = rosteringWeek });
			db.SubmitChanges();
		}

		public void RemoveRotaSlot(int calendarId, int memberId, string rosteringWeek, int rosteringDay)
		{
			log.LogStart();
			string sql = string.Format("delete from Member_Calendar where MemberID = {0} and CalendarID = {1} and Week = '{2}' and SetDayNo = {3}", memberId, calendarId, rosteringWeek, rosteringDay);
			db.ExecuteCommand(sql);
		}

		public List<Calendar> ListCalendars()
		{
			DateTime start = log.LogStart();
			List<Calendar> ret = (from c in db.Calendar select c).ToList();
			log.LogPerformace(start);
			return ret;
		}

		public List<MemberCalendar> ListRosteredVolunteers()
		{
			return (from mc in db.MemberCalendar
				orderby mc.CalendarID, mc.Week, mc.SetDayNo
				select mc).ToList();
		}

		public List<MemberCalendar> ListRosteredVolunteers(int calendarId)
		{
			return (from mc in db.MemberCalendar
			        where mc.CalendarID == calendarId
			        orderby mc.Week, mc.SetDayNo
			        select mc).ToList();
		}

		public List<MemberCalendar> ListRosteredVolunteers(string week, int day)
		{
			return (from mc in db.MemberCalendar
				where mc.Week == week && mc.SetDayNo == day
				select mc).ToList();
		}

		public List<Member> ListMembersOnShift(int calendarId, DateTime date)
		{
			return (from m in db.CalendarEntry
			        where m.CalendarID == calendarId && m.CoverNeeded == 0 && m.EntryDate == date
				select m.Member).ToList();
		}

		public CalendarEntry GetMemberNextShift(int memberID)
		{
			DateTime today = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
			return (from ce in db.CalendarEntry
			        where ce.MemberID == memberID && ce.EntryDate >= today && ce.CoverNeeded == 0
			        orderby ce.EntryDate
			        select ce).FirstOrDefault();
		}

		public void SetCalendarLastGenerateDate(DateTime upTo)
		{
			log.LogStart();
			string sql = string.Format("update Calendar set LastGenerated = NOW(), GeneratedUpTo ='{0}'", upTo.ToString("yyyy-MM-dd"));
			db.ExecuteCommand(sql);
		}

		public void Dispose()
		{
			db.Dispose();
		}

	}
}

