namespace SERV.Utils.Sms.Model
{
    public class SmsSendMessageResponse
    {
        public int MessagesSent { get; set; }
        public bool IsSuccess { get; set; }
        public string ErrorMessage { get; set; }
    }
}