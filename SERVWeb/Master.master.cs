
namespace SERVWeb
{
    using System;

    public partial class Master : System.Web.UI.MasterPage
    {
		protected override void OnLoad (EventArgs e)
		{
			if (Request["NoTopMenu"] != null)
			{
				topControl.Visible = false;
			}
		}
    }
}

