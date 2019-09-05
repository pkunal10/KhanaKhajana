<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/adminMaster.Master" AutoEventWireup="true" CodeBehind="CategoryMaintenance.aspx.cs" Inherits="KhanaKhajana.Admin.CategoryMaintenance" %>

<%@ MasterType VirtualPath="~/Admin/adminMaster.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin | Category Maintenance</title>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <%--<div class="alert">
        <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        <strong id="type"></strong>&nbsp;&nbsp;<span id="msg"></span>
    </div>--%>
    <%--<div class="alert alert-success">
        <strong>Success!</strong> Indicates a successful or positive action.
    </div>--%>    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <div class="row">
                <div class="col-lg-3">
                    <div class="form-group">
                        <asp:Label ID="lblCategoryId" Visible="false" runat="server" Text=""></asp:Label>
                        <label for="tbCategoryName">Category Name</label>
                        <asp:TextBox ID="tbCategoryName" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTbCategoryName" runat="server" ErrorMessage="Enter category name" Text="Enter category name"
                            ControlToValidate="tbCategoryName" ValidationGroup="category" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>

                    <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="category" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" OnClick="btnClear_Click" />
                </div>
                <div class="col-lg-9" style="background-color: white;">
                    <%--<table class="table table-bordered table-hover" style="margin-top: 5px;">
                <thead style="background-color: black; color: white;">
                    <tr>
                        <th>S.No</th>
                        <th>Category Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody style="overflow: scroll; height: 100px;">
                    <asp:Repeater ID="rptrCategories" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%#Container.ItemIndex+1 %></td>
                                <td><%#Eval("CategoryName") %></td>
                                <td>
                                    <button class="btn-success"><i class="fa fa-edit"></i></button>
                                    <button class="btn-danger"><i class="fa fa-trash-o"></i></button>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>--%>
                    <asp:GridView ID="gvCategories" OnPageIndexChanging="gvCategories_PageIndexChanging" CssClass="table table-bordered table-hover" runat="server"
                        AutoGenerateColumns="false" AllowPaging="true" PageSize="10">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category Name">
                                <ItemTemplate>
                                    <%#Eval("CategoryName") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="gvLbEdit" runat="server" CssClass="btn btn-sm btn-success" OnCommand="gvLbEdit_Command" CommandName='<%#Eval("CategoryId") %>'><i class="fa fa-edit" title="Edit"></i></asp:LinkButton>
                                    <asp:LinkButton ID="gvLbDelete" runat="server" CssClass="btn btn-sm btn-danger" OnCommand="gvLbDelete_Command" CommandName='<%#Eval("CategoryId") %>'><i class="fa fa-trash-o" title="Delete"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="Black" ForeColor="White" Height="40px" Font-Size="Medium" />
                        <PagerSettings Mode="NumericFirstLast" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination-lg pagerSpace" />
                    </asp:GridView>
                </div>
            </div>
            <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0" DynamicLayout="true" class="loading">
                <ProgressTemplate>
                    <img src="../Content/img/loading.gif" />
                    Please Wait        
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
