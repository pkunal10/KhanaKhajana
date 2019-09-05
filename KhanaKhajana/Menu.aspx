<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="KhanaKhajana.Menu" %>

<%@ MasterType VirtualPath="~/user.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Menu</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <div class="container">
        <div class="row">
            <div class="col-xl-3 col-lg-4 col-md-5">
                <div class="sidebar-categories">
                    <div class="head">Browse Categories</div>
                    <ul class="main-categories">
                        <asp:Repeater ID="rptrCategories" runat="server">
                            <ItemTemplate>
                                <li class="main-nav-list">
                                    <asp:LinkButton ID="lbRptrCategories" CommandName='<%#Eval("CategoryId") %>' OnCommand="lbRptrCategories_Command" runat="server">
                                        <span class="lnr lnr-arrow-right"></span><%#Eval("CategoryName") %><span class="number">(<%#Eval("NoOfProducts") %>)</span>
                                    </asp:LinkButton>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <div class="col-xl-9 col-lg-8 col-md-7">
                <!-- Start Filter Bar -->
                <div class="filter-bar d-flex flex-wrap align-items-center">
                    <h1>
                        <asp:Label ID="lblSelectedCategory" runat="server" Text="" CssClass="text-heading"></asp:Label></h1>
                </div>
                <!-- End Filter Bar -->
                <!-- Start Best Seller -->
                <section class="lattest-product-area pb-40 category-list">
                    <div class="row">
                        <!-- single product -->
                        <asp:Repeater ID="rptrProducts" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-4 col-md-6">
                                    <div class="single-product">                                       
                                            <asp:Image ID="rptrImgProduct" runat="server" ImageUrl='<%#Eval("Image") %>' Height="263px" Width="280px" AlternateText='<%#Eval("ProductName") %>' CssClass="img-fluid" />                                                                                    
                                        <div class="product-details">
                                            <h6><%#Eval("ProductName") %></h6>
                                            <div class="price">
                                                <h6><%#Convert.ToDouble(Eval("DiscountedPrice")) !=0?"$ "+Eval("DiscountedPrice") :"$ "+Eval("Price")%></h6>
                                                <h6 class="l-through"><%#Convert.ToDouble(Eval("DiscountedPrice")) !=0?"$ "+Eval("Price") :""%></h6>
                                                <h6><%#Convert.ToDouble(Eval("DiscountedPercent")) !=0?"("+Eval("DiscountedPercent")+"% off)" :""%></h6>
                                            </div>
                                            <div class="prd-bottom">
                                                <asp:LinkButton ID="rpteLbAddtoCart" runat="server" CommandName='<%#Eval("ProductId") %>' OnCommand="rpteLbAddtoCart_Command" CssClass="social-info">
                                                            <span class="ti-bag"></span>
                                                            <p class="hover-text">add to bag</p>
                                                </asp:LinkButton>
                                                <%--<a href="" class="social-info">
                                                            <span class="lnr lnr-heart"></span>
                                                            <p class="hover-text">Wishlist</p>
                                                        </a>
                                                        <a href="" class="social-info">
                                                            <span class="lnr lnr-sync"></span>
                                                            <p class="hover-text">compare</p>
                                                        </a>--%>
                                                <asp:LinkButton ID="rptrlbView" runat="server" CommandName='<%#Eval("ProductId") %>' OnCommand="rptrlbView_Command" CssClass="social-info">
                                                            <span class="lnr lnr-move"></span>
                                                            <p class="hover-text">view details</p>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <!-- single product -->

                        <asp:Panel ID="pnlNoProducts" CssClass="text-center" runat="server" Visible="false">
                            <h1>No Products for this category</h1>
                        </asp:Panel>

                    </div>
                </section>
                <!-- End Best Seller -->
            </div>
        </div>
    </div>
    <%--            <asp:UpdateProgress ID="UpdateProgress1" runat="server" class="loading" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0" DynamicLayout="true">
                <ProgressTemplate>
                    <center>
                    <font style="color:White;font-size:18px;">Please Wait....</font><br /><br />
                    <img id="Img1" src="~/Content/img/loading.gif" runat="server" />
                </center>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>        --%>
</asp:Content>
