<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="KhanaKhajana.Signup" %>

<%@ MasterType VirtualPath="~/user.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Sign up</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 form-group">
                        <label>First Name</label>
                        <asp:TextBox ID="tbFname" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFname" runat="server" ErrorMessage="Enter First Name" CssClass="text-danger"
                            Text="Enter First Name" ControlToValidate="tbFname" Display="Dynamic" ValidationGroup="signup"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="comvFname" runat="server" ErrorMessage="Enter Correct First Name" CssClass="text-danger"
                            Text="Enter Correct First Name" Operator="DataTypeCheck" Type="String" ValidationGroup="signup" ControlToValidate="tbFname" Display="Dynamic"></asp:CompareValidator>
                    </div>
                    <div class="col-lg-3 form-group">
                        <label>Last Name</label>
                        <asp:TextBox ID="tbLname" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbLname" runat="server" ErrorMessage="Enter Last Name" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Last Name" ControlToValidate="tbLname" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="comvtbLname" runat="server" ErrorMessage="Enter Correct Last Name" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Correct Last Name" Operator="DataTypeCheck" Type="String" ControlToValidate="tbLname" Display="Dynamic"></asp:CompareValidator>
                    </div>
                    <div class="col-lg-3 form-group">
                        <label>Address Line 1</label>
                        <asp:TextBox ID="tbAddressLine1" runat="server" CssClass="form-control" placeholder="Address Line 1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbAddressLine1" runat="server" ErrorMessage="Enter Address Line 1" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Address Line 1" ControlToValidate="tbAddressLine1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-3 form-group">
                        <label>City</label>
                        <asp:TextBox ID="tbCity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbCity" runat="server" ErrorMessage="Enter City" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter City" ControlToValidate="tbCity" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="comvtbCity" runat="server" ErrorMessage="Enter Correct City" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Correct City" Operator="DataTypeCheck" Type="String" ControlToValidate="tbCity" Display="Dynamic"></asp:CompareValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 form-group">
                        <label>Province</label>
                        <asp:TextBox ID="tbProvince" runat="server" CssClass="form-control" placeholder="Province"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbProvince" runat="server" ErrorMessage="Enter Province" CssClass="text-danger"
                            Text="Enter Province" ControlToValidate="tbProvince" Display="Dynamic" ValidationGroup="signup"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="comvtbProvince" runat="server" ErrorMessage="Enter Correct Province" CssClass="text-danger"
                            Text="Enter Correct First Name" Operator="DataTypeCheck" Type="String" ValidationGroup="signup" ControlToValidate="tbProvince" Display="Dynamic"></asp:CompareValidator>
                    </div>
                    <div class="col-lg-3 form-group">
                        <label>Zip Code</label>
                        <asp:TextBox ID="tbZipCode" runat="server" CssClass="form-control text-uppercase" placeholder="Zip Code"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbZipCode" runat="server" ErrorMessage="Enter Zip Code" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Zip Code" ControlToValidate="tbZipCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rgexvtbZipCode" runat="server" ErrorMessage="Enter Correct Zip Code" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Correct Zip Code" ControlToValidate="tbZipCode" Display="Dynamic" ValidationExpression="\w\d\w\d\w\d"></asp:RegularExpressionValidator>
                    </div>
                    <div class="col-lg-3 form-group">
                        <label>Mobile No</label>
                        <asp:TextBox ID="tbMobileNo" MaxLength="10" runat="server" CssClass="form-control" placeholder="Mobile No"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbMobileNo" runat="server" ErrorMessage="Enter Mobile No" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Mobile No" ControlToValidate="tbMobileNo" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="comvtbMobileNo" runat="server" ErrorMessage="Enter Correct Mobile" CssClass="text-danger" ValidationGroup="signup"
                            Text="Enter Correct Mobile" Operator="GreaterThan" ValueToCompare="0" ControlToValidate="tbMobileNo" Display="Dynamic"></asp:CompareValidator>
                    </div>
                    <div class="col-lg-3 form-group">
                        <label>Email Id</label>
                        <asp:TextBox ID="tbEmailId" runat="server" placeholder="Email Id" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmailId" CssClass="text-danger" ControlToValidate="tbEmailId"
                            ValidationGroup="signup" Display="Dynamic" runat="server" ErrorMessage="Enter Email Id"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rexEmailId" runat="server" ControlToValidate="tbEmailId" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="signup" Display="Dynamic" ErrorMessage="Enter correct Email Id" CssClass="text-danger"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 form-group">
                        <label>Password</label>
                        <asp:TextBox ID="tbPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbPassword" runat="server" ErrorMessage="Enter Password" CssClass="text-danger"
                            Text="Enter Password" ControlToValidate="tbPassword" Display="Dynamic" ValidationGroup="signup"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-3 form-group">
                        <label>Profile Image</label>
                        <asp:Image ID="imgProfilePic" runat="server" Height="80px" Visible="false" Width="80px" ImageUrl="~/Admin/UserImages/default.png" />
                        <asp:LinkButton ID="lbChangeImg" runat="server" Visible="false" OnClick="lbChangeImg_Click">Change Image</asp:LinkButton>
                        <asp:FileUpload ID="flieImage" runat="server" />
                        <%--<asp:RequiredFieldValidator ID="rfvimgProfilePic" runat="server" ErrorMessage="Select Image" CssClass="text-danger"
                    Text="Select Image" ControlToValidate="imgProfilePic" Display="Dynamic" ValidationGroup="signup"></asp:RequiredFieldValidator>                --%>
                    </div>
                    <div class="col-lg-3 form-group">
                        <asp:Button ID="btnSignup" CssClass="btn mybtn" runat="server" ValidationGroup="signup" OnClick="btnSignup_Click" Text="Sign Up" />
                        <asp:Button ID="btnClear" CssClass="btn mybtn" runat="server" CausesValidation="false" Text="Clear" OnClick="btnClear_Click" />
                    </div>
                    <div class="col-lg-3 form-group">
                        <asp:Button ID="btnFbSignup" runat="server" Text="Sign up with Facebook" CssClass="loginBtn loginBtn--facebook" OnClick="btnFbSignup_Click" />
                    </div>
                </div>
            </div>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" class="loading" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0" DynamicLayout="true">
                <ProgressTemplate>
                    <center>
                    <font style="color:White;font-size:18px;">Please Wait....</font><br /><br />
                    <img id="Img1" src="~/Content/img/loading.gif" runat="server" />
                </center>
                </ProgressTemplate>
            </asp:UpdateProgress>            
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSignup" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
