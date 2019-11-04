<%@ Page Language="C#" AutoEventWireup="true" Inherits="SERVWeb.MilkRunLog" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>

<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Controller Log - Milk</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

    <div>
        <h3>Controller Log</h3>

        <div class="row">

            <fieldset>

                <div id="Milk">
                    <div class="span4">

                        <label>Rider / Driver:</label>
                        <input type="text" id="txtAARider" class="riders" placeholder="Choose the rider / driver" />
                    </div>
                    </div>
            </fieldset>
        </div>
    </div>

</asp:Content>

