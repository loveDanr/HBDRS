using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.GRKHJJC
{
    public partial class XtraReportJJCSJC : DevExpress.XtraReports.UI.XtraReport
    {
        private int itemID = -1;
        //public XtraReportJJCSJC()
        //{
        //    InitializeComponent();
        //}
        public XtraReportJJCSJC(int id)
        {
            itemID = id;
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.grK_JYBGTableAdapter1.Fill(this.databaseGRK1.GRK_JYBG,id);
            //this.xtraReportJYBGItem1.grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);
            if (this.databaseGRK1.GRK_JYBG.Rows[0]["ReportCategory"].ToString() == "JJCSJC")
            {
                this.xrLabel1.Text = "新乡市中心医院洁净手术室空气监测检验报告单";
            }
            if (this.databaseGRK1.GRK_JYBG.Rows[0]["ReportCategory"].ToString() == "JPZX_JJCSJC")
            {
                this.xrLabel1.Text = "新乡市中心医院超净工作台空气监测报告单";
            }
            ((XtraReportJYBGItem)this.xrSubreport1.ReportSource).grK_JYBGitemTableAdapter1.Fill(this.databaseGRK1.GRK_JYBGitem, id);

        }
    }
}
