using System;
using System.Linq;
using SERVDataContract.DbLinq;

namespace SERVDAL
{
	public class PasswordResetDal : IDisposable
	{
		private readonly SERVDB _db;

		public PasswordResetDal()
		{
			_db = new SERVDB(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
		}
		
		public string Create(string emailAddress, string token)
		{
			var passwordReset = new PasswordReset();
			passwordReset.EmailAddress = emailAddress;
			passwordReset.CreateDate = DateTime.Now;
			passwordReset.Token = token;
			_db.PasswordReset.InsertOnSubmit(passwordReset);
			_db.SubmitChanges();
			return passwordReset.Token;
		}

		public void Dispose()
		{
			_db.Dispose();
		}

		public PasswordReset FindByToken(string token)
		{
			return _db.PasswordReset.FirstOrDefault(x => x.Token == token);
		}

		public void Delete(PasswordReset passwordReset)
		{
			_db.PasswordReset.DeleteOnSubmit(passwordReset);
			_db.SubmitChanges();
		}
	}
}