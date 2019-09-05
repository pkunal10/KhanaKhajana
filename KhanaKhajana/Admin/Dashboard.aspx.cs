using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanaKhajana.Models;
using KhanaKhajana.Services;

namespace KhanaKhajana.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        #region Global Variables
        OrderServices orderServices = new OrderServices();
        CommonFunctions commonFunction = new CommonFunctions();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                this.Master.PageHeader = "Dashboard";
                DisplayWeeklyChart();
                DisplayMonthlyChart();
                DisplayCommonDetails();
            }
        }

        private void DisplayCommonDetails()
        {
            CommonDetails details = new CommonDetails();
            details = commonFunction.GetCommonDetails();
            lblNoOfSales.Text = details.NoOfSales.ToString();
            lblNoOfUsers.Text = details.NoOfUsers.ToString();
        }

        private void DisplayMonthlyChart()
        {
            var list = orderServices.GetMonthlyChart();
            decimal[] noOfrders = new decimal[list.Count];
            String[] dates = new String[list.Count];
            for (int i = 0; i < list.Count; i++)
            {
                noOfrders[i] = list[i].NoOfOrders;
                dates[i] = list[i].Date.Value.ToShortDateString();
            }

            bcMonthlySales.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = noOfrders });
            bcMonthlySales.CategoriesAxis = string.Join(",", dates);
            bcMonthlySales.ChartTitle = "Monthly Sales Graph";            
        }

        private void DisplayWeeklyChart()
        {
            var list = orderServices.GetWeeklyChart();
            decimal[] noOfrders=new decimal[list.Count];
            String[] dates=new String[list.Count];
            for(int i=0;i<list.Count;i++)
            {
                noOfrders[i]=list[i].NoOfOrders;
                dates[i] = list[i].Date.Value.ToShortDateString();
            }

            bcWeeklySales.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = noOfrders });
            bcWeeklySales.CategoriesAxis = string.Join(",", dates);
            bcWeeklySales.ChartTitle = "Weekly Sales Graph";            
        }
    }
}