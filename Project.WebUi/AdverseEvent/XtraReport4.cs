﻿using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.AdverseEvent
{
    public partial class XtraReport4 : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReport4()
        {
            InitializeComponent();
        }
        public XtraReport4(int id)
        {
            InitializeComponent();
            SetReportData(id);
        }
        private void SetReportData(int id)
        {
            this.aE_ShareEventInfoTableAdapter.FillByID(this.dataSetAE1.AE_ShareEventInfo, id);


        }

    }
}
