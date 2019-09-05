<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="KhanaKhajana.OrderHistory" %>

<%@ MasterType VirtualPath="~/user.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Order History</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script>
        function openModal(status) {
            jQuery.noConflict();
            $('#orderDetailModel').modal('show');
            var lis = $('#orderDetailsModelBar li');
            for (var i = 0; i < status; i++) {
                $(lis[i]).removeClass("progtrckr-todo");
                $(lis[i]).addClass("progtrckr-done");
            }            
        }

        function showOrderStatusBar(status) {
            jQuery.noConflict();
            var lis = $('#orderDetailsModelBar li');
            for(var i=0;i<status;i++)
            {
                $(lis[i]).addClass("progtrckr-done");
            }
            alert(status);
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <div class="container">
        <div class="row">
            <div class="col col-12">

                <asp:Repeater ID="rptrOrder" runat="server">
                    <ItemTemplate>
                        <div class="order_details_table ohBC">
                            <div class="row">
                                <div class="col-lg-10">
                                    <h2>Order Date:- <%#Eval("OrderDate","{0:dd/MM/yyyy}") %></h2>
                                </div>
                                <div class="col-lg-2">
                                    <asp:LinkButton ID="gvlbView" CssClass="btn btn-sm btn-primary" OnCommand="gvlbView_Command" CommandName='<%#Eval("OrderId") %>' runat="server"><i class="fa fa-eye" title="View"></i></asp:LinkButton>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="col-lg-4">
                                        <h4>Delivery Address</h4>
                                        <ul class="list">
                                            <li class="address"><span>Street</span> : <%#Eval("AddressLine1") %></li>
                                            <li class="address"><span>City</span> : <%#Eval("City") %></li>
                                            <li class="address"><span>Postcode </span>: <%#Eval("ZipCode") %></li>
                                        </ul>
                                    </div>
                                    <div class="col-lg-12">
                                        <h3>Order Status</h3>
                                        <ol class="progtrckr" data-progtrckr-steps="4">
                                            <li class='<%#Convert.ToInt32(Eval("Status"))>=1?"progtrckr-done":"progtrckr-todo" %>' id="1">Order Processing</li>
                                            <li class='<%#Convert.ToInt32(Eval("Status"))>=2?"progtrckr-done":"progtrckr-todo" %>' id="2">Cooking</li>
                                            <li class='<%#Convert.ToInt32(Eval("Status"))>=3?"progtrckr-done":"progtrckr-todo" %>' id="3">Out For Delivery</li>
                                            <li class='<%#Convert.ToInt32(Eval("Status"))>=4?"progtrckr-done":"progtrckr-todo" %>' id="4">Delivered</li>
                                            <%--<li class="progtrckr-todo">Delivered</li>--%>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <%--<asp:GridView ID="gvOrder" CssClass="table table-bordered table-hover" runat="server"
                    AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
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
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="gvlbView" CssClass="btn btn-sm btn-primary" OnCommand="gvlbView_Command" CommandName='<%#Eval("OrderId") %>' runat="server"><i class="fa fa-eye" title="View"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#FFF9C4" />
                    <HeaderStyle BackColor="Black" ForeColor="White" Height="40px" Font-Size="Medium" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination-lg pagerSpace" />
                </asp:GridView>--%>
            </div>
        </div>
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
                        <div class="col col-12">
                            <h3>Order Status</h3>
                            <ol class="progtrckr" id="orderDetailsModelBar" data-progtrckr-steps="4">
                                <li class="progtrckr-todo">Order Processing</li>
                                <li class="progtrckr-todo">Cooking</li>
                                <li class="progtrckr-todo">Out For Delivery</li>
                                <li class="progtrckr-todo">Delivered</li>
                                <%--<li class="progtrckr-todo">Delivered</li>--%>
                            </ol>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-lg-12">
                            <h3>Order Details</h3>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="width: 25%">Product</th>
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
