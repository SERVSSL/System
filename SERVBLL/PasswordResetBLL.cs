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
	}
}