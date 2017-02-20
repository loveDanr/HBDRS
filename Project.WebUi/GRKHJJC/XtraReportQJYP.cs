using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.GRKHJJC
{
    public partial class XtraReportQJYP : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportQJYP()
        {
            InitializeComponent();
        }
        public XtraReportQJYP(int id)
        {
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.grK_JYBGTableAdapter1.Fill(this.databaseGRK1.GRK_JYBG, id);
            //this.xtraReportJYBGItem1.grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            //this.xtraReportJYBGItem1.xrTableCell1.Text = "类别";
            //this.xtraReportJYBGItem1.xrTableCell3.Text = "执行标准(cfu/ml)";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell1.Text = "类别";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell2.Text = "监测结果(cfu/件)";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell3.Text = "执行标准(cfu/件)";
        }
    }
}
