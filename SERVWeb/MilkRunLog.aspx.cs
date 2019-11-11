using System;

namespace SERVWeb
{
	public partial class MilkRunLog : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected string MemberName()
		{
			return "Joel";
			//return string.Format("{0} {1}", SERVGlobal.User.Member.LastName, SERVGlobal.User.Member.FirstName);
		}
	}
}