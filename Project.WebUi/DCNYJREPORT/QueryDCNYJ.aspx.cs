using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Project.Bll;
using Project.Model;
using Project.Common;
using System.Collections.Generic;
using System.Text;
using Project.WebUi.App_Code;
using DevExpress.Web;

namespace Project.WebUi.DCNYJREPORT
{
    public partial class QueryDCNYJ : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        public string checkDept = null;         //科室名称
        public string areaID = null;              //片区ID
        public string TitleName = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDeptName();
                YearTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-1).Date;
                YearTimeEditEnd.DateTime = System.DateTime.Now;
                ASPxDropDownEditDept.Text = "全院";
                JCorDD.Text = "多重耐药菌患者检出(督导)例次数";
                GridViewOther.Visible = false;
 
            }
        }

        /// <summary>
        /// 获取当前登录人的科室名称
        /// </summary>
        private void GetDeptName()
        {
            //这三个科室的id
           
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(loginUser.DeptId);
            checkDept = dept.DeptName;
        }
        /// <summary>
        /// 获取比率
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private void GetRate(int a,int b)
        {
            float r = (float)b / (float)a * 100;
            per_txt.Text = Convert.ToString(r.ToString("#0.00")).Trim()+"%";
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
        /// <summary>
        /// 点击查询
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void submit_Click(object sender, EventArgs e)
        {
            DCNYJBll bll = new DCNYJBll();
            string areaID = string.Empty;
            if (ASPxDropDownEditDept.Enabled)
            {
                if (ASPxDropDownEditDept.KeyValue == null || ASPxDropDownEditDept.KeyValue.ToString() == "")
                {
                    checkDept = string.Empty;
                    areaID = string.Empty;
                }
                else
                {
                    ASPxTreeView atv = (DevExpress.Web.ASPxTreeView)ASPxDropDownEditDept.FindControl("ASPxTreeViewDept");
                    //方法二：
                    TreeViewVirtualNode selectedNode = ((TreeViewVirtualNode)atv.SelectedNode);
                    //因为VirutalMode,node的children没有加载,故SelectedNode.Nodes.Count一直为零，
                    //方法一： atv.SelectedNode.Parent.Name != string.Empty
                    if (selectedNode.IsLeaf)
                    {
                        checkDept = ASPxDropDownEditDept.KeyValue.ToString();
                        areaID = string.Empty;
                    }
                    else
                    {
                        checkDept = string.Empty;
                        areaID = ASPxDropDownEditDept.KeyValue.ToString();
                    }
                }
            }
            if (checkDept == "2" || checkDept == "333" || checkDept == "233")
            {
                JCorDD.Text = "多重耐药菌患者督导例次数";
            }
            else
            {
                JCorDD.Text = "多重耐药菌患者检出例次数";
            }

            //每个textbox获取数据库里相应字段的数值
            string startDate = YearTimeEditStart.DateTime.ToString("yyyy-MM");
            string endDate = YearTimeEditEnd.DateTime.ToString("yyyy-MM");
            DateTime time2 = DateTime.Parse(endDate);
            DateTime time1 = DateTime.Parse(startDate);
            int totalMonth = time2.Year * 12 + time2.Month - time1.Year * 12 - time1.Month;
            if (totalMonth < 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('结束时间不得小于开始时间！'); </script>");
                return;
            }
            else if (totalMonth > 0)
            {
                GridViewOther.DataBind();
                DCNYJ model = bll.GetReportInfo(startDate, endDate, checkDept, areaID);
                if (model != null)
                {
                    hzjcls_txt.Text = model.Hzzjcls.ToString();
                    yxzxls_txt.Text = model.Yxzxls.ToString();
                    wgl_txt.Text = model.Wgl.ToString();
                    xdj_txt.Text = model.Xdj.ToString();
                    sws_txt.Text = model.Sws.ToString();
                    wjcz_txt.Text = model.Wjcz.ToString();
                    tzq_txt.Text = model.Tzq.ToString();
                    xdbdw_txt.Text = model.Xdbdw.ToString();
                    ylfw_txt.Text = model.Ylfw.ToString();
                    fhcs_txt.Text = model.Fhcs.ToString();
                    bzx_txt.Text = model.Bzx.ToString();
                    other_txt.Text = "请查看下方表格";
                    GetRate(model.Hzzjcls,model.Yxzxls);
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('没有数据！'); </script>");
                    hzjcls_txt.Text = "";
                    yxzxls_txt.Text = "";
                    wgl_txt.Text = "";
                    xdj_txt.Text = "";
                    sws_txt.Text = "";
                    wjcz_txt.Text = "";
                    tzq_txt.Text = "";
                    xdbdw_txt.Text ="";
                    ylfw_txt.Text = "";
                    fhcs_txt.Text = "";
                    bzx_txt.Text = "";
                    other_txt.Text = "";
                    per_txt.Text = "";
                    GridViewOther.Visible = false;
                    return;
                }
                
            }
            else if (totalMonth == 0)
            {
                
                DCNYJ model = bll.GetReportInfo(startDate, endDate, checkDept, areaID);
                hzjcls_txt.Text = model.Hzzjcls.ToString();
                yxzxls_txt.Text = model.Yxzxls.ToString();
                wgl_txt.Text = model.Wgl.ToString();
                xdj_txt.Text = model.Xdj.ToString();
                sws_txt.Text = model.Sws.ToString();
                wjcz_txt.Text = model.Wjcz.ToString();
                tzq_txt.Text = model.Tzq.ToString();
                xdbdw_txt.Text = model.Xdbdw.ToString();
                ylfw_txt.Text = model.Ylfw.ToString();
                fhcs_txt.Text = model.Fhcs.ToString();
                bzx_txt.Text = model.Bzx.ToString();
                GetRate(model.Hzzjcls, model.Yxzxls);
                if (startDate == endDate&&!String.IsNullOrEmpty(areaID))
                {
                    other_txt.Text = "请看下方表格";
                    GridViewOther.DataBind();
                }
                else if (startDate == endDate && !String.IsNullOrEmpty(checkDept))
                {
                    other_txt.Text = model.Other.ToString();
                    GridViewOther.Visible = false;
                }
                else if (startDate == endDate && String.IsNullOrEmpty(areaID) && String.IsNullOrEmpty(checkDept))
                {
                    other_txt.Text = "请看下方表格";
                    GridViewOther.DataBind();
                }
            }

        }


        /// <summary>
        ///绑定数据源
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridViewOther_DataBinding(object sender, EventArgs e)
        {
            DCNYJBll bll = new DCNYJBll();
            string startDate = YearTimeEditStart.DateTime.ToString("yyyy-MM");
            string endDate = YearTimeEditEnd.DateTime.ToString("yyyy-MM");
            DateTime time2 = DateTime.Parse(endDate);
            DateTime time1 = DateTime.Parse(startDate);
            int totalMonth = time2.Year * 12 + time2.Month - time1.Year * 12 - time1.Month;
            if (totalMonth >= 0)
            {
                GridViewOther.Visible = true; string areaID = string.Empty;
                if (ASPxDropDownEditDept.Enabled)
                {
                    if (ASPxDropDownEditDept.KeyValue == null || ASPxDropDownEditDept.KeyValue.ToString() == "")
                    {
                        checkDept = string.Empty;
                        areaID = string.Empty;
                    }
                    else
                    {
                        ASPxTreeView atv = (DevExpress.Web.ASPxTreeView)ASPxDropDownEditDept.FindControl("ASPxTreeViewDept");
                        //方法二：
                        TreeViewVirtualNode selectedNode = ((TreeViewVirtualNode)atv.SelectedNode);
                        //因为VirutalMode,node的children没有加载,故SelectedNode.Nodes.Count一直为零，
                        //方法一： atv.SelectedNode.Parent.Name != string.Empty
                        if (selectedNode.IsLeaf)
                        {
                            checkDept = ASPxDropDownEditDept.KeyValue.ToString();
                            areaID = string.Empty;
                        }
                        else
                        {
                            checkDept = string.Empty;
                            areaID = ASPxDropDownEditDept.KeyValue.ToString();
                        }
                    }
                }
                DataSet ds = bll.QueryOther(startDate, endDate, checkDept, areaID);
                GridViewOther.DataSource = ds.Tables[0].DefaultView;
                GridViewOther.DataKeyNames = new string[] { "id" };//主键
            }

        }
        /// <summary>
        /// Gridview获取科室名称
        /// </summary>
        /// <param name="deptId"></param>
        /// <returns></returns>
        private string GridViewDeptName(string deptId)
        {
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(deptId);
            string deptName = dept.DeptName;
            return deptName;
        }
        /// <summary>
        /// Gridview科室id那一列显示为科室名称
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridViewOther_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //如果是绑定数据行 
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //鼠标经过时，行背景色变 
                e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#E6F5FA'");
                //鼠标移出时，行背景色变 
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#FFFFFF'");

            }
            if (e.Row.RowIndex >= 0)
            {
                e.Row.Cells[1].Text = GridViewDeptName(e.Row.Cells[1].Text.Trim());
            }
        }
    }
}