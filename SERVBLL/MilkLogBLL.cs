using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using SERVBLL.Mappers;
using SERVBLL.ViewModel;
using SERVDAL;

namespace SERVBLL
{
	public class MilkLogBLL
	{
		private readonly IMilkRunMapper _mapper;

		public MilkLogBLL(IMilkRunMapper mapper)
		{
			_mapper = mapper;
		}

		public bool Save(MilkRunViewModel model)
		{
			const int humanMilkProductId = 5;
			var runLog = _mapper.Map(model);
			var prods = new List<int> { humanMilkProductId };
			return new RunLogDAL().CreateRunLog(runLog, prods) > 0;
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
	}
}