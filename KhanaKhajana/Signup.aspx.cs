using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPSnippets.FaceBookAPI;
using System.Web.Script.Serialization;
using KhanaKhajana.Models;
using KhanaKhajana.Services;
using System.IO;
using System.Net;

namespace KhanaKhajana
{
    public partial class Signup : System.Web.UI.Page
    {
        #region GlobalVariables

        UserServices userServices = new UserServices();
        User user = new User();

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            FaceBookConnect.API_Key = "293369464689180";
            FaceBookConnect.API_Secret = "5e5dad63bb5bbd5aad071a2ead927e21";
            if (!IsPostBack)
            {
                this.Master.PageHeader = "Sign up";
                if (Request.QueryString["error"] == "access_denied")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User has denied access.')", true);
                    return;
                }

                string code = Request.QueryString["code"];
                if (!string.IsNullOrEmpty(code))
                {
                    string data = FaceBookConnect.Fetch(code, "me?fields=id,name,email");
                    FacebookUser faceBookUser = new JavaScriptSerializer().Deserialize<FacebookUser>(data);
                    faceBookUser.PictureUrl = string.Format("https://graph.facebook.com/{0}/picture", faceBookUser.Id);
                    //lblUserName.Text = faceBookUser.UserName;
                    tbFname.Text = faceBookUser.Name.Split(new[] { " " }, StringSplitOptions.None)[0];
                    tbLname.Text = faceBookUser.Name.Split(new[] { " " }, StringSplitOptions.None)[1];
                    tbEmailId.Text = faceBookUser.Email;
                    imgProfilePic.ImageUrl = faceBookUser.PictureUrl;
                    tbMobileNo.Text = faceBookUser.Mobile;
                    btnFbSignup.Enabled = false;
                }
            }
        }

        protected void btnFbSignup_Click(object sender, EventArgs e)
        {
            FaceBookConnect.Authorize("user_photos,email", Request.Url.AbsoluteUri.Split('?')[0]);
        }

        protected void lbChangeImg_Click(object sender, EventArgs e)
        {
            imgProfilePic.Visible = false;
            lbChangeImg.Visible = false;
            flieImage.Visible = true;
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            //if (imgProfilePic.Visible)
            //{
            //    AddUserWithFBImage();
            //}
            //else
            //{
            //    AddUserWithUploadedImage();
            //}
            AddUserWithUploadedImage();
        }

        private void AddUserWithFBImage()
        {
            string response = "";
            if (userServices.IsEmailIdExists(tbEmailId.Text))
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','This Email id already has an account.')", true);
            }
            else if (tbMobileNo.Text.Length != 10)
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Invalid Mobile No.')", true);
            }
            else
            {
                string remoteImageUrl = imgProfilePic.ImageUrl;
                string strRealname = Path.GetFileName(remoteImageUrl);
                string exts = Path.GetExtension(remoteImageUrl);

                WebClient webClient = new WebClient();
                webClient.DownloadFile(remoteImageUrl, Server.MapPath("~/Admin/UserImages/") + strRealname + exts);

                //System.Drawing.Image im = System.Drawing.Image.FromFile(Server.MapPath(imgProfilePic.ImageUrl));
                //im.Save(Server.MapPath("~/Admin/UserImages/" + tbEmailId.Text + ".jpg"));
                user.Fname = tbFname.Text;
                user.Lname = tbLname.Text;
                user.AddressLine1 = tbAddressLine1.Text;
                user.City = tbCity.Text;
                user.Province = tbProvince.Text;
                user.ZipCode = tbZipCode.Text;
                user.MobileNo = tbMobileNo.Text;
                user.EmailId = tbEmailId.Text;
                user.Password = tbPassword.Text;
                user.Image = "~/Admin/UserImages/" + tbEmailId.Text + ".jpg";

                response = userServices.AddUser(user);
                if (response == "Success")
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "alert('Successfully registered.');window.location ='Login.aspx'", true);
                    Clear();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                }
            }
        }

        private void AddUserWithUploadedImage()
        {
            string response = "";
            if (userServices.IsEmailIdExists(tbEmailId.Text))
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','This Email id already has an account.')", true);
            }
            else if (tbMobileNo.Text.Length != 10)
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Invalid Mobile No.')", true);
            }
            else if (!flieImage.HasFile)
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Please Select Image.')", true);
            }
            else
            {
                string ext = System.IO.Path.GetExtension(flieImage.FileName).ToLower();
                if (ext == ".jpg" || ext == ".png" || ext == ".jpeg" || ext == ".gif")
                {

                    flieImage.SaveAs(Server.MapPath("~/Admin/UserImages/" + tbEmailId.Text + "." + ext));
                    user.Fname = tbFname.Text;
                    user.Lname = tbLname.Text;
                    user.AddressLine1 = tbAddressLine1.Text;
                    user.City = tbCity.Text;
                    user.Province = tbProvince.Text;
                    user.ZipCode = tbZipCode.Text;
                    user.MobileNo = tbMobileNo.Text;
                    user.EmailId = tbEmailId.Text;
                    user.Password = tbPassword.Text;
                    user.Image = "~/Admin/UserImages/" + tbEmailId.Text + "." + ext;

                    response = userServices.AddUser(user);
                    if (response == "Success")
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Success','Successfully registered.');window.location ='Login.aspx'", true);
                        Clear();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','" + response + "')", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showAlert('Error!','Please select image only.')", true);
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void Clear()
        {
            tbFname.Text = "";
            tbLname.Text = "";
            tbAddressLine1.Text = "";
            tbCity.Text = "";
            tbProvince.Text = "";
            tbZipCode.Text = "";
            tbPassword.Text = "";
            tbEmailId.Text = "";
            tbPassword.Text = "";
            imgProfilePic.ImageUrl = "~/Admin/UserImages/default.png";
            imgProfilePic.Visible = true;
            flieImage.Visible = false;

        }
    }
}