using System;
using System.Runtime.Serialization;
using SERV.Utils;

namespace SERVDataContract
{

	public enum UserLevel
	{
		None,
		Volunteer,
		Controller,
		Committee,
		Admin
	}

	public enum MessageType
	{
		None,
		Email,
		SMS
	}

	[DataContract]
	[Serializable]
	public class User
    {

		public User(){}

		public User(SERVDataContract.DbLinq.User metal)
		{
			PropertyMapper.MapProperties(metal, this);
			this.Member = new Member();
			PropertyMapper.MapProperties(metal.Member, this.Member);
		}

		public int UserID { get; set; }
		public int MemberID { get; set; }
		public Member Member { get; set; }
		public int UserLevelID { get; set; }
		public DateTime? LastLoginDate { get; set; }

    }
}

