using System;
using System.Security.Cryptography;
using SERVDAL;

namespace SERVBLL
{
	public class PasswordResetBLL
	{
		public string GetToken(string emailAddress)
		{
			using (var memberDal = new MemberDAL())
			{
				if (memberDal.GetByEmail(emailAddress)==null)
					return null;
			}
			using (var dal = new PasswordResetDal())
			{
				return dal.Create(emailAddress,GenerateToken());
			}
		}
		private string GenerateToken()
		{
			using (RandomNumberGenerator rng = new RNGCryptoServiceProvider())
			{
				var tokenData = new byte[32];
				rng.GetBytes(tokenData);
				return Convert.ToBase64String(tokenData);
			}
		}

		public string GetEmailByToken(string token)
		{
			using (var dal = new PasswordResetDal())
			{
				var passwordReset = dal.FindByToken(token);
				if (passwordReset == null)
					return null;
				dal.Delete(passwordReset);
				var age = DateTime.Now - passwordReset.CreateDate;
				return age.TotalHours>1 ? null : passwordReset.EmailAddress;
			}
		}
	}
}