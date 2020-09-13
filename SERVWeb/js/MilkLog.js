if (!window.Serv) Serv = {};

Serv.Milklog = {
    Initialise: function() {
        Serv.Milklog.InitialiseCalendar();
        Serv.Milklog.InitialiseLocationFields();
        Serv.Milklog.InitialiseBoxQty();
        listControllers(null);
        $(".controllers").autocomplete({ source: controllerNames });
        listMembersWithTag("Milk", null);
        $(".riders").autocomplete({ source: memberNames });
        writeVehicleTypes("lstVehicles", Serv.Milklog.VehicleSelected);
        Serv.Milklog.InitialisePostcodeField();
        $("#cmdSave").click(function() {
            Serv.Milklog.SaveRun();
        });
        keepAlive();
        _loaded();
        Serv.Milklog.WarnOnUnload();
    },
    SelectedVehicleId: 0,
    InitialiseCalendar: function() {
        var today = new Date();
        var tomorrow = new Date();
        tomorrow.setDate(today.getDate() + 1);
        $(".date").datepicker({ dateFormat: 'dd M yy', maxDate: tomorrow });
    },
    VehicleSelected: function (vehicleTypeId, vehicleType)
    {
        $("#btnVehicle").text(vehicleType);
    },
    WarnOnUnload: function()
    {
        window.onbeforeunload = function () { return 'You will lose all data you have entered!' };
    },
    InitialisePostcodeField: function() {
        $("#txtCollectPostcode").keypress(function(e) {
            var charInput = e.keyCode;
            if ((charInput >= 97) && (charInput <= 122)) { // lowercase
                if (!e.ctrlKey && !e.metaKey && !e.altKey) { // no modifier key
                    var newChar = charInput - 32;
                    var start = e.target.selectionStart;
                    var end = e.target.selectionEnd;
                    e.target.value = e.target.value.substring(0, start) + String.fromCharCode(newChar) + e.target.value.substring(end);
                    e.target.setSelectionRange(start + 1, start + 1);
                    e.preventDefault();
                }
            }
            if ($(this).val()) {
                $("#txtCollect").val("");
            }
        });
        $("#txtDropPostcode").keypress(function(e) {
            var charInput = e.keyCode;
            if ((charInput >= 97) && (charInput <= 122)) { // lowercase
                if (!e.ctrlKey && !e.metaKey && !e.altKey) { // no modifier key
                    var newChar = charInput - 32;
                    var start = e.target.selectionStart;
                    var end = e.target.selectionEnd;
                    e.target.value = e.target.value.substring(0, start) + String.fromCharCode(newChar) + e.target.value.substring(end);
                    e.target.setSelectionRange(start + 1, start + 1);
                    e.preventDefault();
                }
            }
            if ($(this).val()) {
                $("#txtDrop").val("");
            }
        });
    },
    InitialiseBoxQty: function() {
        if (!$("#txtBoxes").val() || $("#txtBoxes").val()==="0") {
            $("#txtBoxes").val(1);
        }
    },
    SaveRun: function () {
        $("#txtCollectPostcode").val($("#txtCollectPostcode").val().trim());
        $("#txtDropPostcode").val($("#txtDropPostcode").val().trim());
        Serv.Milklog.CleanTimes();
        if (!Serv.Milklog.Validate()) {
            return;
        }
        var data = JSON.stringify(Serv.Milklog.GetDataForSave());
        callServerSide("Service/Service.asmx/LogMilkRun", data, Serv.Milklog.OnSave, Serv.Milklog.OnError);
    },
    CleanTimes: function() {
        $("#txtPickupTime").val(Serv.Milklog.CleanTime($("#txtPickupTime").val()));
        $("#txtDeliverTime").val(Serv.Milklog.CleanTime($("#txtDeliverTime").val()));
        $("#txtReturnTime").val(Serv.Milklog.CleanTime($("#txtReturnTime").val()));
    },
    CleanTime: function (time) {
        if (!time) return "";
        if (/^\d{4}$/.test(time)) {
            return time.substring(0, 2) + ":" + time.substring(2);
        }
        time = time.replace('.', ':');
        time = time.replace(',', ':');
        return time;
    },
    GetDataForSave: function () {
        var runLogId = parseInt($("#txtRunLogId").val(), 10);
        return {
            model: {
                runLogId: runLogId,
                controllerMemberId: getControllerId($("#txtController").val()),
                riderMemberId: getMemberId($("#txtRider").val()),
                runDate: $("#txtShiftDate").val(),
                collectTime: $("#txtPickupTime").val(),
                deliverTime: $("#txtDeliverTime").val(),
                homeSafeTime: $("#txtReturnTime").val(),
                vehicleType: $("#btnVehicle").text(),
                collectPostcode: $("#txtCollectPostcode").val(),
                collectionLocationId: getLocationId($("#txtCollect").val()),
                deliverToLocationId: getLocationId($("#txtDrop").val()),
                deliverToPostcode: $("#txtDropPostcode").val(),
                boxQty: $("#txtBoxes").val(),
                notes: $("#txtNotes").val()
            }
        };
    },
    OnSave: function() {
        $("#successPanel").slideDown();
        const urlParams = new URLSearchParams(window.location.search);
        const runLogId = urlParams.get('RunLogID');
        if (runLogId) {
            $("#btnAdd").hide();
            $("#editmessage").show();
            $("#viewedit").attr("href", "/MilkRunLog.aspx?RunLogID="+runLogId);
        } else {
            $("#btnEdit").hide();
        }
        $("#entry").slideUp();
        window.onbeforeunload = null;
    },
    OnError: function (xhr, ajaxOptions, thrownError) {
        niceAlert("Warning Data not saved. Please try again and if that does not work contact tech support via the forum");
    },
    Validate: function() {
        var controllerId = getControllerId($("#txtController").val());
        if (controllerId === 0) {
            niceAlert("You need to choose a Controller.  You MUST choose an item from the list or type it exactly.");
            return false;
        }
        var riderId = getMemberId($("#txtRider").val());
        if (riderId === 0) {
            niceAlert("You need to choose a Rider.  You MUST choose an item from the list or type it exactly.");
            return false;
        }
        if ($("#txtShiftDate").val() === "") {
            niceAlert("What shift date are you logging against?");
            return false;
        }
        if (!Serv.Milklog.IsValidTime($("#txtPickupTime").val())) {
            niceAlert("Please use 24 hour HH:MM time formats (Collect Time)");
            return false;
        }
        if (!Serv.Milklog.IsValidTime($("#txtDeliverTime").val())) {
            niceAlert("Please use 24 hour HH:MM time formats (Deliver Time)");
            return false;
        }
        if (!Serv.Milklog.IsValidTime($("#txtReturnTime").val())) {
            niceAlert("Please use 24 hour HH:MM time formats (Home Safe Time)");
            return false;
        }

        if ($("#txtPickupTime").val() >= $("#txtDeliverTime").val()) {
            niceAlert("Deliver time should be after Collect time");
            return false;
        }
        if ($("#txtDeliverTime").val() >= $("#txtReturnTime").val()) {
            niceAlert("Home Safe time should be after Deliver time");
            return false;
        }

        if (!$("#btnVehicle").text() || $("#btnVehicle").text() === "Select the vehicle") {
            niceAlert("What did the rider / driver travel on or in?");
            return false;
        }
        var collectResult = Serv.Milklog.LocationValidate($("#txtCollectPostcode").val(), $("#txtCollect").val(), "collect");
        if (!collectResult.isvalid) {
            niceAlert(collectResult.errorMessage);
            return false;
        }
        var takentoResult = Serv.Milklog.LocationValidate($("#txtDropPostcode").val(), $("#txtDrop").val(), "takento");
        if (!takentoResult.isvalid) {
            niceAlert(takentoResult.errorMessage);
            return false;
        }
        if ($("#txtBoxes").val()<1) {
            niceAlert("How many boxes did we carry?");
            return false;
        }

        return true;
    },
    IsValidTime: function(timeValue) {
        if (!timeValue) {
            return false;
        }
        if (/^([01]\d|2[0-3]):([0-5]\d)$/.test(timeValue)) {
            return true;
        }
        return false;
    },
    LocationValidate: function (postcode, hospitalName, collectDeliver) {
        var locationId = getLocationId(hospitalName);
        if (postcode) {
            if (postcode.length > 1 && postcode.length < 5) {
                return { isvalid: true };
            }
            return { isvalid: false, errorMessage: collectDeliver === "collect" ? "Collection postcode should be between 1 and 4 characters long" : "Taken to postcode should be between 1 and 4 characters long" };
        } else if (locationId > 0) {
            return { isvalid: true };
        }
        return { isvalid: false, errorMessage: collectDeliver === "collect" ? "Where did we collect? Must enter either a collection postcode or hospital" : "Where did we take to? Must enter either a taken to postcode or hospital" };
    },
    InitialiseLocationFields: function () {
        listLocations(null);
        $("#txtDrop").autocomplete({
            source: locationNames, change: function (event, ui) {
                if ($(this).val()) {
                    $("#txtDropPostcode").val("");
                }
            }
        });
        $("#txtCollect").autocomplete({
            source: locationNames, change: function (event, ui) {
                if ($(this).val()) {
                    $("#txtCollectPostcode").val("");
                }
            }
        });

    }
};


Serv.Milklog.Initialise();