using System;
using System.Net;
using System.Threading;
using System.Web;
using log4net;

namespace SERVWeb
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            try
            {
                var ex = Server.GetLastError();
                //Response Redirect can generate this error
                if (ex is ThreadAbortException)
                    return;

                var exception = ex as HttpException;
                if (exception != null)
                {
                    if (exception.GetHttpCode() == (int)HttpStatusCode.NotFound ||
                        exception.GetHttpCode() == (int)HttpStatusCode.Forbidden)
                    {
                        // don't log these client based HttpExceptions
                        return;
                    }
                }

                ILog log = LogManager.GetLogger("SERV");
                log.Error("Unhandled exception Application_Error", ex);
            }
            catch (Exception )
            {
                //ignore any exception introduced by logging
            }

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}