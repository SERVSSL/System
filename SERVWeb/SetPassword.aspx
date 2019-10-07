<%@ Page Language="C#" Inherits="SERVWeb.SetPassword" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>
<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Password Reset</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

    <div ID="resetform" runat="server" Visible="True">
        <h3>Create a new password</h3>
        <p>Your password needs to be at least eight characters</p>

        <label>New Password:</label>
        <asp:TextBox runat="server" id="txtNewPassword" TextMode="password"/>
        <div class="errorTop">
            <span id="errMessage" runat="server" class="text-error"></span>
        </div>
        <label>Confirm Password:</label>
        <asp:TextBox runat="server" id="txtConfirmPassword" TextMode="password"/>
        <asp:HiddenField runat="server" ID="hdnToken"/>

        <br/><br/>
        <asp:Button runat="server" id="cmdChange" Text="Change Password" class="btn btn-primary btn-lg readOnlyHidden" onclick="cmdChangeClick"/>
    </div>

    
    <div ID="errorPlaceHolderContent" runat="server" Visible="False">
        <h3>Create a new password</h3>
        <p>Sorry we could not reset your password.  This link you were emailed may have expired.</p>
        <p>Please request a <a href="PasswordReset.aspx">password reset</a> again.</p>
    </div>

    <div ID="success" runat="server" Visible="False">
        <h3>Create a new password</h3>
        <p>Congratulations! Your password has now been reset.</p>
        <p>You may now <a href="Login.aspx">login</a> using your new password</p>
    </div>
    
    <script>
        _loaded();
    </script>

</asp:Content>



