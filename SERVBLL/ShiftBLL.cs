using System;
using SERVDataContract;

namespace SERVBLL
{
	public class ShiftBLL
	{

		static Logger log = new Logger();
		const int CONTROLLER_THRESHOLD_HOUR = 16;

		public ShiftBLL()
		{
		}

		public int Create(DateTime shiftStartDate, int dutyType)
		{
			throw new NotImplementedException();
		}

		public void SetOnDuty(int memberID, DateTime shiftStartDate, VehicleType vehicle, int maxBoxes, string currentLocation, int useUntilHour, string mobileNumber, int dutyType)
		{
		}
			
		public bool TakeControl(int memberID, string overrideNumber)
		{
			log.LogStart();
			User u = new MemberBLL().GetUserForMember(memberID);
			Member m = new MemberBLL().Get(memberID);
			bool ret = new ControllerBLL().DivertNumber(m, overrideNumber);
			if (ret)
			{
				log.Info("Informing controller . . .");
				new MessageBLL().SendSMSMessage(m.MobileNumber, string.Format("Hi {0}, You now have control", m.FirstName), u.UserID, true);
			}
			return ret;
		}

		public Member GetCurrentController()
		{
			Member c = null;
			if (DateTime.Now.Hour > CONTROLLER_THRESHOLD_HOUR)
			{
				c = new CalendarBLL().GetCurrentNightController();
			}
			else
			{
				c = new CalendarBLL().GetCurrentDayController();
			}
			return c;
		}

		public string SwitchController()
		{
			var c = GetCurrentController();
			if (TakeControl(c.MemberID, null))
			{
				return c.Name;
			}
			else
			{
				return "???";
			}
		}
	}
}

