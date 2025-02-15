using System;
using System.Collections.Generic;
using SERVDataContract.DbLinq;
using System.Data;
using SERV.Utils.Data;
using System.Linq;

namespace SERVDAL
{

	public class MemberDAL: IDisposable
	{

		static Logger log = new Logger();
		private SERVDataContract.DbLinq.SERVDB db;

		public MemberDAL()
		{
			db = new SERVDataContract.DbLinq.SERVDB(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
		}

		public Member Get(int memberId)
		{
			SERVDataContract.DbLinq.Member mem = (from m in db.Member where m.MemberID == memberId select m).FirstOrDefault();
			return mem;
		}

		public Member GetSystemController()
		{
			SERVDataContract.DbLinq.Member mem = (from m in db.Member where m.SystemController == 1 select m).FirstOrDefault();
			return mem;
		}

		public Member GetByEmail(string email)
		{
			SERVDataContract.DbLinq.Member mem = (from m in db.Member where m.EmailAddress == email select m).FirstOrDefault();
			return mem;
		}

		public Member GetByUserID(int userID)
		{
			SERVDataContract.DbLinq.Member mem = (from u in db.User where u.UserID == userID select u.Member).FirstOrDefault();
			return mem;
		}
		
		public int Create(Member member)
		{
			log.LogStart();
			db.Member.InsertOnSubmit(member);
			db.SubmitChanges();
			return member.MemberID;
		}

		public int Save(Member newclass)
		{
			throw new NotImplementedException();
		}

		public int Update(Member member)
		{
			log.LogStart();
			db.Log = Console.Out;
			db.SubmitChanges();
			db.Log = null;
			return member.MemberID;
		}

		public List<Member> List(string search, bool onlyActive = true)
		{
			List<Member> ret = new List<Member>();
			if (onlyActive)
			{
				ret = (from m in db.Member
				       where (m.FirstName.Contains(search) || m.LastName.Contains(search)) && m.LeaveDate == null
				       orderby m.LastName
				       select m).ToList();
			}
			else
			{
				ret = (from m in db.Member
				       where (m.FirstName.Contains(search) || m.LastName.Contains(search))
				       orderby m.LeaveDate, m.LastName
				       select m).ToList();
			}
			return ret;
		}

		public List<Tag> ListMemberTags(int memberId)
		{
			throw new NotImplementedException();
		}
		
		public void AddMemberTag(int memberId, string tagName)
		{
			log.LogStart();
			string sql = string.Format("insert into Member_Tag values ({0}, {1})", memberId, GetTagId(tagName));
			db.ExecuteCommand(sql);
		}
		
		public void RemoveMemberTag(int memberId, string tagName)
		{
			log.LogStart();
			string sql = string.Format("delete from Member_Tag where MemberID = {0} and TagID = {1}", memberId, GetTagId(tagName));
			db.ExecuteCommand(sql);
		}

		private int GetTagId(string tagName)
		{
			return Convert.ToInt32(DBHelperFactory.DBHelper().ExecuteScalar("select TagID from Tag where Tag = " + SERV.Utils.String.DBSafeString(tagName)));
		}

		public User GetUserForMember(int memberId)
		{
			SERVDataContract.DbLinq.User ret = (from u in db.User where u.Member.MemberID == memberId select u).FirstOrDefault();
			if (ret == null) { return null; }
			return ret;
		}

		public int GetUserIdForMember(int memberId)
		{
			return (from u in db.User
			       where u.Member.MemberID == memberId
				select u.UserID).FirstOrDefault();
		}

		public User Login(string username, string passwordHash)
		{
			var ret = (from u in db.User where u.Member.EmailAddress == username && u.Member.LeaveDate==null select u).FirstOrDefault();
			if (ret == null) { return null; }
			if (!String.IsNullOrEmpty(ret.PasswordHash))
			{
				if (passwordHash == ret.PasswordHash)
				{
					return ret;
				}

                return null;
            }

            var comp = SERV.Utils.Authentication.Hash(ret.Member.EmailAddress.ToLower().Trim() + ret.Member.MobileNumber);
            if (passwordHash == comp)
            {
                return ret;
            }
            return null;
		}

		public void SetPasswordHash(string username, string passwordHash)
		{
			log.LogStart();
			SERVDataContract.DbLinq.User ret = (from u in db.User where u.Member.EmailAddress == username select u).FirstOrDefault();
			ret.PasswordHash = passwordHash;
			db.SubmitChanges();
		}
		
		public void SetUserLastLoginDate(User u)
		{
			u.LastLoginDate = DateTime.Now;
			db.SubmitChanges();
		}

		public List<string> ListMobileNumbersWithTag(string tag)
		{
			var ret = new List<string>();
			var sql = "select distinct m.MobileNumber " +
                      "from Member m " +
                      "join Member_Tag mt on mt.MemberID = m.MemberID " +
                      "join Tag t on t.TagID = mt.TagID " +
                      "and m.LeaveDate is null " +
                      "and m.LastGDPGMPDate > DATE_SUB(NOW(),INTERVAL 3 YEAR) " +
                      "where t.Tag = '" + tag + "'";
			DataTable tbl = DBHelperFactory.DBHelper().ExecuteDataTable(sql);
			if (tbl != null && tbl.Rows.Count > 0)
			{
				foreach (DataRow r in tbl.Rows)
				{
					ret.Add(r[0].ToString());
				}
			}
			return ret;
		}

		public List<string> ListMobileNumbersWithAnyTagsIn(string tagsCsv)
		{
			List<string> ret = new List<string>();
			string[] tags = tagsCsv.Split(',');
			List<string> tagList = new List<string>();
			foreach (string tag in tags)
			{
				if (tag.Trim() != string.Empty) { tagList.Add(tag); }
			}
			string inClause = "in (";
			foreach (string t in tagList)
			{
				inClause += "'" + t.Trim() + "',";
			}
			inClause = inClause.Substring(0, inClause.Length - 1);
			inClause += ")";
			string sql = "select distinct m.MobileNumber " +
			             "from Member m " +
			             "join Member_Tag mt on mt.MemberID = m.MemberID " +
			             "join Tag t on t.TagID = mt.TagID " +
			             "and m.LeaveDate is null " +
			             "where t.Tag " + inClause;
			DataTable tbl = DBHelperFactory.DBHelper().ExecuteDataTable(sql);
			if (tbl != null && tbl.Rows.Count > 0)
			{
				foreach (DataRow r in tbl.Rows)
				{
					ret.Add(r[0].ToString());
				}
			}
			return ret;
		}

		public List<Member> ListMembersWithAnyTagsIn(string tagsCsv)
		{
			tagsCsv = tagsCsv.Replace("'", "").Replace("\"","");
			string[] tags = tagsCsv.Split(',');
			List<string> tagList = new List<string>();
			foreach (string tag in tags)
			{
				if (tag.Trim() != string.Empty) { tagList.Add(tag); }
			}
			string inClause = "in (";
			foreach (string t in tagList)
			{
				inClause += string.Format("'{0}',", t.Trim());
			}
			inClause = string.Format("{0})", inClause.Substring(0, inClause.Length - 1));
			string sql = string.Format("select distinct m.MemberID, m.FirstName, m.LastName " +
				"from Member m join Member_Tag mt on mt.MemberID = m.MemberID " +
				"join Tag t on t.TagID = mt.TagID " +
				"where t.Tag {0} " +
				"and m.LeaveDate is null " +
				"order by m.LastName", inClause);
			return db.ExecuteQuery<Member>(sql).ToList();
		}

		public List<Member> ListAdministrators()
		{
			string sql = "select distinct m.MemberID, m.FirstName, m.LastName, m.EmailAddress from Member m " + 
				"join User u on u.MemberID = m.MemberID where u.UserLevelID = " + (int)SERVDataContract.UserLevel.Admin + " order by m.LastName";
			return db.ExecuteQuery<Member>(sql).ToList();
		}
		public List<Member> GetMembersByEmail(IEnumerable<string> emails)
		{
			var whereClause = string.Join(",", emails.Select(x => $"'{x}'"));

			var sql = "select distinct m.MemberID, m.FirstName, m.LastName, m.EmailAddress from Member m " + 
                      $"where m.EmailAddress in ({whereClause}) order by m.LastName";
			return db.ExecuteQuery<Member>(sql).ToList();
		}

		public void SetMemberUserLevel(int memberId, int userLevelId)
		{
			string sql = string.Format("Update User set UserlevelID = {0} where MemberID = {1}", userLevelId, memberId);
			db.ExecuteCommand(sql);
		}

		public void GoOnDuty(int memberId)
		{
			string sql = "update Member set OnDuty = 1 where memberId = " + memberId;
			db.ExecuteCommand(sql);
		}

		public void GoOffDuty(int memberId)
		{
			string sql = "update Member set OnDuty = 0 where memberId = " + memberId;
			db.ExecuteCommand(sql);
		}

		public void UpdateLocation(int memberId, string lat, string lng)
		{
			string sql = string.Format("update Member set LastLat = '{0}', LastLng = '{1}' where memberId = {2}", lat, lng, memberId);
			db.ExecuteCommand(sql);
		}

		public void Dispose()
		{
			db.Dispose();
		}

	}

}
