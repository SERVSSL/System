using FluentAssertions;
using NUnit.Framework;
using SERV.Utils.Sms;

namespace Serv.Tests.ServUtils
{
    [TestFixture]
    public class AqlMessageBuilderTests
    {
        [Test]
        public void ShouldBuildMessageForSingleRecipients()
        {
            var classUnderTest = new AqlMessageBuilder();

            var result = classUnderTest.Build("447996123456", "sender", "this is a test");

            result.Should().Be("{\"destinations\":[\"447996123456\"],\"message\":\"this is a test\",\"originator\":\"sender\"}");
        }

        [Test]
        public void ShouldBuildMessageForMultipleRecipients()
        {
            var classUnderTest = new AqlMessageBuilder();

            var result = classUnderTest.Build("447996123456, 447886123123", "sender", "this is a test");

            result.Should().Be("{\"destinations\":[\"447996123456\",\"447886123123\"],\"message\":\"this is a test\",\"originator\":\"sender\"}");
        }
    }
}