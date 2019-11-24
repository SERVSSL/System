using SERVBLL.Mappers;
using SERVBLL.ViewModel;

namespace SERVBLL
{
	public class MilkLogBLL
	{
		private  IMilkRunMapper _mapper;

		public bool Save(MilkRunViewModel model)
		{
			var runLog = _mapper.Map(model);
			return true;
		}
	}
}