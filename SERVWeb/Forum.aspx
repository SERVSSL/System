<%@ Page Language="C#" Inherits="SERVWeb.Forum" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>
<%@ Import Namespace="SERVWeb" %>

<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">The Forum</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

	<div class="row">
		<div class="span12">
			<p><a href="<%=SERVGlobal.ForumURL%>" target="_blank" class="btn btn-primary">Open the SERV S&SL Forum</a></p>
		</div>
	</div>

	<script>
		_loaded();
		initFeedback();
	</script>

</asp:Content>
