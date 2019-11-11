if (!window.Serv) Serv = {};

Serv.Milklog = {
    Initialise: function () {
        Serv.Milklog.InitialiseCalendar();
        $(".locations").autocomplete({ source: locationNames });
    },
    InitialiseCalendar: function() {
        var today = new Date();
        var tomorrow = new Date();
        tomorrow.setDate(today.getDate() + 1);
        $(".date").datepicker({ dateFormat: 'dd M yy', maxDate: tomorrow });
    }
};


Serv.Milklog.Initialise();