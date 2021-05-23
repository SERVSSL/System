using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using Newtonsoft.Json;
using SERV.Utils.Sms.Model;

namespace SERV.Utils.Sms
{

    public interface ISmsService
    {
        bool SendMessage(string to, string from, string message);
        SmsCreditCountResponse GetCreditCount();
    }

    public class AqlSmsService : ISmsService
    {
        private readonly string _authToken;
        private readonly Logger _logger;

        public AqlSmsService()
        {
            _authToken = ConfigurationManager.AppSettings["AqlToken"];
            _logger = new Logger();
        }

        public bool SendMessage(string to, string from, string message)
        {
            var requestMessage = new AqlMessageBuilder().Build(to, from, message);
            var client = new WebClient();
            client.Headers.Add(HttpRequestHeader.ContentType, "application/json");
            client.Headers.Add("x-auth-token", _authToken);
            
            string json;
            try
            {
                json = client.UploadString("https://api.aql.com/v2/sms/send", "POST", requestMessage);
            }
            catch (Exception ex)
            {
                _logger.Error($"Error Sending SMS via AQL. Body is [{requestMessage}]", ex);
                return false;
            }
            _logger.Debug($"AQL Send Response [{json}]");
            //var response = JsonConvert.DeserializeObject<SmsSendResponse>(json);
            return true;
        }

        public SmsCreditCountResponse GetCreditCount()
        {
            var client = new WebClient();
            client.Headers.Add(HttpRequestHeader.ContentType, "application/json");
            client.Headers.Add("x-auth-token", _authToken);
            string json;
            try
            {
                json = client.DownloadString("https://api.aql.com/v2/sms/credit");
            }
            catch (Exception ex)
            {
                _logger.Error("Error getting AQL Credit Count", ex);
                return new SmsCreditCountResponse
                    {ErrorMessage = "Error getting credit count from AQL, check log for details"};
            }
            var response = JsonConvert.DeserializeObject<CreditCountResponse>(json);
            return new SmsCreditCountResponse {CreditCount = response.Data.Credit, IsSuccess = true};
        }
    }

    internal class SmsSendResponse
    {
        public IList<Datum> Data { get; set; }
        public Meta Meta { get; set; }
    }

    internal class Meta
    {
        public Pagination Pagination { get; set; }
    }

    internal class Datum
    {
        public long Id { get; set; }
        public string Source { get; set; }
        public string Destination { get; set; }
        public string Received { get; set; }
        public string Scheduled_delivery { get; set; }
        public string Original_scheduled_delivery { get; set; }
        public string Data { get; set; }
        public string State { get; set; }
    }

    internal class Pagination
    {
        public int Total { get; set; }
        public int Count { get; set; }
        public int Per_page { get; set; }
        public int Current_page { get; set; }
        public int Total_pages { get; set; }
        public IList<object> Links { get; set; }
    }

    internal class CreditCountResponse
    {
        public Data Data { get; set; }
    }

    internal class Data
    {
        public int Credit { get; set; }
    }

}