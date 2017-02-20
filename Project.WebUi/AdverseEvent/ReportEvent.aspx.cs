using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class ReportEvent : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id;
            Int32.TryParse(Request.QueryString["id"], out id);
            string eventName = Request.QueryString["name"];//Server.UrlDecode(Request.QueryString["name"]); 两个都可以
            //ASPxDocumentViewer1.Report = new XtraReport4(id);

            switch(eventName)
            {
                case "医疗医技不良事件":
                    ASPxDocumentViewer1.Report = new XtraReportYLYJ(id);
                    break;
                case "医疗不良事件":
                    ASPxDocumentViewer1.Report = new XtraReportYLYJ(id);
                    break;
                case "医技不良事件":
                    ASPxDocumentViewer1.Report = new XtraReportYLYJ(id);
                    break;
                case "职业暴露":
                    ASPxDocumentViewer1.Report = new XtraReportZYBL(id);
                    break;
                case "职业暴露-阳性":
                    ASPxDocumentViewer1.Report = new XtraReportZYBL(id);
                    break;
                case "职业暴露-阴性":
                    ASPxDocumentViewer1.Report = new XtraReportZYBLN(id);
                    break;
                case "输血不良事件":
                    ASPxDocumentViewer1.Report = new XtraReportSXBL(id);
                    break;
                case "医学装备不良事件":
                    ASPxDocumentViewer1.Report = new XtraReport2(id);
                    break;
                case "药品不良事件-药品不良反应":
                    ASPxDocumentViewer1.Report = new XtraReportYPBLFY(id);
                    break;
                case "药品不良事件-用药错误":
                    ASPxDocumentViewer1.Report = new XtraReportYYCW(id);
                    break;
                case "药品不良事件-药品损害":
                    ASPxDocumentViewer1.Report = new XtraReportYPSH(id);
                    break;
                case "药品不良事件-药品质量":
                    ASPxDocumentViewer1.Report = new XtraReportYPZL(id);
                    break;
                case "护理不良事件-压疮":
                    ASPxDocumentViewer1.Report = new XtraReportHLYC(id);
                    break;
                case "压疮事件":
                    ASPxDocumentViewer1.Report = new XtraReportHLYC(id);
                    break;
                case "护理不良事件-跌倒/坠床":
                    ASPxDocumentViewer1.Report = new XtraReportHLDDZC(id);
                    break;
                case "护理不良事件-坠床":
                    ASPxDocumentViewer1.Report = new XtraReportHLDDZC(id);
                    break;
                case "护理不良事件-跌倒":
                    ASPxDocumentViewer1.Report = new XtraReportHLDDZC(id);
                    break;
                case "护理不良事件-管路滑脱":
                    ASPxDocumentViewer1.Report = new XtraReportHLGLHT(id);
                    break;
                case "护理不良事件-输液反应":
                    ASPxDocumentViewer1.Report = new XtraReportHLSYFY(id);
                    break;
                case "护理不良事件-其他":
                    ASPxDocumentViewer1.Report = new XtraReportHLQT(id);
                    break;
                default:
                    ASPxDocumentViewer1.Report = new XtraReport1(id);
                    break;
            }
        }
    }
}