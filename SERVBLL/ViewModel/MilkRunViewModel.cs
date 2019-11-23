namespace SERVBLL.ViewModel
{
	public class MilkRunViewModel
	{
		public int ControllerMemberId {get;set;}
		public int RiderMemberId {get;set;}
		public string RunDate {get;set;} 
		public string collectTime {get;set;} 
		public string deliverTime {get;set;} 
		public string homeSafeTime {get;set;}
		public int vehicleTypeId {get;set;} 
		public string originPostcode {get;set;} 
		public int originLocationId {get;set;} 
		public int deliverToLocationId {get;set;} 
		public string notes { get; set; }
	}
}