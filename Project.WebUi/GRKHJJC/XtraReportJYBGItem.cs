using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.GRKHJJC
{
    public partial class XtraReportJYBGItem : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportJYBGItem()
        {
            InitializeComponent();
        }
        public XtraReportJYBGItem(int id)
        {
            InitializeComponent();
            SetDataSource(id);
        }
        private void SetReportData(int id)
        {         
            this.grK_JYBGitemTableAdapter1.Fill(this.databaseGRK.GRK_JYBGitem, id);
        }
    }
}
