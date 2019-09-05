<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="ViewOrders.aspx.cs" Inherits="KhanaKhajana.Admin.ViewOrders" %>

<%@ MasterType VirtualPath="~/Admin/adminMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin | Product Maintenance</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script>
        function openModal() {
            jQuery.noConflict();
            $('#orderDetailModel').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="row">
        <div class="col-lg-3"></div>
        <div class="col-lg-3">
            <div class="form-group">
                <label for="ddlCategory">Date</label>
                <asp:TextBox ID="tbDate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="col-lg-3">
            <label></label>
            <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show Orders" CssClass="btn btn-primary martop" />
        </div>
        <div class="col-lg-3"></div>
    </div>
    <div class="row bg-gray">
        <asp:GridView ID="gvOrder" CssClass="table table-bordered table-hover" runat="server" OnRowDataBound="gvOrder_RowDataBound"
            AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="SNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                        <asp:Label ID="gvlblOrderId" runat="server" Text='<%#Eval("OrderID") %>' Visible="false"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User Name">
                    <ItemTemplate>
                        <%#Eval("UserName") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Order Date">
                    <ItemTemplate>
                        <%#Eval("OrderDate") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address Line 1">
                    <ItemTemplate>
                        <%#Eval("AddressLine1") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City">
                    <ItemTemplate>
                        <%#Eval("City") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mobile No">
                    <ItemTemplate>
                        <%#Eval("MobileNo") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-CssClass="form-group-sm" HeaderText="Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="gvddlStatus" runat="server" CssClass="form-control"></asp:DropDownList>
                        <asp:LinkButton ID="gvlbUpdateStatus" CssClass="btn btn-sm btn-success" CommandName='<%#Eval("OrderId") %>' OnCommand="gvlbUpdateStatus_Command" runat="server"><i class="fa glyphicon-edit" title="Update"></i></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="gvlbView" CssClass="btn btn-sm btn-primary" CommandName='<%#Eval("OrderId") %>' OnCommand="gvlbView_Command" runat="server"><i class="fa fa-eye" title="View"></i></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="Black" ForeColor="White" Height="40px" Font-Size="Medium" />
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle HorizontalAlign="Center" CssClass="pagination-lg pagerSpace" />
        </asp:GridView>
    </div>
    <div class="modal fade" id="orderDetailModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">
                        <asp:Label ID="lblorderDetailModelTitle" runat="server" Text=""></asp:Label>
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="width:25%">Product</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptrOrderDetails" runat="server">
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
                                                            <%#Convert.ToDouble(Eval("DiscountedPrice")) !=0?"$ "+Eval("DiscountedPrice") :"$ "+Eval("Price")%>
                                                            <strike><%#Convert.ToDouble(Eval("DiscountedPrice")) !=0?"$ "+Eval("Price") :""%></strike>
                                                            <%#Convert.ToDouble(Eval("DiscountedPercentNull")) !=0?"("+Eval("DiscountedPercentNull")+"% off)" :""%>
                                                        </h5>
                                                    </td>
                                                    <td>
                                                        <div class="product_count">
                                                            <%#Eval("Qty") %>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <h5>
                                                            <%#"$ "+Eval("TotalPrice") %>
                                                        </h5>
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
                                                    <asp:Label ID="lblorderDetailModelSubtotal" runat="server" Text=""></asp:Label>
                                                </h5>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
