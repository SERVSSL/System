﻿using System;
using FluentAssertions;
using NUnit.Framework;
using Ploeh.AutoFixture;
using SERVBLL.Mappers;
using SERVBLL.ViewModel;

namespace Serv.Tests.SERVBLL.Mappers
{
	[TestFixture]
	public class MilkRunMapperTests
	{
		private MilkRunMapper _classUnderTest;
		private Fixture _fixture;
		private MilkRunViewModel _input;

		[SetUp]
		public void Setup()
		{
			_fixture = new Fixture();
			_classUnderTest = new MilkRunMapper();
			_input = _fixture.Build<MilkRunViewModel>()
				.With(x => x.RunDate, "07 Nov 2019")
				.With(x => x.CollectTime, "23:11")
				.With(x=>x.DeliverTime, "01:35")
				.With(x=>x.HomeSafeTime, "13:25")
				.Create();
		}

		[Test]
		public void ShouldMapCreatedByUserId()
		{
			_input.CreatedByUserId =  123;
			var result = _classUnderTest.Map(_input);
			result.CreatedByUserID.Should().Be(123);
		}

		[Test]
		public void ShouldMapCreateDate()
		{
			var now = DateTime.Now;
			var result = _classUnderTest.Map(_input);
			result.CreateDate.Should().BeCloseTo(now);
		}

		[Test]
		public void ShouldMapDutyDate()
		{
			var result = _classUnderTest.Map(_input);
			result.DutyDate.Should().Be(new DateTime(2019, 11, 7, 0, 0, 0));
		}

		[Test]
		public void ShouldThrow_When_DutyDate_Not_A_Date()
		{
			_input.RunDate = "xx Nov 2019";
			Action act = () => _classUnderTest.Map(_input);
			act.ShouldThrow<ArgumentException>();
		}

		[Test]
		public void ShouldMapCallDateTimeNull()
		{
			var result = _classUnderTest.Map(_input);
			result.CallDateTime.Should().BeNull();
		}

		[Test]
		public void ShouldMapCollectionLocationId_WhenCollectPostcodeIsNull()
		{
			_input.CollectionLocationId = 222;
			_input.CollectPostcode = null;
			var result = _classUnderTest.Map(_input);
			result.CollectionLocationID.Should().Be(222);
		}

		[Test]
		public void ShouldMapCollectionLocationId_WhenCollectPostcodeIsEmpty()
		{
			_input.CollectionLocationId = 222;
			_input.CollectPostcode = "";
			var result = _classUnderTest.Map(_input);
			result.CollectionLocationID.Should().Be(222);
		}

		[Test]
		public void ShouldMapCollectionLocationId_WhenCollectPostcodeIsWhiteSpace()
		{
			_input.CollectionLocationId = 222;
			_input.CollectPostcode = "  ";
			var result = _classUnderTest.Map(_input);
			result.CollectionLocationID.Should().Be(222);
		}

		[Test]
		public void ShouldMapCollectDateTime()
		{
			var result = _classUnderTest.Map(_input);
			result.CollectDateTime.Should().Be(new DateTime(2019,11,7,23,11,0));
		}

		[Test]
		public void ShouldMapDeliverDateTime()
		{
			var result = _classUnderTest.Map(_input);
			result.DeliverDateTime.Should().Be(new DateTime(2019,11,7,01,35,0));
		}

		[Test]
		public void ShouldMapFinalDestinationLocationId_When_DeliverToPostcodeIsNull()
		{
			_input.DeliverToLocationId = 234;
            _input.DeliverToPostcode = null;
			var result = _classUnderTest.Map(_input);
			result.FinalDestinationLocationID.Should().Be(234);
		}

		[Test]
		public void ShouldMapFinalDestinationLocationId_To_PrivateAddress_When_DeliverToPostcode()
		{
            const int privateAddressLocationId = 19;
			_input.DeliverToLocationId = 234;
            _input.DeliverToPostcode = "GU14";
			var result = _classUnderTest.Map(_input);
			result.FinalDestinationLocationID.Should().Be(privateAddressLocationId);
		}

		[Test]
		public void ShouldMapControllerMemberId()
		{
			_input.ControllerMemberId = 123;
			var result = _classUnderTest.Map(_input);
			result.ControllerMemberID.Should().Be(123);
		}

		[Test]
		public void ShouldMapUrgency()
		{
			var result = _classUnderTest.Map(_input);
			result.Urgency.Should().Be(2);
		}

		[Test]
		public void ShouldMapIsTransfer()
		{
			var result = _classUnderTest.Map(_input);
			result.IsTransfer.Should().Be(0);
		}

		[Test]
		public void ShouldNotMapIsVehicleTypeId()
		{
			var result = _classUnderTest.Map(_input);
			result.VehicleTypeID.HasValue.Should().BeFalse();
		}

