using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.MYDYS
{
    public partial class XtraReportMYDYS : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportMYDYS()
        {
            InitializeComponent();
        }
        public XtraReportMYDYS(DateTime startDate, DateTime endDate)
        {
            InitializeComponent();
            this.mYDYSTableAdapter.Fill(this.dataSetMYDYS1.MYDYS, startDate, endDate);
        }
        public XtraReportMYDYS(string  deptID, DateTime startDate, DateTime endDate, bool flag)
        {
            InitializeComponent();
            if (flag)
            {
                this.mYDYSTableAdapter.FillByDeptName(this.dataSetMYDYS1.MYDYS, deptID, startDate, endDate);
            }
            else
            {
                this.mYDYSTableAdapter.FillByAreaName(this.dataSetMYDYS1.MYDYS, deptID, startDate, endDate);
            }
        }


        private void xrLabel11_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            switch (xrLabel11.Text)
            {
                case "F1":
                    xrLabel11.Text = "1、您对科室护理工作总体情况评价";
                    break;
                case "F2":
                    xrLabel11.Text = "2、您对护士的病情观察和评判能力";
                    break;
                case "F3":
                    xrLabel11.Text = "3、您对护士及时、准确执行医嘱";
                    break;
                case "F4":
                    xrLabel11.Text = "4、您对护士的沟通能力及服务态度";
                    break;
                case "F5":
                    xrLabel11.Text = "5、您对护士能主动及时向患者进行有效的健康宣教";
                    break;
                case "F6":
                    xrLabel11.Text = "6、您对科室护理人员技术操作水平";
                    break;
                case "F7":
                    xrLabel11.Text = "7、您对科室护理人员专科护理能力";
                    break;
                case "F8":
                    xrLabel11.Text = "8、您对科室护理人员应急能力";
                    break;
                case "F9":
                    xrLabel11.Text = "9、您对科室目前护士长对护理人力安排";
                    break;
                case "F10":
                    xrLabel11.Text = "10、您对本科室医护之间配合度";
                    break;
                default:
                    break;
            }
        }
        int totalA = 0;
        int totalB = 0;
        int totalC = 0;
        int totalD = 0;
        int sampleSize = 0;
        private void xrLabelSummary_SummaryReset(object sender, EventArgs e)
        {
            totalA = 0;
            totalB = 0;
            totalC = 0;
            totalD = 0;
            sampleSize = GetCurrentColumnValue<int>("my") + GetCurrentColumnValue<int>("jbmy") + GetCurrentColumnValue<int>("bmy") + GetCurrentColumnValue<int>("kp");
        }

        private void xrLabelSummary_SummaryRowChanged(object sender, EventArgs e)
        {
            totalA += (int)GetCurrentColumnValue("my");
            totalB += (int)GetCurrentColumnValue("jbmy");
            totalC += (int)GetCurrentColumnValue("bmy");
            totalD += (int)GetCurrentColumnValue("kp");
        }

        private void xrLabelSummary_SummaryGetResult(object sender, SummaryGetResultEventArgs e)
        {
            e.Result = (totalA * 10 + totalB * 8 + totalC * 2) * (1.0) / (sampleSize * 100 - totalD * 10);
            e.Handled = true;
        }

    }
}
