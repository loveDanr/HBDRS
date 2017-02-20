using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class StatisticsEvent : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-3).Date;
                ASPxTimeEditEnd.DateTime = System.DateTime.Now;
            }
            //参见Q365706
            //WebChartControl1.RegisterSummaryFunction();   
        }
        //参见Q304974  E1411
        protected void WebChartControl1_CustomDrawSeriesPoint(object sender, DevExpress.XtraCharts.CustomDrawSeriesPointEventArgs e)
        {
            //if (((System.Data.DataRowView)(e.SeriesPoint.Tag))[2] != null)
                //e.LabelText = string.Format( "{0:p}" ,((System.Data.DataRowView)(e.SeriesPoint.Tag))[2]);
                
                
        }
    }
}