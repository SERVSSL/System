<%@ Page Language="C#" Inherits="SERVWeb.PasswordReset" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>
<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Password Reset</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

<h3>Reset Your Password</h3>
<asp:Panel runat="server" id="resetForm">
    <p>Enter your email address and we will send you a link to reset your password.</p>
    <label>Email Address:</label>
    <asp:TextBox runat="server" id="txtEmail" />
    <p></p>
    <asp:Button runat="server" id="cmdChange" Text="Reset" class="btn btn-primary btn-lg readOnlyHidden" onclick="cmdResetClick"/>
</asp:Panel>

<asp:Panel runat="server" id="submittedMessage" Visible="False">
    <p>An email has been sent to you with instructions on how to reset your password. It is valid for one hour, so please check your email.</p>
</asp:Panel>

<script>
	_loaded();
</script>

</asp:Content>


