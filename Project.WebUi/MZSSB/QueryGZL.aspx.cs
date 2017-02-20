using Project.Bll;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.MZSSB
{
    public partial class QueryGZL : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ASPxTimeEdit1.DateTime = System.DateTime.Now;
            }
           
        }
        protected string GetSJDF(object value)
        {
            decimal hj = Convert.ToDecimal(value);
            decimal ave = Convert.ToDecimal(lblAVE.Text);

            decimal sjdf = hj / ave;
            return sjdf.ToString("0.000");
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            WorkLoadBll bll = new WorkLoadBll();
            lblSum.Text = bll.GetWorkLoadSUM(ASPxTimeEdit1.DateTime.Year, ASPxTimeEdit1.DateTime.Month).ToString("0.000");
            lblAVE.Text = bll.GetWorkLoadAverage(ASPxTimeEdit1.DateTime.Year, ASPxTimeEdit1.DateTime.Month).ToString("0.000");
            rptList.DataSource = bll.QueryAllByDate(ASPxTimeEdit1.DateTime.Year, ASPxTimeEdit1.DateTime.Month);
            rptList.DataBind();
        }
    }
}