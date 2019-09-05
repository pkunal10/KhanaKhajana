<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="KhanaKhajana.ProductDetails" %>

<%@ MasterType VirtualPath="~/user.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Menu</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <div class="product_image_area">
                <div class="container">
                    <div class="row s_product_inner">
                        <div class="col-lg-6">
                            <div class="single-prd-item">
                                <asp:Image ID="imgProduct" CssClass="img-fluid" runat="server" />
                            </div>
                        </div>
                        <div class="col-lg-5 offset-lg-1">
                            <div class="s_product_text">
                                <h3>
                                    <asp:Label ID="lblProductName" runat="server" Text=""></asp:Label>
                                </h3>
                                <h2>
                                    <asp:Label ID="lblPrice" runat="server" Text=""></asp:Label>
                                </h2>
                                <strike><asp:Label ID="lbloldPrice" runat="server" Text=""></asp:Label></strike>
                                <i>
                                    <asp:Label ID="lblDiscountPercent" runat="server" Text=""></asp:Label></i>
                                <ul class="list">
                                    <li><span>Category</span> :
                                <asp:Label ID="lblCategory" runat="server" Text=""></asp:Label></li>
                                </ul>
                                <p>
                                    <asp:Label ID="lblProductIngridents" runat="server" Text=""></asp:Label>
                                </p>
                                <div class="card_area d-flex align-items-center">
                                    <asp:LinkButton ID="lbAddToCart" OnClick="lbAddToCart_Click" runat="server" CssClass="primary-btn">Add To Bag</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--================End Single Product Area =================-->

            <!--================Product Description Area =================-->
            <section class="product_description_area">
                <div class="container">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
                                aria-selected="false">Reviews</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="row total_rate">
                                        <div class="col-6">
                                            <div class="box_total">
                                                <h5>Overall</h5>
                                                <h4>
                                                    <asp:Label ID="lblOverAllRating" runat="server" Text=""></asp:Label>
                                                </h4>
                                                <h6>(<asp:Label ID="lblNoOfReviews" runat="server" Text=""></asp:Label>
                                                    Reviews)</h6>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="rating_list">
                                                <h3>Based on
                                            <asp:Label ID="lblNoOfReviews2" runat="server" Text=""></asp:Label>
                                                    Reviews</h3>
                                                <ul class="list">
                                                    <li><a href="#">5 Stars <i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i
                                                        class="fa fa-star"></i><i class="fa fa-star"></i>
                                                        <asp:Label ID="lblNoOf5Star" runat="server" Text=""></asp:Label></a></li>
                                                    <li><a href="#">4 Stars <i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i
                                                        class="fa fa-star"></i><i class="fa fa-star-empty"></i>
                                                        <asp:Label ID="lblNoOf4Star" runat="server" Text=""></asp:Label></a></li>
                                                    <li><a href="#">3 Stars <i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i
                                                        class="fa fa-star-empty"></i><i class="fa fa-star-empty"></i>
                                                        <asp:Label ID="lblNoOf3Star" runat="server" Text=""></asp:Label></a></li>
                                                    <li><a href="#">2 Stars <i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-empty"></i><i
                                                        class="fa fa-star-empty"></i><i class="fa fa-star-empty"></i>
                                                        <asp:Label ID="lblNoOf2Star" runat="server" Text=""></asp:Label></a></li>
                                                    <li><a href="#">1 Stars <i class="fa fa-star"></i><i class="fa fa-star-empty"></i><i class="fa fa-star-empty"></i><i
                                                        class="fa fa-star-empty"></i><i class="fa fa-star-empty"></i>
                                                        <asp:Label ID="lblNoOf1Star" runat="server" Text=""></asp:Label></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="review_list">
                                        <asp:Repeater ID="rptrReview" runat="server">
                                            <ItemTemplate>
                                                <div class="review_item">
                                                    <div class="media">
                                                        <div class="d-flex">
                                                            <asp:Image ID="imgUser" Height="65px" Width="65px" CssClass="roundImg" ImageUrl='<%#Eval("UserImage") %>' runat="server" />
                                                        </div>
                                                        <div class="media-body">
                                                            <h4>
                                                                <%#Eval("UserName") %>
                                                            </h4>
                                                            <i class='<%#Convert.ToInt32(Eval("Star"))>=1?"fa fa-star":"fa fa-star-empty" %>'></i>
                                                            <i class='<%#Convert.ToInt32(Eval("Star"))>=2?"fa fa-star":"fa fa-star-empty" %>'></i>
                                                            <i class='<%#Convert.ToInt32(Eval("Star"))>=3?"fa fa-star":"fa fa-star-empty" %>'></i>
                                                            <i class='<%#Convert.ToInt32(Eval("Star"))>=4?"fa fa-star":"fa fa-star-empty" %>'></i>
                                                            <i class='<%#Convert.ToInt32(Eval("Star"))>=5?"fa fa-star":"fa fa-star-empty" %>'></i>
                                                        </div>
                                                    </div>
                                                    <p>
                                                        <%#Eval("Review1") %>
                                                    </p>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="review_box">
                                        <h4>Add a Review</h4>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <asp:TextBox ID="tbRating" CssClass="form-control" placeholder="Enter Ratings" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvtbRating" runat="server" ErrorMessage="Enter Rating." ControlToValidate="tbRating"
                                                    ValidationGroup="rating" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                <asp:RangeValidator ID="rngvtbRating" runat="server" ErrorMessage="Enter Rating from 1 to 5." ControlToValidate="tbRating"
                                                    ValidationGroup="rating" Display="Dynamic" CssClass="text-danger" Type="Integer" MinimumValue="1" MaximumValue="5"></asp:RangeValidator>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <asp:TextBox ID="tbReview" CssClass="form-control" placeholder="Enter Review" TextMode="MultiLine" Rows="6" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-12 text-right">
                                            <asp:Button ID="btnSaveReview" runat="server" Text="Submit" ValidationGroup="rating" OnClick="btnSaveReview_Click" CssClass="primary-btn" />
                                        </div>
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