		[Test]
		public void ShouldMapNotes()
		{
			_input.Notes = "hello world";
			var result = _classUnderTest.Map(_input);
			result.Notes.Should().Be("hello world");
		}

		[Test]
		public void ShouldMapOriginLocationId_To_CollectionLocationID_When_CollectPostcodeEmpty()
		{
			_input.CollectionLocationId = 333;
			_input.CollectPostcode = string.Empty;
			var result = _classUnderTest.Map(_input);
			result.OriginLocationID.Should().Be(333);
		}

		[Test]
		public void ShouldMapCallFromLocationId()
		{
			var result = _classUnderTest.Map(_input);
			result.CallFromLocationID.Should().Be(42);
		}

		[Test]
		public void ShouldMapRiderMemberId()
		{
			_input.RiderMemberId = 27;
			var result = _classUnderTest.Map(_input);
			result.RiderMemberID.Should().Be(27);
		}

		[Test]
		public void ShouldMapDeliverToLocationId_WhenDeliverToPostcodeIsNull()
		{
			_input.DeliverToLocationId = 42;
            _input.DeliverToPostcode = null;
			var result = _classUnderTest.Map(_input);
			result.DeliverToLocationID.Should().Be(42);
		}

        [Test]
		public void ShouldMapDeliverToLocationId_WhenDeliverToPostcodeIsEmpty()
		{
			_input.DeliverToLocationId = 42;
            _input.DeliverToPostcode = "";
			var result = _classUnderTest.Map(_input);
			result.DeliverToLocationID.Should().Be(42);
		}

        [Test]
		public void ShouldMapDeliverToLocationId_WhenDeliverToPostcodeIsWhitespace()
		{
			_input.DeliverToLocationId = 42;
            _input.DeliverToPostcode = "  ";
			var result = _classUnderTest.Map(_input);
			result.DeliverToLocationID.Should().Be(42);
		}

		[Test]
		public void ShouldMapHomeSafeDateTime()
		{
			var result = _classUnderTest.Map(_input);
			result.HomeSafeDateTime.Should().Be(new DateTime(2019, 11, 7, 13, 25, 0));
		}

		[Test]
		public void ShouldMapBoxes()
        {
            _input.BoxQty = 2;
			var result = _classUnderTest.Map(_input);
			result.Boxes.Should().Be(2);
		}

		[Test]
		public void ShouldMapDescriptionNull()
		{
			var result = _classUnderTest.Map(_input);
			result.Description.Should().BeNull();
		}

		[Test]
		public void ShouldMapCallerNumberNull()
		{
			var result = _classUnderTest.Map(_input);
			result.CallerNumber.Should().BeNull();
		}

		[Test]
		public void ShouldMapCallerExtNull()
		{
			var result = _classUnderTest.Map(_input);
			result.CallerExt.Should().BeNull();
		}

		[Test]
		public void ShouldMapAcceptedDateTimeNull()
		{
			var result = _classUnderTest.Map(_input);
			result.AcceptedDateTime.Should().BeNull();
		}

		[Test]
		public void ShouldMapRunLogType()
		{
			var result = _classUnderTest.Map(_input);
			result.RunLogType.Should().Be("M");
		}

		[Test]
		public void ShouldMapCollectionPostcode()
		{
			_input.CollectPostcode = "GU14";
			var result = _classUnderTest.Map(_input);
			result.CollectionPostcode.Should().Be("GU14");
		}

		[Test]
		public void ShouldMapCollectionLocationID_To_PrivateAddress_WhenCollectionPostcode()
		{
			const int privateAddressLocationId = 19;
			_input.CollectPostcode = "GU14";
			_input.CollectionLocationId = 1;
			var result = _classUnderTest.Map(_input);
			result.CollectionLocationID.Should().Be(privateAddressLocationId);
		}

		[Test]
		public void ShouldMapOriginLocationID_To_PrivateAddress_WhenCollectionPostcode()
		{
			const int privateAddressLocationId = 19;
			_input.CollectPostcode = "GU14";
			_input.CollectionLocationId = 1;
			var result = _classUnderTest.Map(_input);
			result.OriginLocationID.Should().Be(privateAddressLocationId);
		}

        [Test]
        public void ShouldMapDeliverToPostcode()
        {
            _input.DeliverToPostcode = "GU14";
            var result = _classUnderTest.Map(_input);
            result.DeliverToPostcode.Should().Be("GU14");
        }

        [Test]
        public void ShouldMapDeliverToLocationID_To_PrivateAddress_WhenDeliverToPostcode()
        {
            const int privateAddressLocationId = 19;
            _input.DeliverToPostcode = "GU14";
            _input.DeliverToLocationId = 1;
            var result = _classUnderTest.Map(_input);
            result.DeliverToLocationID.Should().Be(privateAddressLocationId);
        }

	}
}