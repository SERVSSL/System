using System;
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using Newtonsoft.Json;
using SERV.Utils.Sms.Model;

namespace SERV.Utils.Sms
{
    public class CurlSmsService : ISmsService
    {
        private readonly string _authToken;
        private readonly Logger _logger;

        public CurlSmsService()
        {
            _authToken = ConfigurationManager.AppSettings["AqlToken"];
            _logger = new Logger();
        }

        public bool SendMessage(string to, string @from, string message)
        {
            throw new System.NotImplementedException();
        }

        public SmsCreditCountResponse GetCreditCount()
        {
            var rawResponse =  CallAqlApi();
            var statusCode = GetStatusCode(rawResponse);
            if (statusCode == null)
            {
                return new SmsCreditCountResponse {ErrorMessage = "Invalid API response, check logs for details"};
            }
            if (statusCode.Substring(0, 1) != "2")
            {
                _logger.Error($"AQL status code was [{statusCode}], response was [{rawResponse}]", null);
                return new SmsCreditCountResponse {ErrorMessage = $"Received status code {statusCode} from AQL, check logs for details" };
            }
            var json = GetJson(rawResponse);
            if (json == null)
            {
                return new SmsCreditCountResponse { ErrorMessage = "Invalid API response body, check logs for details" };
            }
            var response = JsonConvert.DeserializeObject<CreditCountResponse>(json);

            return new SmsCreditCountResponse {IsSuccess = true, CreditCount = response.Data.Credit};
        }

        private string CallAqlApi()
        {
            var process = new Process();
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.FileName = "/usr/bin/curl";
            process.StartInfo.Arguments =
                $"-i -H \"Accept: application/json\" -H \"Content-Type: application/json\" -H \"x-auth-token: {_authToken}\" https://api.aql.com/v2/sms/credit";
            process.Start();
            var output = process.StandardOutput.ReadToEnd();
            process.WaitForExit();
            _logger.Debug("CurlSmsService.GetCreditCount output\n" + output + "\n");
            return output;
        }

        private string GetJson(string output)
        {
            var pos = output.IndexOf("\r\n\r\n");
            if (pos == -1)
            {
                _logger.Error($"Cannot find json body in AQL response error. Response is [{output}]", null);
                return null;
            }
            var json = output.Substring(pos + 4);
            return json;
        }

        private string GetStatusCode(string output)
        {
            var firstLine = output.Split(new[] { '\r', '\n' }).FirstOrDefault();
            if (firstLine == null || !firstLine.Any())
            {
                _logger.Error($"Cannot find status code from http response message from AQL [{output}]", null);
                return null;
            }
            var parts = firstLine.Split(new[] { ' ' });
            if (parts.Length != 3)
            {
                _logger.Error($"Cannot find status code from first line. http response message from AQL [{output}]", null);
                return null;
            }
            return parts[1];
        }

    }
}