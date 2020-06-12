using NUnit.Framework;
using SERV.Utils.Sms;

namespace Serv.Tests
{
    [TestFixture]
    public class SmsTests
    {
        [Test]
        public void GetCreditCountTest()
        {
            var classUnderTest = new AqlSmsService();

            var result = classUnderTest.GetCreditCount();
        }

        [Test]
        public void SendMessageTest()
        {
            var classUnderTest = new AqlSmsService();

            var result = classUnderTest.SendMessage("447966143353,447581588277", "Joel TEST", "This is a test");
        }
    }
}