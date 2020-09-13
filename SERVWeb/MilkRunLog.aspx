<%@ Page Language="C#" AutoEventWireup="true" Inherits="SERVWeb.MilkRunLog" MasterPageFile="~/Master.master" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ MasterType VirtualPath="~/Master.master" %>

<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Controller Log - Milk</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

<div id="successPanel" style="display:none" class="hero-unit">
    <h2>Success!</h2>	
    <p><span id="successMessage">Super . . .</span> <span style="display:none" id="editmessage">you updated <a onclick="window.onbeforeunload=null;" id="viewedit">this record</a></span></p>	
    <button id="btnAdd" type="button" class="btn btn-primary" onclick="window.location.reload();">Enter another</button>
    <button id="btnEdit" type="button" class="btn btn-primary" onclick="window.location.href = '/RecentRuns.aspx';">Back to Run Log</button>
</div>

    <div id="entry" >
        <h3>Controller Log - Milk Runs</h3>        
        
        <div class="row">
            <div class="span4 input-prepend">
                <button type="button" class="btn" onclick="" id="btnBloodRun" disabled>Controller</button>
                <input type="text" id="txtController" style="width:150px" class="controllers" placeholder="Choose the controller" /> 
            </div>
        </div>
        <br/>


        <div class="row">
            <input type="hidden" id="txtRunLogId" value="<%=Model.RunLogId%>" />
            <fieldset>

                <div id="Milk">
                    <div class="span4">

                        <label>Rider / Driver:</label>
                        <input type="text" id="txtRider" class="riders" placeholder="Choose the rider / driver" />
                        
                        <label>Run Date:</label>
                        <input type="text" id="txtShiftDate" class="date" autocomplete="off" />

                        <label>Collect Time:</label>
                        <input type="text" id="txtPickupTime" placeholder="HH:MM" />

                        <label>Deliver Time:</label>
                        <input type="text" id="txtDeliverTime" placeholder="HH:MM" />

                        <label>Home Safe Time:</label>
                        <input type="text" id="txtReturnTime" placeholder="HH:MM" />
                        <br/><br/>
                    </div>
                    
                    <div class="span4">
                        <label>Vehicle:</label>
                        <div class="btn-group">
                            <button type="button" class="btn" disabled id="btnVehicle">Select the vehicle</button>
                            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                            <ul class="dropdown-menu" id="lstVehicles">
                            </ul>
                        </div>
                        <br/><br/>
                        
                        <label>Collect from postcode:</label>
                        <input type="text" id="txtCollectPostcode" placeholder="First half of postcode" />

                        <label>Collect from hospital:</label>
                        <input type="text" id="txtCollect" placeholder="Type and Choose" />
                        
                        <label>Taken to postcode:</label>
                        <input type="text" id="txtDropPostcode" placeholder="First half of postcode" />

                        <label>Taken to hospital:</label>
                        <input type="text" id="txtDrop" placeholder="Type and Choose" />

                        <label>Number of boxes:</label>
                        <input type="text" id="txtBoxes" />

                        <label>Notes:</label>
                        <textarea id="txtNotes" maxlength="599" data-bind="value: vm.Notes"></textarea>

                    </div>

                 </div>
            </fieldset>
        </div>
        
        <hr/>
        <div class="row">
            <div class="span6">
                <button type="button" class="btn btn-primary btn-lg readOnlyHidden" id="cmdSave"><i class="icon-ok icon-white"></i> Save Run</button> 
            </div>
            <div class="span6 pull-right" style="text-align:right">
                <a href="/RecentRuns.aspx" class="btn btn-info" role="button">Cancel</a>
            </div>
        </div>

    </div>
    
    <script>
        $("#txtController").val("<%=Model.Controller%>");
        $("#txtRider").val("<%=Model.Rider%>");
        $("#txtShiftDate").val("<%=Model.DutyDate%>");
        $("#txtPickupTime").val("<%=Model.CollectTime%>");
        $("#txtDeliverTime").val("<%=Model.DeliverTime%>");
        $("#txtReturnTime").val("<%=Model.HomeSafeTime%>");
        if ("<%=Model.Vehicle%>".length > 0) {
            $("#btnVehicle").text("<%=Model.Vehicle%>");
        }
        if ("<%=Model.CollectionPostcode%>".length>0) {
            $("#txtCollectPostcode").val("<%=Model.CollectionPostcode%>");
        } else {
            $("#txtCollect").val("<%=Model.CollectionHospital%>");
        }
        if ("<%=Model.TakenToPostcode%>".length > 0) {
            $("#txtDropPostcode").val("<%=Model.TakenToPostcode%>");
        }
        else {
            $("#txtDrop").val("<%=Model.TakenTo%>");
        }
        $("#txtBoxes").val("<%=Model.BoxQty%>");
        $("#txtNotes").val("<%=Model.Notes%>");

    </script>
    <script src="js/MilkLog.js?1246"></script>
</asp:Content>

