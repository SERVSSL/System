if (!window.Serv) Serv = {};

Serv.Milklog = {
    Initialise: function() {
        Serv.Milklog.InitialiseCalendar();
        listLocations(null);
        $(".locations").autocomplete({ source: locationNames });
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
        $("#txtOriginPostcode").keypress(function(e) {
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
        });
    },
    SaveRun: function() {
        if (!Serv.Milklog.Validate()) {
            return;
        }
        niceAlert("You pressed Save");
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
        if (!isValidTime($("#txtPickupTime").val())) {
            niceAlert("Please use 24 hour HH:MM time formats (Collect Time)");
            return false;
        }
        if (!isValidTime($("#txtDeliverTime").val())) {
            niceAlert("Please use 24 hour HH:MM time formats (Deliver Time)");
            return false;
        }
        if (!isValidTime($("#txtReturnTime").val())) {
            niceAlert("Please use 24 hour HH:MM time formats (Home Safe Time)");
            return false;
        }
        if (Serv.Milklog.SelectedVehicleId === 0) {
            niceAlert("What did the rider / driver travel on or in?");
            return false;
        }
        var originResult = Serv.Milklog.OriginValidate($("#txtOriginPostcode").val(), $("#txtOrigin").val());
        if (!originResult.isvalid) {
            niceAlert(originResult.errorMessage);
            return false;
        }
        var dropLocationId = getLocationId($("#txtDrop").val());
        if (dropLocationId === 0) {
            niceAlert("Where did we drop off?  You MUST choose an item from the list or type it exactly.");
            return false;
        }

        return true;

    },
    OriginValidate: function(originPostcode, originHospitalName) {
        var originLocationId = getLocationId(originHospitalName);
        if (originPostcode) {
            return { isvalid: true };
        } else if (originLocationId > 0) {
            return { isvalid: true };
        }
        return { isvalid: false, errorMessage: "Where did we collect? Must enter either a pickup postcode or hospital" };
    }
};


Serv.Milklog.Initialise();