<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="KhanaKhajana.Home" %>

<%@ MasterType VirtualPath="~/user.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Khana Khajana</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>--%>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 text-center">
                    <div class="section-title">
                        <h1>Khana Khajana</h1>
                        <p class="homeTxt">
                            For an authentic, yet casual, Indian dining experience a visit to Khana Khajana is a must. Whether its to snack on one of  appetizers or simply savouring a delicious meal, spiced to your liking, Khana Khajana is a sure hit to please anyone’s palette.
                        restaurant is fully licensed and unique to cater your every need.
                        </p>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-6 text-center">
                    <div class="section-title">
                        <h1>Khajana Specials</h1>
                        <p>
                            <%--Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
								dolore
								magna aliqua.--%>
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <!-- single product -->
                <asp:Repeater ID="rptrProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-6">
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
            </div>
            <asp:Panel ID="pnlNoFeatureProducts" runat="server" Visible="false" CssClass="text-center">
                <h1>No feature dishes.</h1>
            </asp:Panel>
        </div>
<%--        <asp:UpdateProgress ID="UpdateProgress1" runat="server" class="loading" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0" DynamicLayout="true">
            <progresstemplate>
                    <center>
                    <font style="color:White;font-size:18px;">Please Wait....</font><br /><br />
                    <img id="Img1" src="~/Content/img/loading.gif" runat="server" />
                </center>
                </progresstemplate>
        </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
