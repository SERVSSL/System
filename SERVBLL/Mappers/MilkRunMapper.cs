using System;
using SERVBLL.ViewModel;
using SERVDataContract.DbLinq;

namespace SERVBLL.Mappers
{
	public interface IMilkRunMapper
	{
		RunLog Map(MilkRunViewModel model);
	}

	public class MilkRunMapper : IMilkRunMapper
	{
		public RunLog Map(MilkRunViewModel model)
		{
			if (!DateTime.TryParse(model.RunDate, out var dutyDate))
			{
				throw new ArgumentException($"RunDate {model.RunDate} is not a valid date");
			}

			var collectDateTime = ToDateTime(model.CollectTime, dutyDate);
			var deliverDateTime = ToDateTime(model.DeliverTime, dutyDate);
			var homeSafe = ToDateTime(model.HomeSafeTime, dutyDate);

			return new RunLog
			{
				CreatedByUserID = model.CreatedByUserId,
				CreateDate = DateTime.Now,
				DutyDate = dutyDate,
				CollectionLocationID = model.CollectionLocationId,
				CollectDateTime = collectDateTime,
				DeliverDateTime = deliverDateTime,
				FinalDestinationLocationID = model.DeliverToLocationId,
				ControllerMemberID = model.ControllerMemberId,
				Urgency = 2,
				VehicleTypeID = model.VehicleTypeId,
				Notes = model.Notes,
				OriginLocationID = model.CollectionLocationId,
				CallFromLocationID = 42,
				RiderMemberID = model.RiderMemberId,
				DeliverToLocationID = model.DeliverToLocationId,
				HomeSafeDateTime = homeSafe,
				Boxes = 1
			};
		}

		private static DateTime ToDateTime(string time, DateTime dutyDate)
		{
			var hour = Convert.ToInt32(time.Substring(0, 2));
			var collectDateTime = dutyDate.AddHours(hour);
			var minute = Convert.ToInt32(time.Substring(3, 2));
			collectDateTime = collectDateTime.AddMinutes(minute);
			return collectDateTime;
		}
	}
}