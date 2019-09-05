<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="KhanaKhajana.Cart" %>

<%@ MasterType VirtualPath="~/user.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Cart</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<%--    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>--%>
            <section class="cart_area">
                <div class="container">
                    <div class="cart_inner">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Product</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptrCart" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <div class="media">
                                                        <div class="d-flex">
                                                            <asp:Label ID="rptrlblProductId" Visible="false" runat="server" Text='<%#Eval("ProductId") %>'></asp:Label>
                                                            <asp:Image ID="rptrImg" runat="server" Height="100px" Width="100px" ImageUrl='<%#Eval("Image") %>' />
                                                        </div>
                                                        <div class="media-body">
                                                            <p><%#Eval("ProductName") %></p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <h5>
                                                        <asp:Label ID="rptrlblPrice" runat="server" Text='<%#Convert.ToDouble(Eval("DiscountedPrice")) !=0?"$ "+Eval("DiscountedPrice") :"$ "+Eval("Price")%>'></asp:Label>
                                                        <strike><%#Convert.ToDouble(Eval("DiscountedPrice")) !=0?"$ "+Eval("Price") :""%></strike>
                                                        <%#Convert.ToDouble(Eval("DiscountedPercent")) !=0?"("+Eval("DiscountedPercent")+"% off)" :""%>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <div class="product_count">
                                                        <asp:TextBox ID="rptrtbQuantity" TextMode="Number" AutoPostBack="true" OnTextChanged="rptrtbQuantity_TextChanged" Text="1" runat="server"></asp:TextBox>
                                                    </div>
                                                </td>
                                                <td>
                                                    <h5>
                                                        <asp:Label ID="rptrlblTotalPrice" runat="server" Text='<%#Convert.ToDouble(Eval("DiscountedPrice")) !=0?"$ "+Eval("DiscountedPrice") :"$ "+Eval("Price")%>'></asp:Label>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="rptrlbDelete" OnCommand="rptrlbDelete_Command" CssClass="btn btn-danger" CommandName='<%#Eval("ProductId") %>' runat="server"><i class="fa fa-remove"></i></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <h5>Subtotal</h5>
                                        </td>
                                        <td>
                                            <h5>
                                                <asp:Label ID="lblSubtotal" runat="server" Text=""></asp:Label>
                                            </h5>
                                        </td>
                                    </tr>
                                    <tr class="out_button_area">
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <div class="checkout_btn_inner d-flex align-items-center">
                                                <a class="gray_btn" href="Menu.aspx">Continue Shopping</a>
                                                <asp:Button ID="btnCheckout" CssClass="btn btn-warning marleft" OnClick="btnCheckout_Click" runat="server" Text="Checkout" />
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <asp:Panel ID="pnlCheckout" Visible="false" runat="server">
                                <fieldset>
                                    <legend>Delivery Information</legend>
                                    <div class="row">
                                        <div class="col-lg-3 form-group">
                                            <label>Address Line 1</label>
                                            <asp:TextBox ID="tbAddressLine1" runat="server" CssClass="form-control" placeholder="Address Line 1"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvtbAddressLine1" runat="server" ErrorMessage="Enter Address Line 1" CssClass="text-danger" ValidationGroup="cnfmOrder"
                                                Text="Enter Address Line 1" ControlToValidate="tbAddressLine1" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label>City</label>
                                            <asp:TextBox ID="tbCity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvtbCity" runat="server" ErrorMessage="Enter City" CssClass="text-danger" ValidationGroup="cnfmOrder"
                                                Text="Enter City" ControlToValidate="tbCity" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="comvtbCity" runat="server" ErrorMessage="Enter Correct City" CssClass="text-danger" ValidationGroup="cnfmOrder"
                                                Text="Enter Correct City" Operator="DataTypeCheck" Type="String" ControlToValidate="tbCity" Display="Dynamic"></asp:CompareValidator>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label>Province</label>
                                            <asp:TextBox ID="tbProvince" runat="server" CssClass="form-control" placeholder="Province"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvtbProvince" runat="server" ErrorMessage="Enter Province" CssClass="text-danger"
                                                Text="Enter Province" ControlToValidate="tbProvince" Display="Dynamic" ValidationGroup="cnfmOrder"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="comvtbProvince" runat="server" ErrorMessage="Enter Correct Province" CssClass="text-danger"
                                                Text="Enter Correct First Name" Operator="DataTypeCheck" Type="String" ValidationGroup="cnfmOrder" ControlToValidate="tbProvince" Display="Dynamic"></asp:CompareValidator>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label>Zip Code</label>
                                            <asp:TextBox ID="tbZipCode" runat="server" CssClass="form-control text-uppercase" placeholder="Zip Code"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvtbZipCode" runat="server" ErrorMessage="Enter Zip Code" CssClass="text-danger" ValidationGroup="cnfmOrder"
                                                Text="Enter Zip Code" ControlToValidate="tbZipCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="rgexvtbZipCode" runat="server" ErrorMessage="Enter Correct Zip Code" CssClass="text-danger" ValidationGroup="cnfmOrder"
                                                Text="Enter Correct Zip Code" ControlToValidate="tbZipCode" Display="Dynamic" ValidationExpression="\w\d\w\d\w\d"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 form-group">
                                            <label>Instruction for delivery</label>
                                            <asp:TextBox ID="tbInstruction" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Instruction for delivery"></asp:TextBox>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label>Mobile No</label>
                                            <asp:TextBox ID="tbMobileNo" MaxLength="10" runat="server" CssClass="form-control" placeholder="Mobile No"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvtbMobileNo" runat="server" ErrorMessage="Enter Mobile No" CssClass="text-danger" ValidationGroup="cnfmOrder"
                                                Text="Enter Mobile No" ControlToValidate="tbMobileNo" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="comvtbMobileNo" runat="server" ErrorMessage="Enter Correct Mobile" CssClass="text-danger" ValidationGroup="cnfmOrder"
                                                Text="Enter Correct Mobile" Operator="GreaterThan" ValueToCompare="0" ControlToValidate="tbMobileNo" Display="Dynamic"></asp:CompareValidator>
                                        </div>
                                        <div class="col-lg-3 form-group">
                                            <label>Payment Mode</label><br />
                                            <input type="radio" checked="checked" class="radion_btn" />
                                            COD
                                        </div>
                                        <div class="col-lg-3">
                                            <asp:Button ID="btnConfirmOrder" runat="server" CssClass="btn btn-primary" Text="Confirm Order" OnClick="btnConfirmOrder_Click" ValidationGroup="cnfmOrder" />
                                        </div>
                                    </div>
                                </fieldset>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </section>
            <%--  <asp:UpdateProgress ID="UpdateProgress1" runat="server" class="loading" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0" DynamicLayout="true">
                <ProgressTemplate>
                    <center>
                    <font style="color:White;font-size:18px;">Please Wait....</font><br /><br />
                    <img id="Img1" src="~/Content/img/loading.gif" runat="server" />
                </center>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
