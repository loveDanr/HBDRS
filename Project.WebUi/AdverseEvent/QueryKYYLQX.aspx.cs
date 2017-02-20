using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class QueryKYYLQX : MyBasePage
    {
        //
        
        //
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                ASPxTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-1).Date;
                ASPxTimeEditEnd.DateTime = System.DateTime.Now.Date;
            }
            if (loginUser.DeptId != "562")
            {

                ASPxGridView1.Columns[0].Visible = false;
                ASPxGridView1.Columns[2].Visible = false;
                SqlDataSource1.SelectCommand += " and rBGKS=@rBGKS";
                SqlDataSource1.SelectParameters["rBGKS"].DefaultValue = loginUser.DeptId.ToString();

            }
            else
            {
                SqlDataSource1.SelectParameters["rBGKS"].DefaultValue = loginUser.DeptId.ToString();
            }

        }
    }
}