using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.GRKHJJC
{
    public partial class XtraReportMJQSG : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportMJQSG()
        {
            InitializeComponent();
        }
        public XtraReportMJQSG(int id)
        {
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.gRK_JYBGTableAdapter.Fill(this.databaseGRK1.GRK_JYBG, id);
            //this.xtraReportJYBGItem1.XtraReportJYBGItem.grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            //this.xtraReportJYBGItem1.xrTableCell1.Text = "指示菌株";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell1.Text = "指示菌株";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell3.Text = "";
            //((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell3.Visible = false;
            
            
        }
    }
}
