<%@ Page Language="C#" AutoEventWireup="true" Inherits="SERVWeb.MilkRunLog" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>

<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Controller Log - Milk</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

    <div>
        <h3>Controller Log - Milk Runs</h3>
        
        
        <div class="row">
            <div class="span4 input-prepend">
                <button type="button" class="btn" onclick="" id="btnBloodRun" disabled>Controller</button>
                <input type="text" id="txtController" style="width:150px" class="controllers" placeholder="Choose the controller" /> 
            </div>
        </div>
        <br/>


        <div class="row">

            <fieldset>

                <div id="Milk">
                    <div class="span4">

                        <label>Rider / Driver:</label>
                        <input type="text" id="txtRider" class="riders" placeholder="Choose the rider / driver" />
                        
                        <label>Run Date:</label>
                        <input type="text" id="txtShiftDate" class="date" />

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
                        <input type="text" id="txtOriginPostcode" placeholder="First half of postcode" />

                        <label>Collect from hospital:</label>
                        <input type="text" id="txtOrigin" class="locations" placeholder="Type and Choose" onblur="originSelected();"/>
                        
                        <label>Taken To:</label>
                        <input type="text" id="txtDrop" class="locations" placeholder="Type and Choose" />

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
        </div>

    </div>
    <script>
        $("#txtController").val("<%=MemberName()%>");
    </script>
    <script src="js/MilkLog.js"></script>
</asp:Content>

