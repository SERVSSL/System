using System;
using SERVBLL;
using SERVBLL.Mappers;

namespace SERVWeb
{
	public partial class MilkRunLog : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected string MemberName()
		{
			return SERVGlobal.User == null
				? null
				: $"{SERVGlobal.User.Member.LastName} {SERVGlobal.User.Member.FirstName}";
		}

		protected override void OnLoad(EventArgs e)
		{
			SERVGlobal.AssertAuthentication();
			if (IsAdding())
			{
				SERVGlobal.AssertAuthentication((int)SERVDataContract.UserLevel.Controller, "Sorry, only controllers and above have access to contribute to the controller log.");
				return;
			}
			var editModel = new MilkLogBLL(new MilkRunMapper()).GetRunLogForEdit(Request["RunLogID"]);
		}

		private bool IsAdding()
		{
			return Request["RunLogID"] == null 
			       || !int.TryParse(Request["RunLogID"], out _);
		}
	}
}