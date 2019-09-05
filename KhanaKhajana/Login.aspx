<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KhanaKhajana.Login" %>

<%@ MasterType VirtualPath="~/user.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Login</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <section class="login_box_area section_gap">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="login_box_img">
                                <img class="img-fluid" src="Content/img/login.jpg" alt="">
                                <div class="hover">
                                    <h4>New to our website?</h4>
                                    <%--<p>There are advances being made in science and technology everyday, and a good example of this is the</p>--%>
                                    <a class="primary-btn" href="Signup.aspx">Create an Account</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="login_form_inner">
                                <h3>Log in to enter</h3>
                                <div class="row login_form">
                                    <div class="col-md-12 form-group">
                                        <%--<label class="text-left">Emial Id</label>--%>
                                        <asp:TextBox ID="tbEmailId" runat="server" placeholder="Email Id" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvEmailId" CssClass="text-danger" ControlToValidate="tbEmailId"
                                            ValidationGroup="login" Display="Dynamic" runat="server" ErrorMessage="Enter Email Id"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="rexEmailId" runat="server" ControlToValidate="tbEmailId" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                            ValidationGroup="login" Display="Dynamic" ErrorMessage="Enter correct Email Id" CssClass="text-danger"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <asp:TextBox ID="tbPassword" runat="server" placeholder="Password" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvPassword" CssClass="text-danger" ControlToValidate="tbPassword" ValidationGroup="login" Display="Dynamic"
                                            runat="server" ErrorMessage="Enter Password"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <%--<div class="creat_account">
                                            <input type="checkbox" id="f-option2" name="selector">
                                            <label for="f-option2">Keep me logged in</label>
                                        </div>--%>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <asp:Button ID="btnLogin" CssClass="primary-btn" runat="server" OnClick="btnLogin_Click" ValidationGroup="login" Text="Log In" />
                                        <%--<a href="#">Forgot Password?</a>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" class="loading" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0" DynamicLayout="true">
                <ProgressTemplate>
                    <center>
                    <font style="color:White;font-size:18px;">Please Wait....</font><br /><br />
                    <img id="Img1" src="~/Content/img/loading.gif" runat="server" />
                </center>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
