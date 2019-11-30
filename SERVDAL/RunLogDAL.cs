using System;
using System.Collections.Generic;
using SERVDataContract.DbLinq;
using System.Data;
using SERV.Utils.Data;
using System.Linq;

namespace SERVDAL
{
	public class RunLogDAL
	{
		private SERVDataContract.DbLinq.SERVDB db;

		public RunLogDAL()
		{
			db = new SERVDataContract.DbLinq.SERVDB(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
		}

		public RunLog Get(int runLogID)
		{
			return (from rl in db.RunLog
			        where rl.RunLogID == runLogID
				select rl).FirstOrDefault();
		}

		public void SetAcceptedDateTime(int runLogId)
		{
			RunLog l = (from rl in db.RunLog where rl.RunLogID == runLogId select rl).FirstOrDefault();
			l.AcceptedDateTime = DateTime.Now;
			db.SubmitChanges();
		}

		public List<RunLog> ListQueuedOrders()
		{
			return (from rl in db.RunLog where rl.AcceptedDateTime == null && rl.RiderMemberID == null
				orderby rl.CallDateTime descending
				select rl).ToList();
		}

		public List<RunLog> ListQueuedOrdersForMember(int memberID)
		{
			return (from rl in db.RunLog where rl.AcceptedDateTime == null && rl.RiderMemberID == memberID
				orderby rl.CallDateTime descending
				select rl).ToList();
		}
	
		public List<RunLog> ListRecent(int recent)
		{
			return (from rl in db.RunLog where rl.DeliverDateTime != null
				orderby rl.CallDateTime descending
			        select rl).Take(recent).ToList();
		}

		public List<RunLog> ListYesterdays()
		{
			List<RunLog> ret = (from rl in db.RunLog
			        where rl.DeliverDateTime != null
			            //&& rl.CallDateTime >= new DateTime(DateTime.Now.AddDays(-1).Year, DateTime.Now.AddDays(-1).Month, DateTime.Now.AddDays(-1).Day) &&
			            //rl.CallDateTime < new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 13, 00,00)
				orderby rl.CallDateTime descending
				select rl).Take(100).ToList(); // This is a complete hack until I can get the commented out clause above working :S
			return (from rl in ret
			        where rl.DutyDate >= new DateTime(DateTime.Now.AddDays(-1).Year, DateTime.Now.AddDays(-1).Month, DateTime.Now.AddDays(-1).Day) &&
			            rl.DutyDate < new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day)
			        select rl).ToList();
		}

		public bool CreateRawRecord(RawRunLog raw)
		{
			db.RawRunLog.InsertOnSubmit(raw);
			db.SubmitChanges();
			return true;
		}

		public void CreateRawRecords(List<RawRunLog> records)
		{
			foreach (RawRunLog r in records)
			{
				db.RawRunLog.InsertOnSubmit(r);
			}
			db.SubmitChanges();
		}

		public int CreateRunLog(RunLog log, List<int> prods)
		{
			db.RunLog.InsertOnSubmit(log);
			db.SubmitChanges();
			LinkRunLogToProducts(log, prods);
			return log.RunLogID;
		}

		public void DeleteRunLog(int runLogID)
		{
			RunLog d = Get(runLogID);
			foreach (RunLogProduct rlp in d.RunLogProduct)
			{
				db.RunLogProduct.DeleteOnSubmit(rlp);
			}
			db.RunLog.DeleteOnSubmit(d);
			db.SubmitChanges();
		}

		private void LinkRunLogToProducts(RunLog log, List<int> prods)
		{
			Dictionary<int, int> prodD = new Dictionary<int, int>();
			foreach (int p in prods)
			{
				if (prodD.ContainsKey(p))
				{
					prodD[p] = prodD[p] + 1;
				}
				else
				{
					prodD.Add(p, 1);
				}
			}
			foreach (int p in prodD.Keys)
			{
				RunLogProduct rlp = new RunLogProduct();
				rlp.ProductID = p;
				rlp.RunLogID = log.RunLogID;
				rlp.Quantity = prodD[p];
				log.Description += string.Format("{0} x {1} ", prodD[p], (from prod in db.Product
				                                                          where prod.ProductID == p
				                                                          select prod).FirstOrDefault().Product1);
				db.RunLogProduct.InsertOnSubmit(rlp);
			}
			db.SubmitChanges();
		}

		public void TruncateRawRunLog()
		{
			db.ExecuteCommand("truncate table RawRunLog");
		}

