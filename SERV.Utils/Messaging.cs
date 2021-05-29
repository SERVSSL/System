#define DYNMARK

using System.Configuration;
using SERV.Utils.Sms;
using SERV.Utils.Sms.Model;

namespace SERV.Utils
{
	public class Messaging
	{

		static Logger log = new Logger();

		public static SmsSendMessageResponse SendTextMessage(string to, string message)
		{
			var smsFrom = ConfigurationManager.AppSettings["SMSFrom"];
			return SendTextMessage(to, message, smsFrom);
		}

		public static SmsSendMessageResponse SendTextMessage(string to, string message, string from)
		{
            from = from.Replace(" ", "");
            to = to.Replace(" ", "");
            if (from.StartsWith("07")) { from = "44" + from.Substring(1, from.Length - 1); }
            if (to.StartsWith("07")) { to = "44" + to.Substring(1, to.Length - 1); }
            message = message.Replace("\r", " ").Replace("\n", " ").Replace("\t", " ");
            string provider = System.Configuration.ConfigurationManager.AppSettings["SMSProvider"];
            log.Info(string.Format("SMS using {0} To {1} - {2}", provider, to, message));
            if (provider == "Curl")
            {
                var curlService = new CurlSmsService();
                return curlService.SendMessage(to, from, message);
            }
            var service = new AqlSmsService();
            return service.SendMessage(to, from, message);
        }

		public static SmsCreditCountResponse GetAqlCreditCount()
		{
            var provider = ConfigurationManager.AppSettings["SMSProvider"];
            if (provider=="Curl")
            {
                var curlService = new CurlSmsService();
                return curlService.GetCreditCount();
            }
            var service = new AqlSmsService();
            return service.GetCreditCount();
		}
	}
}

