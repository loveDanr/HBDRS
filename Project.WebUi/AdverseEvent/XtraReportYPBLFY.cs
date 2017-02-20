using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.AdverseEvent
{
    public partial class XtraReportYPBLFY : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportYPBLFY()
        {
            InitializeComponent();
        }
        public XtraReportYPBLFY(int id)
        {
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.aE_ShareEventInfoTableAdapter1.FillByID(this.dataSetAE1.AE_ShareEventInfo, id);

        }
    }
}
