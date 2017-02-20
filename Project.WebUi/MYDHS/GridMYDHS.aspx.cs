using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using Project.Bll;
using System.Data;
using Project.WebUi.App_Code;

namespace Project.WebUi.MYDHS
{
    public partial class GridMYDHS : MyBasePage
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxDropDownEditDept.Text = "全院";
                ASPxTimeEditStart.DateTime = System.DateTime.Now;
            }

            this.ReportViewer1.Report = CreateReport();


        }
        protected void ASPxTreeViewDept_VirtualModeCreateChildren(object source, TreeViewVirtualModeCreateChildrenEventArgs e)
        {
            HLBQBll bll = new HLBQBll();
            List<TreeViewVirtualNode> list = new List<TreeViewVirtualNode>();
            if (e.NodeName == null)
            {
                TreeViewVirtualNode node = new TreeViewVirtualNode("", "全院");
                node.IsLeaf = false;
                list.Add(node);

                e.Children = list;
                return;
            }
            if (e.NodeName == "")
            {
                foreach (DataRow rw in bll.GetallHLX_Area().Rows)
                {
                    TreeViewVirtualNode node = new TreeViewVirtualNode(rw["AreaID"].ToString(), rw["AreaName"].ToString());
                    node.IsLeaf = false;
                    list.Add(node);
                }
                e.Children = list;
                return;
            }
            if (!string.IsNullOrEmpty(e.NodeName))
            {
                string NodeName = e.NodeName;
                DataTable dt = bll.GetDeptInArea(NodeName);
                if (dt != null)
                {
                    foreach (DataRow rw in dt.Rows)
                    {
                        TreeViewVirtualNode node = new TreeViewVirtualNode(rw["DeptID"].ToString(), rw["DeptName"].ToString());
                        node.IsLeaf = true;
                        list.Add(node);
                    }
                }
                    e.Children = list;
                
                return;
            }
        }

        private DevExpress.XtraReports.UI.XtraReport CreateReport()
        {
            string startDate;
            string endDate;
            if (ASPxComboBoxHalfYear.Text == "下半年")
            {
                startDate = ASPxTimeEditStart.DateTime.ToString("yyyy-7-1");
                endDate = ASPxTimeEditStart.DateTime.ToString("yyyy-12-31");
            }
            else
            {
                startDate = ASPxTimeEditStart.DateTime.ToString("yyyy-1-1");
                endDate = ASPxTimeEditStart.DateTime.ToString("yyyy-6-30");
            }

            XtraReportNSS report;
            if (ASPxDropDownEditDept.Text != "全院")
            {
                ASPxTreeView tv = ASPxDropDownEditDept.FindControl("ASPxTreeViewDept") as ASPxTreeView;
                if (tv.SelectedNode != null && (((TreeViewVirtualNode)tv.SelectedNode)).IsLeaf)
                {
                    report = new XtraReportNSS(ASPxDropDownEditDept.KeyValue.ToString(), DateTime.Parse(startDate), DateTime.Parse(endDate), true);
                }
                else
                {
                    report = new XtraReportNSS(ASPxDropDownEditDept.KeyValue.ToString(), DateTime.Parse(startDate), DateTime.Parse(endDate), false);
                }
            }
            else
            {
                report = new XtraReportNSS(DateTime.Parse(startDate), DateTime.Parse(endDate));
            }
            return report;
        }

        protected void ASPxButtonQuery_Click(object sender, EventArgs e)
        {
      
        }

    }
}