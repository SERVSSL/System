<%@ Page Language="C#" Inherits="SERVWeb.Login" MasterPageFile="~/Master.master" %>

<%@ MasterType VirtualPath="~/Master.master" %>


<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Login</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

    <div class="well">
        <h3>Login</h3>
        <label>Email Address:</label>
        <asp:TextBox runat="server" ID="txtEmail" />

        <label>Password:</label>
        <asp:TextBox runat="server" ID="txtPassword" TextMode="password" />

        <br />
        <br />
        <asp:Button runat="server" ID="cmdLogin" Text="Login" class="btn btn-primary btn-lg" OnClick="cmdLoginClick" /><br /><br />
        <a href="PasswordReset.aspx">Forgot password</a>
        <br />
    </div>
    <script>
        _loaded();
    </script>

    <asp:Literal runat="server" ID="litServerClient"></asp:Literal>

</asp:Content>
