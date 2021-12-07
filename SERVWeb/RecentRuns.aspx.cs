
using System.Data;
using System.Web.UI.WebControls;

namespace SERVWeb
{
	using SERVBLL;
	using System;
	using System.Web;
	using System.Web.UI;

	public partial class RecentRuns : System.Web.UI.Page
	{

		protected override void OnLoad (EventArgs e)
		{
            if (!IsPostBack)
            {
                for (var year = DateTime.Now.Year; year >=2014 ; year--)
                {
                    RunYear.Items.Add(new ListItem(year.ToString(), year.ToString()));
                }
            }

            var selectedYear = RunYear.Items[RunYear.SelectedIndex].Value;
            SERVGlobal.AssertAuthentication();
			dgRecentRuns.DataSource = new RunLogBLL().Report_RunLog(selectedYear);
			dgRecentRuns.DataBind();
            if ((dgRecentRuns.DataSource as DataTable).Rows.Count==0)
            {
                runMessage.Text = "No runs for selected year";
            }
            else
            {
                runMessage.Text = "";
            }
		}

        //protected void itemSelected(object sender, EventArgs e)
        //{
        //    Response.Write("Getting clicked; " + sender.GetType().ToString());
        //    FileInfo selectedfile;
        //    Response.Write("<script>alert('Hello')</script>");
        //    foreach (FileInfo file in logs)
        //    {
        //        if (file.Name == logList.Items[logList.SelectedIndex].Text)
        //        {
        //            Response.Write("<script>alert('Hello')</script>");
        //        }
        //    }
        //}
    }
}

