<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="ProductMaintenance.aspx.cs" Inherits="KhanaKhajana.Admin.ProductMaintenance" %>

<%@ MasterType VirtualPath="~/Admin/adminMaster.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin | Product Maintenance</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>    
    <script>
        function openModal() {
            jQuery.noConflict();
            $('#discountModal').modal('show');
        }
        function openReviewModal() {
            jQuery.noConflict();
            $('#reviewModal').modal('show');
        }
        <%--$(function () {
            
            $("#<%=tbDisocountModalDiscountPer.ClientID %>").keypress(function (e) {
                e.preventDefault();
                var discountPer = $("#<%=tbDisocountModalDiscountPer.ClientID %>").val();
                var price = $("#<%=lblPriceforUse.ClientID%>").text();

                if (isNaN(discountPer))
                {
                    $(".alert").css("display", "block");
                    $("#type").text("Error!");
                    $("#msg").text("Enter Valid Discount Percentage.");
                    setTimeout(hideAlert, 2000);
                }
                else
                {
                    alert(discountPer);
                    var discountedPrice = (price * discountPer) / 100;
                    $("#<%=lblDiscountModalDiscountedPrice.ClientID%>").text("Discounted Price :- $ "+discountedPrice);
                }                
            });

        });--%>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>--%>
            <div class="row">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="tbProductName">Product Name</label>
                        <asp:Label ID="lblProductId" Visible="false" runat="server" Text=""></asp:Label>
                        <asp:TextBox ID="tbProductName" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbProductName" runat="server" ErrorMessage="Enter Product name" Text="Enter Product name"
                            ControlToValidate="tbProductName" Display="Dynamic" ValidationGroup="product" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="tbProductIngridents">Product Ingridents</label>
                        <asp:TextBox ID="tbProductIngridents" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbProductIngridents" Display="Dynamic" runat="server" ErrorMessage="Enter Product Ingridents" Text="Enter Product Ingridents"
                            ControlToValidate="tbProductIngridents" ValidationGroup="product" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                </div>


                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlCategory">Category</label>
                        <asp:DropDownList ID="ddlCategory" AutoPostBack="true" CssClass="form-control" runat="server"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvddlCategory" InitialValue="0" runat="server" Display="Dynamic" ErrorMessage="Select Category" Text="Select Category"
                            ControlToValidate="ddlCategory" ValidationGroup="product" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="tbPrice">Price (CAD.)</label>
                        <asp:TextBox ID="tbPrice" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtbPrice" runat="server" ErrorMessage="Enter Price" Display="Dynamic" Text="Enter Price"
                            ControlToValidate="tbPrice" ValidationGroup="product" CssClass="text-danger"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rngvtbPrice" runat="server" ErrorMessage="Enter Valid Prices" Text="Enter Valid Price" CssClass="text-danger" Display="Dynamic" ControlToValidate="tbPrice"
                            Type="Double" MinimumValue="1" ValidationGroup="product" MaximumValue="2000"></asp:RangeValidator>
                        <asp:CompareValidator ID="comvtbPrice" runat="server" ErrorMessage="Enter Valid Prices" Text="Enter Valid Prices" Display="Dynamic" CssClass="text-danger"
                            ControlToValidate="tbPrice" Operator="DataTypeCheck" ValidationGroup="product" Type="Double"></asp:CompareValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="fileProductImage">Image</label>
                        <asp:FileUpload ID="fileProductImage" runat="server" />
                        <%--<asp:RequiredFieldValidator ID="rfvfileProductImage" runat="server" ErrorMessage="Select Image" Text="Select Image"
                    ControlToValidate="fileProductImage" ValidationGroup="product" CssClass="text-danger"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <%--<label for="fileProductImage">Is Feature</label>--%>
                        <asp:CheckBox ID="chkIsFeature" CssClass="checkbox" runat="server" />Is Feature
                    </div>
                </div>
                <div class="col-lg-3">
                    <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="product" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" OnClick="btnClear_Click" />
                </div>
            </div>

            <div class="row">
                <h1>List Of Products</h1>
            </div>
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-3">
                    <div class="form-group">
                        <label for="ddlCategory">Category</label>
                        <asp:DropDownList ID="ddlCategoryShowProduct" AutoPostBack="true" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-3">
                    <asp:Button ID="btnShow" runat="server" Text="Show Products" CssClass="btn btn-primary martop" OnClick="btnShow_Click" />
                </div>
                <div class="col-lg-3"></div>
            </div>
            <div class="row bg-gray">
                <asp:GridView ID="gvProducts" OnPageIndexChanging="gvProducts_PageIndexChanging" CssClass="table table-bordered table-hover" runat="server"
                    AutoGenerateColumns="false" AllowPaging="true" PageSize="10">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <%#Eval("ProductName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate>
                                <%#Eval("CategoryName") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ingridents" ItemStyle-CssClass="wordwrap">
                            <ItemTemplate>
                                <%#Eval("ingredients") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                <%#"$ "+Eval("Price") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Feature">
                            <ItemTemplate>
                                <%#Convert.ToBoolean(Eval("IsFeature"))==true?"Yes":"No" %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <asp:Image ID="imgProduct" ImageUrl='<%#Eval("Image") %>' CssClass="img-lg" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="gvLbEdit" runat="server" CssClass="btn btn-sm btn-success" OnCommand="gvLbEdit_Command" CommandName='<%#Eval("ProductId") %>'><i class="fa fa-edit" title="Edit"></i></asp:LinkButton>
                                <asp:LinkButton ID="gvLbDelete" runat="server" CssClass="btn btn-sm btn-danger" OnCommand="gvLbDelete_Command" CommandName='<%#Eval("ProductId") %>'><i class="fa fa-trash-o" title="Delete"></i></asp:LinkButton>
                                <asp:LinkButton ID="gvLbDiscount" runat="server" CssClass="btn btn-sm btn-success" OnCommand="gvLbDiscount_Command" CommandName='<%#Eval("ProductId") %>'><i class="fa fa-dollar" title="Add Discount"></i></asp:LinkButton>
                                <asp:LinkButton ID="GVLbReiew" runat="server" CssClass="btn btn-sm btn-success" OnCommand="GVLbReiew_Command" CommandName='<%#Eval("ProductId") %>'><i class="fa fa-feed" title="View Reviews"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle BackColor="Black" ForeColor="White" Height="40px" Font-Size="Medium" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination-lg pagerSpace" />
                </asp:GridView>
            </div>
            <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server"
                DisplayAfter="1000" DynamicLayout="false" class="loading">
                <ProgressTemplate>
                    <img src="../Content/img/loading.gif" />
                    Please Wait        
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>--%>
    <!-- Modal For Discount -->
    <div class="modal fade" id="discountModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">
                        <asp:Label ID="lblDiscountModalTitle" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblDiscountModalDiscountId" Visible="false" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblDiscountModalProductId" Visible="false" runat="server" Text=""></asp:Label>
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="form-group">
                                <label for="tbPrice">Discount (%)</label>
                                <asp:TextBox ID="tbDisocountModalDiscountPer" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtbDisocountModalDiscountPer" runat="server" ErrorMessage="Enter Discount Percent" Text="Enter Discount Percent"
                                    ControlToValidate="tbDisocountModalDiscountPer" ValidationGroup="discountModal" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="ranvtbDisocountModalDiscountPer" runat="server" ErrorMessage="Enter Valid Value" Text="Enter Valid Value" ControlToValidate="tbPrice"
                                    Type="Double" MinimumValue="1" MaximumValue="99" Display="Dynamic" ValidationGroup="discountModal" CssClass="text-danger"></asp:RangeValidator>
                                <asp:CompareValidator ID="comvtbDisocountModalDiscountPer" runat="server" ErrorMessage="Enter Valid Value" Text="Enter Valid Value" CssClass="text-danger"
                                    ControlToValidate="tbDisocountModalDiscountPer" Display="Dynamic" Operator="DataTypeCheck" Type="Double" ValidationGroup="discountModal"></asp:CompareValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <asp:Label ID="lblDiscountModalOriginalPrice" runat="server" Text=""></asp:Label>
                            <asp:TextBox ID="tbPriceforUse" runat="server" Visible="false" Text=""></asp:TextBox>
                        </div>
                        <div class="col-lg-4">
                            <asp:Label ID="lblDiscountModalDiscountedPrice" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnDiscountModalSave" runat="server" CssClass="btn btn-primary" OnClick="btnDiscountModalSave_Click" ValidationGroup="discountModal" Text="Save"></asp:Button>
                    <asp:Button ID="btnDiscountModalDelete" runat="server" CssClass="btn btn-danger" OnClick="btnDiscountModalDelete_Click" Enabled="false" Text="Delete"></asp:Button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal For Discount End -->

    <!-- Modal For Review Start -->

    <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="exampleModalLabel">
                        <asp:Label ID="lblReviewMOdalTitle" runat="server" Text=""></asp:Label>
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2">
                                <div class="box_total bg-gray pad text-center roundcont">
                                    <h2>Overall</h2>
                                    <h3>
                                        <asp:Label ID="lblOverAllRating" runat="server" Text=""></asp:Label>
                                    </h3>
                                    <h5>(<asp:Label ID="lblNoOfReviews" runat="server" Text=""></asp:Label>
                                        Reviews)</h5>
                                </div>
                            </div>
                            <div class="col-lg-2"></div>
                            <div class="col-lg-4">
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
                            <div class="col-lg-2"></div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-8">
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
                                                        <%#"( "+Eval("Date","{0:%d/%M/%y}")+" )" %>
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
                                        <hr />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>                    
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>

    <!-- Modal For Review End -->
</asp:Content>
