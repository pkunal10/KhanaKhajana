<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="KhanaKhajana.ContactUs" %>

<%@ MasterType VirtualPath="~/user.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Contact Us</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <section class="contact_area section_gap_bottom">
                <div class="container">
                    <div class="mapBox">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2897.6755615882116!2d-80.4428541845096!3d43.42560487912984!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x882b8ad90aff500f%3A0x264090a64b33a48f!2s2969+Kingsway+Dr%2C+Kitchener%2C+ON+N2C+2H7!5e0!3m2!1sen!2sca!4v1552435650328" width="600" height="450" class="col col-12" frameborder="0" style="border: 0" allowfullscreen></iframe>
                    </div>
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="contact_info">
                                <div class="info_item">
                                    <i class="lnr lnr-home"></i>
                                    <h6>Kitchener, Canada</h6>
                                    <p>2969,Kingsway Dr.</p>
                                </div>
                                <div class="info_item">
                                    <i class="lnr lnr-phone-handset"></i>
                                    <h6><a href="#">00 (440) 9865 562</a></h6>
                                    <p>Mon to Sun 9am to 9 pm</p>
                                </div>
                                <div class="info_item">
                                    <i class="lnr lnr-envelope"></i>
                                    <h6><a href="#">khajana246@gmail.com</a></h6>
                                    <p>Send us your query anytime!</p>
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
