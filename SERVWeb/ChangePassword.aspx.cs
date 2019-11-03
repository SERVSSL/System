using System;
using SERVBLL;

namespace SERVWeb
{

	public partial class ChangePassword : System.Web.UI.Page
	{

		protected override void OnLoad (EventArgs e)
		{
			SERVGlobal.AssertAuthentication();
		}

		protected void cmdChangeClick (object src, EventArgs e)
		{
			var newPassword = txtNewPassword.Text.Trim();
			if (newPassword.Length<8)
			{
				SetErrorMessage("New password must be at least eight characters long");
				return;
			}

			if (newPassword != txtNewPassword2.Text.Trim())
			{
				SetErrorMessage("New password and confirm password do not match");
				return;
			}

			var emailAddress = SERVGlobal.User.Member.EmailAddress.Trim().ToLower();
			var u = new Service().Login(emailAddress, SERV.Utils.Authentication.Hash(emailAddress + txtOldPassword.Text));
			if (u==null)
			{
				SetErrorMessage("Old password entered incorrectly");
				return;
			}
			new MemberBLL().SetPassword(u.Member.EmailAddress, SERV.Utils.Authentication.Hash(newPassword + txtNewPassword.Text.Trim()));
			Response.Redirect("Home.aspx?success=yes");
		}

		private void SetErrorMessage(string message)
		{
			litErrors.Text = string.Format("<script>niceAlert('{0}');</script>", message);
		}
	}
}

