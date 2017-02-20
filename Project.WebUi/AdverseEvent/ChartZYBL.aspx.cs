using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class ChartZYBL : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-3).Date;
                ASPxTimeEditEnd.DateTime = System.DateTime.Now;
            }
            string sc = SqlDataSource1.SelectCommand;
            SqlDataSource1.SelectCommand = sc.Replace("JB_BLDD", ASPxComboBox1.SelectedItem.Value.ToString());
        }

        protected void ASPxComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sc =SqlDataSource1.SelectCommand;
            SqlDataSource1.SelectCommand = sc.Replace("JB_BLDD", ASPxComboBox1.SelectedItem.Value.ToString());
        }
    }
}