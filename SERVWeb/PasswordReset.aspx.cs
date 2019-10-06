
namespace SERVWeb
{
	using SERVBLL;
	using System;

	public partial class PasswordReset : System.Web.UI.Page
	{

		protected void cmdResetClick(object src, EventArgs e)
		{
			var emailAddress = txtEmail.Text.Trim();
			if (emailAddress == string.Empty) { return; }

			var passwordResetBll = new PasswordResetBLL();
			var token = passwordResetBll.GetToken(emailAddress);

			if (token == null)
				return;
			new MemberBLL().SendPasswordReset(emailAddress, token);
			Response.Redirect("Login.aspx");
		}

	}
}

