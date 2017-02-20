using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class PivotGridDept : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                teYear.DateTime = DateTime.Now;
            }
            ASPxGridView1.DataBind();
            ASPxGridView1.SettingsText.Title = loginUser.DeptId;
        }


        protected void ASPxGridView1_BeforePerformDataSelect(object sender, EventArgs e)
        {
            SqlDataSource1.SelectParameters["dept"].DefaultValue = loginUser.DeptId;
            SqlDataSource1.SelectParameters["year"].DefaultValue = teYear.Text;
        }
    }
}