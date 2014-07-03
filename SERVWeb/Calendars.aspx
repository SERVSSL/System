﻿<%@ Page Language="C#" Inherits="SERVWeb.Calendars" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>
<%@ Import Namespace="SERVWeb" %>
<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Rotas</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">
	
	<%=SERVGlobal.CalendarJSInclude()%>	

	<div id="entry" style="display:none">
		<h3>Rota List</h3>
		<div class="row">
			<div class="span12">
				<div id="results">
				</div>
			</div>
		</div>

	</div>
	
	<script>
	
	$(function() 
	{
		//if (<%=this.UserLevel%> < 3)
		//{
			//$("#cmdAdd").hide();
		//}
		listCalendars(<%=this.UserLevel%>);
	});

	</script>

</asp:Content>


