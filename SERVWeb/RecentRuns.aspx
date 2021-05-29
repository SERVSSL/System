<%@ Page Language="C#" Inherits="SERVWeb.RecentRuns" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>
<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">
	
	<div class="row">
		<div class="span12">
			<h3>Recent Runs</h3>
			<div>
                <%--OnSelectedIndexChanged="Selection_Change"--%>
				Select year <br/>
                <asp:DropDownList ID="RunYear" AutoPostBack="True" runat="server" />
            </div>
			<p>Recent runs with view / edit links.</p>
            <strong><asp:Literal runat="server" ID="runMessage" /></strong>
			<asp:GridView runat="server" id="dgRecentRuns" CssClass="table table-striped table-bordered table-condensed" AutoGenerateColumns="false">
				<Columns>
					<asp:BoundField HeaderText="ID" DataField="ID" />
					<asp:BoundField HeaderText="Duty Date" DataField="DutyDate" />
					<asp:BoundField HeaderText="Call Date &amp; Time" DataField="CallDateTime" />
					<asp:BoundField HeaderText="Call From" DataField="CallFrom" />
					<asp:BoundField HeaderText="From" DataField="From" />
					<asp:BoundField HeaderText="To" DataField="To" />
					<asp:BoundField HeaderText="Collected" DataField="Collected" />
					<asp:BoundField HeaderText="Delivered" DataField="Delivered" />
					<asp:BoundField HeaderText="Destination" DataField="Destination" />
					<asp:BoundField HeaderText="Rider" DataField="Rider" />
					<asp:BoundField HeaderText="Vehicle" DataField="Vehicle" />
					<asp:BoundField HeaderText="Consignment" DataField="Consignment" />
					<asp:BoundField HeaderText="Controller" DataField="Controller" />
					<asp:HyperLinkField HeaderText="" DataNavigateUrlFormatString="ControllerLog.aspx?RunLogID={0}" DataNavigateUrlFields="ID" Text="View/Edit" />
					<asp:TemplateField HeaderText="">
						<ItemTemplate>
						        <a onclick="javascript:return confirm('Are you sure you want to delete this run? This cannot be undone!!')" href="ControllerLog.aspx?RunLogID=<%#Eval("ID")%>&delete=1">Delete</a>
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
		</div>
	</div>
	<script>
		_loaded();
	</script>
</asp:Content>



