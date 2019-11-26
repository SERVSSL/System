if (!window.Serv) Serv = {};

Serv.Milklog = {
    Initialise: function() {
        Serv.Milklog.InitialiseCalendar();
        Serv.Milklog.InitialiseLocationFields();
        listControllers(null);
        $(".controllers").autocomplete({ source: controllerNames });
        listMembersWithTag("Milk", null);
        $(".riders").autocomplete({ source: memberNames });
        writeVehicleTypes("lstVehicles", Serv.Milklog.VehicleSelected);
        Serv.Milklog.InitialisePostcodeField();
        $("#cmdSave").click(function() {
            Serv.Milklog.SaveRun();
        });
        _loaded();

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
        Serv.Milklog.SelectedVehicleId = vehicleTypeId;
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
    },
    SaveRun: function() {
        if (!Serv.Milklog.Validate()) {
            return;
        }
        var data = JSON.stringify(Serv.Milklog.GetDataForSave());
        callServerSide("Service/Service.asmx/LogMilkRun", data, Serv.Milklog.OnSave, Serv.Milklog.OnError);
    },
    GetDataForSave: function() {
        return {
            model: {
                controllerMemberId: getControllerId($("#txtController").val()),
                riderMemberId: getMemberId($("#txtRider").val()),
                runDate: $("#txtShiftDate").val(),
                collectTime: $("#txtPickupTime").val(),
                deliverTime: $("#txtDeliverTime").val(),
                homeSafeTime: $("#txtReturnTime").val(),
                vehicleTypeId: Serv.Milklog.SelectedVehicleId,
                collectPostcode: $("#txtCollectPostcode").val(),
                collectionLocationId: getLocationId($("#txtCollect").val()),
                deliverToLocationId: getLocationId($("#txtDrop").val()),
                notes: $("#txtNotes").val()
            }
        };
    },
    OnSave: function() {
        $("#successPanel").slideDown();
        $("#entry").slideUp();
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
        if (Serv.Milklog.SelectedVehicleId === 0) {
            niceAlert("What did the rider / driver travel on or in?");
            return false;
        }
        var collectResult = Serv.Milklog.CollectValidate($("#txtCollectPostcode").val(), $("#txtCollect").val());
        if (!collectResult.isvalid) {
            niceAlert(collectResult.errorMessage);
            return false;
        }
        var dropLocationId = getLocationId($("#txtDrop").val());
        if (dropLocationId === 0) {
            niceAlert("Where did we drop off?  You MUST choose an item from the list or type it exactly.");
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
    CollectValidate: function (collectPostcode, collectHospitalName) {
        var collectionLocationId = getLocationId(collectHospitalName);
        if (collectPostcode) {
            return { isvalid: true };
        } else if (collectionLocationId > 0) {
            return { isvalid: true };
        }
        return { isvalid: false, errorMessage: "Where did we collect? Must enter either a collection postcode or hospital" };
    },
    InitialiseLocationFields: function () {
        listLocations(null);
        $(".locations").autocomplete({ source: locationNames });
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