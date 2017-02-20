using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.GRKHJJC
{
    public partial class XtraReportZLQXSG : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportZLQXSG()
        {
            InitializeComponent();
        }
        public XtraReportZLQXSG(int id)
        {
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.gRK_JYBGTableAdapter.Fill(this.databaseGRK1.GRK_JYBG, id);
            //this.xtraReportJYBGItem1.grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell1.Text = "类别";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell1.WidthF = 105;
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell2.Text = "监测结果(cfu/100cm²)";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell2.WidthF = 160;
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell3.Text = "执行标准(cfu/100cm²)";
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell3.WidthF = 160;
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell4.WidthF = 105;
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell5.WidthF = 160;
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).xrTableCell6.WidthF = 160;
        }
    }
}
