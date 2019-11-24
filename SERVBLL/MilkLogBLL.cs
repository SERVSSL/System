using System.Collections.Generic;
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
	}
}