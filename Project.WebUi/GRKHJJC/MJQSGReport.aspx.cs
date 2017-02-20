using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.GRKHJJC
{
    public partial class MJQSGReport : Project.WebUi.App_Code.MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            Int32.TryParse(Request.QueryString["id"], out id);

            ReportViewer1.Report = new XtraReportMJQSG(id);
        }
    }
}