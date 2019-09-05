using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KhanaKhajana.Admin
{
    public partial class adminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUserId"] == null || Convert.ToString(Session["AdminUserId"]) == "")
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        public string PageHeader
        {
            get
            {
                return lblPageHeader.Text;
            }
            set
            {
                lblPageHeader.Text = value;
            }
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session["AdminUserId"] = "";
            Response.Redirect("~/Login.aspx");
        }
    }
}