using System;
using SERVDataContract.DbLinq;

namespace SERVDAL
{
	public class MessageDAL
	{

		private SERVDataContract.DbLinq.SERVDB db;
		static Logger log = new Logger();

		public MessageDAL()
		{
			db = new SERVDataContract.DbLinq.SERVDB(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
		}

		public void LogSentSMSMessage(string numbers, string message, int senderUserID)
		{
			try
			{
				Message m = new Message();
				m.Message1 = message;
				m.SenderUserID = senderUserID;
				m.Recipient = numbers;
				m.MessageTypeID = (int)SERVDataContract.MessageType.SMS;
				m.SentDate = DateTime.Now;
				m.RecipientMemberID = null;
				db.Message.InsertOnSubmit(m);
				db.SubmitChanges();
			}
			catch(Exception e)
			{
				log.Error(e.Message, e);
			}
		}

		public void LogSentEmailMessage(string address, string message, int senderUserID)
		{
			try
			{
				Message m = new Message();
				m.Message1 = message;
				m.SenderUserID = senderUserID;
				m.Recipient = address;
				m.MessageTypeID = (int)SERVDataContract.MessageType.Email;
				m.SentDate = DateTime.Now;
				m.RecipientMemberID = null;
				db.Message.InsertOnSubmit(m);
				db.SubmitChanges();
			}
			catch(Exception e)
			{
				log.Error(e.Message, e);
			}
		}

		public void Dispose()
		{
			db.Dispose();
		}

	}
}

