using System.Configuration;
using System.Diagnostics;

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

        public int GetCreditCount()
        {
            var process = new Process();
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.FileName = "/usr/bin/curl";
            process.StartInfo.Arguments = $"-i -H \"Accept: application/json\" -H \"Content-Type: application/json\" -H \"x-auth-token: {_authToken}\" https://api.aql.com/v2/sms/credit";
            process.Start();
            var output = process.StandardOutput.ReadToEnd();
            process.WaitForExit();
            System.IO.File.WriteAllText("/tmp/smsdump", output);
            return 0;
        }
    }
}