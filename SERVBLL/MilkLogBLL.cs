using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using SERVBLL.Mappers;
using SERVBLL.ViewModel;
using SERVDataContract;
using SERVDAL;
using RunLog = SERVDataContract.DbLinq.RunLog;

namespace SERVBLL
{
	public class MilkLogBLL
	{
		private readonly IMilkRunMapper _mapper;

		public MilkLogBLL(IMilkRunMapper mapper)
		{
			_mapper = mapper;
		}

		public bool Save(MilkRunViewModel model, User user)
		{
			const int humanMilkProductId = 5;
			model.CreatedByUserId = user.UserID;
			var runLog = _mapper.Map(model);
			var prods = new List<int> { humanMilkProductId };
			var dal = new RunLogDAL();
			var vehicleTypeId= dal.GetVehicleId(model.VehicleType);
			if (!vehicleTypeId.HasValue)
				throw new InvalidOperationException($"Unknown VehicleType [{model.VehicleType}] while trying to save milk run");
			runLog.VehicleTypeID = vehicleTypeId.Value;
			if (model.RunLogId==0)
			{
				return dal.CreateRunLog(runLog, prods) > 0;
			}

			var to = dal.Get(model.RunLogId);
			UpdatePropertyValues(runLog, to);
			return dal.Update(to);
		}

		private static void UpdatePropertyValues(RunLog source, RunLog destination)
		{
			destination.CollectDateTime = source.CollectDateTime;
			destination.CollectionLocationID = source.CollectionLocationID;
			destination.CollectionPostcode = source.CollectionPostcode;
			destination.ControllerMemberID = source.ControllerMemberID;
			destination.DeliverDateTime = source.DeliverDateTime;
			destination.DeliverToLocationID = source.DeliverToLocationID;
			destination.DutyDate = source.DutyDate;
			destination.FinalDestinationLocationID = source.FinalDestinationLocationID;
			destination.HomeSafeDateTime = source.HomeSafeDateTime;
			destination.Notes = source.Notes;
			destination.OriginLocationID = source.OriginLocationID;
			destination.RiderMemberID = source.RiderMemberID;
			destination.RunLogType = source.RunLogType;
			destination.VehicleTypeID = source.VehicleTypeID;
		}

		public MilkRunEditViewModel GetRunLogForEdit(string runLogId)
		{
			var dal = new RunLogDAL();
			var dataTable = dal.GetMilkRunLog(int.Parse(runLogId));
			var item = dataTable.AsEnumerable().Select(x =>
				new MilkRunEditViewModel
				{
					RunLogId = int.Parse(runLogId),
					Controller = x.Field<string>("Controller"),
					Rider = x.Field<string>("Rider"),
					DutyDate = x.Field<string>("DutyDate"),
					CollectTime = x.Field<string>("CollectTime"),
					DeliverTime = x.Field<string>("DeliverTime"),
					HomeSafeTime = x.Field<string>("HomeSafeTime"),
					Vehicle = x.Field<string>("Vehicle"),
					CollectionPostcode = x.Field<string>("CollectionPostcode"),
					CollectionHospital = x.Field<string>("CollectionHospital"),
					TakenTo = x.Field<string>("TakenTo"),
					Notes = x.Field<string>("Notes"),
				}).FirstOrDefault();

			dal.Dispose();
			return item;
		}

		public int? GetVehicleId(string vehicleType)
		{
			return new RunLogDAL().GetVehicleId(vehicleType);
		}
	}
}