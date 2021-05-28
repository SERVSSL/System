
namespace SERVWeb
{
	using System;

	public partial class SMS : System.Web.UI.Page
	{

		protected override void OnLoad (EventArgs e)
		{
			SERVGlobal.AssertAuthentication((int)SERVDataContract.UserLevel.Controller, "Sorry, you don't have access to the Bulk SMS tool.");
		}
	}
}

