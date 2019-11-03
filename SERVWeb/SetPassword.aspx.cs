using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SERVBLL;

namespace SERVWeb
{
	public partial class SetPassword : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			hdnToken.Value = Request.QueryString["t"];
			if (string.IsNullOrEmpty(hdnToken.Value))
				Response.Redirect("Home.aspx");
		}

		protected void cmdChangeClick(object src, EventArgs e)
		{
			var newPassword = txtNewPassword.Text.Trim();
			if (newPassword.Length < 8)
			{
				errMessage.InnerText = "Password must be at least 8 characters";
				return;
			}
			if (newPassword != txtConfirmPassword.Text.Trim())
			{
				errMessage.InnerText = "Passwords do not match";
				return;
			}
			var token = hdnToken.Value;
			var passwordResetBll = new PasswordResetBLL();
			var emailAddress = passwordResetBll.GetEmailByToken(token);
			if (emailAddress==null)
			{
				resetform.Visible = false;
				errorPlaceHolderContent.Visible = true;
				return;
			}
			new MemberBLL().SetPassword(emailAddress, SERV.Utils.Authentication.Hash(emailAddress.ToLower().Trim() + newPassword));
			success.Visible = true;
			resetform.Visible = false;
		}
	}
}