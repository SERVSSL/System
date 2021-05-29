using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace SERV.Utils.Sms
{
    public class AqlMessageBuilder
    {
        public string Build(string to, string from, string message)
        {
            var smsMessage = new SmsMessage {Message = message, Originator = from};
            smsMessage.Destinations = to.Replace(" ","").Split(',');
            var settings = new JsonSerializerSettings();
            settings.ContractResolver = new CamelCasePropertyNamesContractResolver();
            return JsonConvert.SerializeObject(smsMessage, settings);
        }
    }

    public class SmsMessage
    {
        public string[] Destinations { get; set; }
        public string Message { get; set; }
        public string Originator { get; set; }
    }
}