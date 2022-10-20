using System;
using System.Collections.Generic;
using SERVDataContract;

namespace SERVBLL
{
	public class ControllerBLL
	{

		static Logger log = new Logger();

		private const int SCHEDULED_RUN_HOUR = 22;

		public ControllerBLL()
		{
		}

		public int OrderRun(int requestorMemberId, RunLog order, List<int> products)
		{
			new RunLogBLL().CreateOrder(order, products);
			throw new NotImplementedException();
		}

		public void ProcessQueuedOrders()
		{
			List<RunLog> queue = new RunLogBLL().ListQueuedOrders();
			foreach (RunLog order in queue)
			{
				// See if rider needs to be assigned
				// decide on bike / car / hooleygan based on number of boxes, time and final destination
				// Choose rider from on shift resources
				// Request rider
				// Set rider id on order and save
			}
		}

		public void CheckActiveRunsProgress()
		{
			// Check for delayed pickups, drop offs, home safes
			// raise exception to human
		}

		public void HandleIncomingMessage(Message message)
		{
			// List all orders which have the riderid assigned, parse and process
		}

		public bool DivertNumber(Member member, string overrideNumber)
		{
			string number = string.IsNullOrEmpty(overrideNumber) ? member.MobileNumber : overrideNumber;
			return DivertNumber(number);
		}

		public bool DivertNumber(string mobile)
		{
			log.LogStart();
			System.Net.ServicePointManager.ServerCertificateValidationCallback += SERV.Utils.Authentication.AcceptAllCertificates;
			var num = mobile.Replace(" ","");
			var servNow = System.Configuration.ConfigurationManager.AppSettings["FlextelNumber"];
			var pin = System.Configuration.ConfigurationManager.AppSettings["FlextelPin"];
			var format = System.Configuration.ConfigurationManager.AppSettings["FlextelFormat"];
			var mainDivertOk =  DivertSingleNumber(num, format, servNow, pin);
            var servNow2 = System.Configuration.ConfigurationManager.AppSettings["FlextelNumber2"];
            var pin2 = System.Configuration.ConfigurationManager.AppSettings["FlextelPin2"];
            var secondDivertOk = DivertSingleNumber(num, format, servNow2, pin2);
            return mainDivertOk && secondDivertOk;
        }

        private static bool DivertSingleNumber(string num, string format, string servNow, string pin)
        {
            try
            {
                log.Info("Diverting flextel [" + servNow+"] to [" + num+"]");
                var res = new System.Net.WebClient().DownloadString(string.Format(format, servNow, pin, num));
                if (res==null)
                {
                    log.Info("Flextel result is null");
                }
                log.Info("Flextel result: ["+ res + "]");
                res = res.Trim();
                if (res.Contains(","))
                {
                    return res.Split(',')[0].Replace(" ", "") == num;
                }

                return false;
            }
            catch (Exception ex)
            {
                log.Error("Flextel send error", ex);
                return false;
            }
        }
    }
}

