namespace SERVBLL.ViewModel
{
	public class MilkRunViewModel
	{
		public int ControllerMemberId {get;set;}
		public int RiderMemberId {get;set;}
		public string RunDate {get;set;} 
		public string CollectTime {get;set;} 
		public string DeliverTime {get;set;} 
		public string HomeSafeTime {get;set;}
		public int VehicleTypeId {get;set;} 
		public string OriginPostcode {get;set;} 
		public int OriginLocationId {get;set;} 
		public int DeliverToLocationId {get;set;} 
		public string Notes { get; set; }

		public int CreatedByUserId { get; set; }
	}
}