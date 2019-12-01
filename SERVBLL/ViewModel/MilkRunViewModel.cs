namespace SERVBLL.ViewModel
{
	public class MilkRunViewModel
	{
		public int RunLogId { get; set; }
		public int ControllerMemberId {get;set;}
		public int RiderMemberId {get;set;}
		public string RunDate {get;set;} 
		public string CollectTime {get;set;} 
		public string DeliverTime {get;set;} 
		public string HomeSafeTime {get;set;}
		public string VehicleType {get;set;} 
		public string CollectPostcode {get;set;} 
		public int CollectionLocationId {get;set;} 
		public int DeliverToLocationId {get;set;} 
		public string Notes { get; set; }

		public int CreatedByUserId { get; set; }
	}
}