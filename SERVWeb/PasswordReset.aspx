<%@ Page Language="C#" Inherits="SERVWeb.PasswordReset" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>
<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Password Reset</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

<h3>Reset Your Password</h3>
<p>Enter your email address and we will send you a link to reset your password.</p>
<label>Email Address:</label>
<asp:TextBox runat="server" id="txtEmail" />
<p></p>
<asp:Button runat="server" id="cmdChange" Text="Reset" class="btn btn-primary btn-lg readOnlyHidden" onclick="cmdResetClick"/>

<script>
	_loaded();
</script>

</asp:Content>


