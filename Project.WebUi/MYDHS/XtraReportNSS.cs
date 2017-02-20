using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace Project.WebUi.MYDHS
{
    public partial class XtraReportNSS : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportNSS()
        {
            InitializeComponent();
        }
        public XtraReportNSS(DateTime startDate, DateTime endDate)
        {
            InitializeComponent();
            this.dataTable1TableAdapter.FillByDate(dataSetMYDHS1.DTNSS, startDate, endDate);
        }
        public XtraReportNSS(string deptID, DateTime startDate, DateTime endDate, bool flag)
        {
            InitializeComponent();
            if (flag)
            {
                this.dataTable1TableAdapter.FillByDeptName(dataSetMYDHS1.DTNSS, deptID, startDate, endDate);
            }
            else
            {
                this.dataTable1TableAdapter.FillByAreaName(dataSetMYDHS1.DTNSS, deptID, startDate, endDate);
            }
        }

        #region 事件顺序
        //xrLabel11_BeforePrint
        //xrLabel11_AfterPrint
        //xrLabel11_HtmlItemCreated
        #endregion
        private void xrLabel11_HtmlItemCreated(object sender, HtmlEventArgs e)
        {
            string res = xrLabel11.Text;
        }

        private void xrLabel11_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            switch (xrLabel11.Text)
            {
                case "F1":
                    xrLabel11.Text = "1、工作稳定感";
                    break;
                case "F2":
                    xrLabel11.Text = "2、医院有标准化的管理流程和护理工作流程";
                    break;
                case "F3":
                    xrLabel11.Text = "3、职业保护设施与设备配备完善";
                    break;
                case "F4":
                    xrLabel11.Text = "4、人身安全保障制度与护理制度保障体系完善";
                    break;
                case "F5":
                    xrLabel11.Text = "5、病房配套设施使病人方便舒适且利于护理操作";
                    break;
                case "F6":
                    xrLabel11.Text = "6、报酬与工作付出成正比";
                    break;
                case "F7":
                    xrLabel11.Text = "7、夜班及节假日的值班、加班补贴满足您的期望";
                    break;
                case "F8":
                    xrLabel11.Text = "8、工作中能得到晋升、评优的机会";
                    break;
                case "F9":
                    xrLabel11.Text = "9、工作中有进修、交流、学习的机会";
                    break;
                case "F10":
                    xrLabel11.Text = "10、您对目前科室的排班模式";
                    break;
                case "F11":
                    xrLabel11.Text = "11、科室实行弹性排班，您有足够的时间安排私人事务 ";
                    break;
                case "F12":
                    xrLabel11.Text = "12、您对科室护理人员配置与护理患者数量的比例";
                    break;
                case "F13":
                    xrLabel11.Text = "13、后勤保障系统能使您有更多的时间服务于病人";
                    break;
                case "F14":
                    xrLabel11.Text = "14、护理管理者能倾听和反馈您在工作中关心的问题";
                    break;
                case "F15":
                    xrLabel11.Text = "15、在工作中被误解时，能得到管理者的帮助并协作处理问题";
                    break;
                case "F16":
                    xrLabel11.Text = "16、您与同事相处和谐";
                    break;
                case "F17":
                    xrLabel11.Text = "17、您的工作得到医疗、医技、后勤人员的理解及尊重";
                    break;
                case "F18":
                    xrLabel11.Text = "18、您认为在现在的管理体制下能体现出自己的价值";
                    break;
                case "F19":
                    xrLabel11.Text = "19、您对科室间配合、同事合作的程度评价";
                    break;
                case "F20":
                    xrLabel11.Text = "20、您对医院及时为临床护理工作解决实际困难";
                    break;
                default:
                    //xrLabel11.Text ="2、医院有标准化的管理流程和护理工作流程";
                    break;
            }
        }

        private void xrLabel11_AfterPrint(object sender, EventArgs e)
        {

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
            totalA += GetCurrentColumnValue<int>("my");
            totalB += GetCurrentColumnValue<int>("jbmy");
            totalC += GetCurrentColumnValue<int>("bmy");
            totalD += GetCurrentColumnValue<int>("kp");
        }

        private void xrLabelSummary_SummaryGetResult(object sender, SummaryGetResultEventArgs e)
        {
            e.Result = (totalA * 5 + totalB * 4 + totalC * 1) * (1.0) / (sampleSize * 100 - totalD * 10);
            e.Handled = true;
        }


    }
}
