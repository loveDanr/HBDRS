using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.GRKHJJC
{
    public partial class HJWSSGReport : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            Int32.TryParse(Request.QueryString["id"], out id);

            ReportViewer1.Report = new XtraReportHJWSSG(id);
        }
    }
}