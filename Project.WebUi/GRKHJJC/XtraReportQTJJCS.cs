using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.GRKHJJC
{
    public partial class XtraReportQTJJCS : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportQTJJCS()
        {
            InitializeComponent();
        }
        public XtraReportQTJJCS(int id)
        {
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.gRK_JYBGTableAdapter.Fill(this.databaseGRK1.GRK_JYBG,id);
            //this.xtraReportJYBGItem1.grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            //((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell1.Text = "指示菌株";
        }
    }
}
