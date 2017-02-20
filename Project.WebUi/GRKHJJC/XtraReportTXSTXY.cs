using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.GRKHJJC
{
    public partial class XtraReportTXSTXY : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportTXSTXY()
        {
            InitializeComponent();
        }
        public XtraReportTXSTXY(int id)
        {
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.gRK_JYBGTableAdapter.Fill(this.databaseGRK1.GRK_JYBG, id);
            //this.xtraReportJYBGItem1.grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            //this.xtraReportJYBGItem1.xrTableCell1.Text = "类别";
            //this.xtraReportJYBGItem1.xrTableCell3.Text = "执行标准(cfu/ml)";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell1.Text = "类别";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell2.Text = "监测结果(cfu/ml)";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell3.Text = "参考值(cfu/ml)";
        }

    }
}