		public DataTable GetMemberUniqueRuns(int memberID)
		{
			string sql = "select distinct l.Location, p.Product from RunLog rl " +
				"join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID " +
				"join Product p on rlp.ProductID = p.ProductID " +
				"join Location l on l.LocationID = rl.DeliverToLocationID " +
				"where rl.RiderMemberID = " + memberID + " " +
				"order by Location";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		public DataTable RunReport(SERVDataContract.Report report)
		{
			return DBHelperFactory.DBHelper().ExecuteDataTable(report.Query);
		}

		public DataTable ExecuteSQL(string sql)
		{
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		/*

		public DataTable Report_RecentRunLog()
		{
			string sql = 
				"SELECT " +
					"date(CallDate) as Date, " +
					"TIME(rpad(replace(CallTime, '.',':'), 5, '0')) as Time, " +
					"CONCAT(m.FirstName, ' ', m.LastName) as Rider, " +
					"Consignment, " +
					"CollectFrom as Origin, " +
					"Destination, " +
					"CONCAT(con.FirstName, ' ', con.LastName) as Controller " +
				"FROM RawRunLog rr " +
					"LEFT JOIN Member m on rr.Rider = (CONCAT(m.LastName, ' ', m.FirstName)) " +
					"LEFT JOIN Member con on rr.Controller = (CONCAT(con.LastName, ' ', con.FirstName)) " +
				"order by CallDate desc, RawRunLogID desc " +
				"LIMIT 100;";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		public DataTable Report_Top10Riders()
		{
			string sql = 
				"select Name from " +
				"(select CONCAT(m.FirstName, ' ', m.LastName) Name, count(*) Runs " +
				"from RunLog rl " +
				"LEFT join Member m on m.MemberID = rl.RiderMemberID " +
				"group by Name " +
				"order by Runs desc " +
				"LIMIT 10) top " +
				"order by Name;";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		public DataTable Report_Top102013Riders()
		{
			string sql = 
				"select Name from " +
				"(select CONCAT(m.FirstName, ' ', m.LastName) Name, count(*) Runs " +
				"from RawRunLog rr " +
				"LEFT join Member m on rr.Rider = (CONCAT(m.LastName, ' ', m.FirstName)) " +
				"where m.FirstName is not null " +
				"group by Name " +
				"order by Runs desc " +
				"LIMIT 10) sub " +
				"order by Name;";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		public DataTable Report_RunButNoLogin()
		{
			string sql = "select CONCAT(m.FirstName, ' ', m.LastName) as Rider, date(m.JoinDate) as Joined, m.EmailAddress as Email, date(max(rr.CallDate)) as LastRun, count(*) as Runs " +
			             "from RawRunLog rr  " +
			             "LEFT join Member m on rr.Rider = (CONCAT(m.LastName, ' ', m.FirstName))  " +
			             "where m.MemberID not in " +
			             "(select m.MemberID from User u join Member m on m.MemberID = u.MemberID where u.lastLoginDate is not null) " +
			             "and rr.CallDate > '2013-05-01' " +
			             "and m.LeaveDate is null " +
			             "group by m.MemberID " +
			             "order by max(rr.CallDate) desc;";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		public DataTable Report_AverageCallsPerDay()
		{
			string sql = "SELECT dayname(case when Hour(CallTime) > 17 then CallDate else AddDate(CallDate, -1) end) as ShiftDay " +
			             ", round(count(*) / 34.28) as AverageCalls " +
			             //", ceil((count(*) / @weeks) * @riderfactor) as RidersRequired " +
			             "FROM RawRunLog " +
			             "WHERE CallDate > AddDate(CURRENT_DATE, -240) " +
			             "AND(Consignment like '%blood%' " +
			             "or Consignment like '%plate%' " +
			             "or Consignment like '%plas%' " +
			             "or Consignment like '%ffp%' " +
			             "or Consignment like '%sample%' " +
			             "or Consignment like '%drugs%' " +
			             "or Consignment like '%cd%' " +
			             "or Consignment like '%data%' " +
			             "or Consignment like '%disk%' " +
			             "or Consignment like '%disc%' " +
			             "or Consignment like '%package%') " +
			             "GROUP BY dayname(case when Hour(CallTime) > 17 then CallDate else AddDate(CallDate, -1) end) " +
			             "ORDER BY dayofweek(case when Hour(CallTime) > 17 then CallDate else AddDate(CallDate, -1) end);";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		public DataTable Report_CallsPerHourHeatMap()
		{
			string sql = "select dayname(case when Hour(CallTime) > 17 then CallDate else AddDate(CallDate, -1) end) as Day, " +
						"Hour(CallTime) as Hour, count(*) as Calls " +
						"from RawRunLog " +
						"WHERE CallDate > AddDate(CURRENT_DATE, -240) " +
						"AND Hour(CallTime) >= 0 AND Hour(CallTime) <= 23 " +
						"AND(Consignment like '%blood%' " +
						"or Consignment like '%plate%' " +
						"or Consignment like '%plas%' " +
						"or Consignment like '%ffp%' " +
						"or Consignment like '%sample%' " +
						"or Consignment like '%drugs%' " +
						"or Consignment like '%cd%' " +
						"or Consignment like '%data%' " +
						"or Consignment like '%disk%' " +
						"or Consignment like '%disc%' " +
						"or Consignment like '%package%') " +
			             "group by dayname(case when Hour(CallTime) > 17 then CallDate else AddDate(CallDate, -1) end), Hour(CallTime) " +
			             "ORDER BY dayofweek(case when Hour(CallTime) > 17 then CallDate else AddDate(CallDate, -1) end), Hour(CallTime)";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		public DataTable Report_TodaysUsers()
		{
			string sql = "select CONCAT(m.FirstName, ' ', m.LastName) as Member " +
				"from User u join Member m on m.MemberID = u.MemberID where u.lastLoginDate > CURRENT_DATE() " +
				"order by lastLoginDate desc;";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}



		public DataTable Report_BoxesByProductByMonth()
		{
			string sql = "select concat(MONTHNAME(rl.DutyDate), ' ', year(rl.DutyDate)) as Month " +
			             ", p.Product, sum(rlp.Quantity) as BoxesCarried from RunLog rl " +
			             "join RunLog_Product rlp on rlp.RunLogID = rl.RunLogID " +
			             "join Product p on p.ProductID = rlp.ProductID " +
			             "group by Month, Product " +
			             "order by month(rl.DutyDate), Product;";
			return DBHelperFactory.DBHelper().ExecuteDataTable(sql);
		}

		*/

		public DataTable Report_RunLog()
		{
			string sql = "select RunLogID as ID, date_format(DutyDate, '%Y-%m-%d') as 'DutyDate', " +
				"coalesce(date_format(CallDateTime, '%Y-%m-%d %H:%i'), 'N/A') as 'CallDateTime', cf.Location as 'CallFrom', " +
			    "CASE WHEN rl.RunLogType='M' THEN Concat(cl.Location,' ', rl.CollectionPostcode) ELSE cl.Location END 'From', " +
				"dl.Location as 'To', coalesce(date_format(rl.CollectDateTime, '%H:%i'), 'NOT ACCEPTED') as Collected, " +
				"date_format(rl.DeliverDateTime, '%H:%i') as Delivered, " +
			             //"timediff(rl.DeliverDateTime, rl.CollectDateTime) as 'Run Time', " +
			             "fl.Location as 'Destination', concat(m.FirstName, ' ', m.LastName) as Rider, " +
			             "v.VehicleType as 'Vehicle', rl.Description as 'Consignment', " +
			             "concat(c.FirstName, ' ', c.LastName) as Controller from RunLog rl " +
			             "left join Member m on m.MemberID = rl.RiderMemberID " +
			             "join Member c on c.MemberID = rl.ControllerMemberID " +
			             "join Location cf on cf.LocationID = rl.CallFromLocationID " +
			             "join Location cl on cl.LocationID = rl.CollectionLocationID " +
			             "join Location dl on dl.LocationID = rl.DeliverToLocationID " +
			             "join Location fl on fl.LocationID = rl.FinalDestinationLocationID " +
			             "left join VehicleType v on v.VehicleTypeID = rl.VehicleTypeID " +
			             "where DutyDate > '2016-12-31' or CallDateTime > '2016-12-31' " +
			             "order by rl.DutyDate desc, rl.CallDateTime desc;";
			DataTable ret = DBHelperFactory.DBHelper().ExecuteDataTable(sql);
			return ret;
		}

		public DataTable GetMilkRunLog(int runLogId)
		{
			var sql = $@"select concat(cm.FirstName, ' ', cm.LastName) as Controller, concat(rm.FirstName, ' ', rm.LastName) as Rider,
	DATE_FORMAT(rl.DutyDate,'%d %b %Y') as DutyDate, DATE_FORMAT(rl.CollectDateTime,'%H:%i') as CollectTime, DATE_FORMAT(rl.DeliverDateTime,'%H:%i') as DeliverTime,DATE_FORMAT(rl.HomeSafeDateTime,'%H:%i') as HomeSafeTime,v.VehicleType as 'Vehicle',rl.CollectionPostcode,
	cl.Location as 'CollectionHospital', dl.Location as 'TakenTo', rl.Notes
	from RunLog rl 
	 left join Member rm on rm.MemberID = rl.RiderMemberID 
	 left join Member cm on cm.MemberID = rl.ControllerMemberID
	 left join VehicleType v on v.VehicleTypeID = rl.VehicleTypeID
	 left join Location cl on cl.LocationID = rl.CollectionLocationID
	 left join Location dl on dl.LocationID = rl.DeliverToLocationID
	where RunLogID={runLogId} and RunLogType='M'";
			return ExecuteSQL(sql);
		}

		public void Dispose()
		{
			db.Dispose();
		}

	}
}

