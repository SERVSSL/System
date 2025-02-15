﻿using System;
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
			const int privateAddressLocationId = 19;
			if (!DateTime.TryParse(model.RunDate, out var dutyDate))
			{
				throw new ArgumentException($"RunDate {model.RunDate} is not a valid date");
			}

			var collectDateTime = ToDateTime(model.CollectTime, dutyDate);
			var deliverDateTime = ToDateTime(model.DeliverTime, dutyDate);
			var homeSafe = ToDateTime(model.HomeSafeTime, dutyDate);
			var collectionLocationId = string.IsNullOrWhiteSpace(model.CollectPostcode)
				? model.CollectionLocationId
				: privateAddressLocationId;

			var deliverToLocationId = string.IsNullOrWhiteSpace(model.DeliverToPostcode)
				? model.DeliverToLocationId
				: privateAddressLocationId;

			return new RunLog
			{
				RunLogType = "M",
				CreatedByUserID = model.CreatedByUserId,
				CreateDate = DateTime.Now,
				DutyDate = dutyDate,
				CollectionLocationID = collectionLocationId,
				CollectionPostcode = model.CollectPostcode,
				CollectDateTime = collectDateTime,
				DeliverDateTime = deliverDateTime,
				ControllerMemberID = model.ControllerMemberId,
				Urgency = 2,
				Notes = model.Notes,
				OriginLocationID = collectionLocationId,
				CallFromLocationID = 42,
				RiderMemberID = model.RiderMemberId,
				DeliverToLocationID = deliverToLocationId,
				DeliverToPostcode = model.DeliverToPostcode,
                FinalDestinationLocationID = deliverToLocationId,
				HomeSafeDateTime = homeSafe,
				Boxes = model.BoxQty
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