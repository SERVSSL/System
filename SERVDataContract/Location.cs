using System;
using System.Runtime.Serialization;

namespace SERVDataContract
{
	[DataContract]
	[Serializable]
	public class Location
	{

		public Location()
		{
		}

		public Location(SERVDataContract.DbLinq.Location metal)
		{
			this.LocationID = metal.LocationID;
			this.LocationName = metal.Location1;
			this.BloodBank = metal.BloodBank;
			this.ChangeOver = metal.Changeover;
			this.Enabled = metal.Enabled;
			this.Hospital = metal.Hospital;
			this.Lat = metal.Lat;
			this.Lng = metal.Lng;
			this.InNetwork = metal.InNetwork;
			this.PostCode = metal.PostCode;
            this.What3Words = metal.What3Words;
        }

		[DataMember]
		public int LocationID {get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public string LocationName {get;set;}

		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public string Location1 {get { return LocationName; }}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public sbyte BloodBank {get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public sbyte ChangeOver {get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public sbyte Changeover {get { return ChangeOver; }}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public sbyte Hospital {get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public sbyte Enabled {get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public string Lat {get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public string Lng {get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public string PostCode {get;set;}

        [DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public string What3Words { get;set;}

		[DataMember]
		[UpdatePolicy(MinRequiredLevel = UserLevel.Controller)]
		public sbyte InNetwork {get;set;}
    }
}

