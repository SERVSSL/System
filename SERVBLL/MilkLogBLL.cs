using System.Collections.Generic;
using System.Data;
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
			var dt = dal.GetMilkRunLog(int.Parse(runLogId));
			dt.Rows[0].
			foreach (DataColumn dataColumn in dt.Columns)
			{
				dataColumn.
			}
			return null;
		}
	}
}