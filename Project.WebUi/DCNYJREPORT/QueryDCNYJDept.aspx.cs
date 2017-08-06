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
    public partial class QueryDCNYJDept : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        public string checkDept = null;         //科室名称
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            checkDept = Convert.ToString(loginUser.DeptId);
            if (!IsPostBack)
            {
                checkDept = Convert.ToString(loginUser.DeptId);
                YearTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-1).Date;
                YearTimeEditEnd.DateTime = System.DateTime.Now;
                ASPxDropDownEditDept.Enabled = false;
                ASPxDropDownEditDept.Text = GetDeptName();
                GridViewOther.Visible = false;
                queryFix.Visible = false;

            }


        }
        /// <summary>
        /// 获取比率
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private void GetRate(int a, int b)
        {
            float r = (float)b / (float)a * 100;
            per_txt.Text = Convert.ToString(r.ToString("#0.00")).Trim() + "%";
        }
        /// <summary>
        /// 获取当前登录人的科室名称
        /// </summary>
        private string GetDeptName()
        { //这三个科室的id
            if (loginUser.DeptId == "472" || loginUser.DeptId == "473" || loginUser.DeptId == "497")
            {
                JCorDD.Text = "多重耐药菌患者督导例次数";
            }
            else
            {
                JCorDD.Text = "多重耐药菌患者检出例次数";
            }
            string deptname;
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(loginUser.DeptId);
            deptname = dept.DeptName;
            return deptname;

           
        }

        /// <summary>
        /// 查询按钮
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void submit_Click(object sender, EventArgs e)
        {
            
            DCNYJBll bll = new DCNYJBll();
            string areaID = string.Empty;
            string startDate = YearTimeEditStart.DateTime.ToString("yyyy-MM");
            string endDate = YearTimeEditEnd.DateTime.ToString("yyyy-MM");
            DateTime time2 = DateTime.Parse(endDate);
            DateTime time1 = DateTime.Parse(startDate);
            int totalMonth = time2.Year * 12 + time2.Month - time1.Year * 12 - time1.Month;
            if (totalMonth < 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('结束时间不得小于开始时间！'); </script>");
                queryFix.Visible = false;
                return;
            }
            else if (totalMonth > 0)
            {
                foreach (Control ctl in this.Controls)
                {
                    if (ctl is TextBox)
                    {
                        TextBox tb = ctl as TextBox;
                        tb.ReadOnly=true;
                    }
                }
                //hzjcls_txt.ReadOnly = true;
                //yxzxls_txt.ReadOnly = true;
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
                other_txt.Text = "请查看下方表格";
                GetRate(model.Hzzjcls, model.Yxzxls);
                GridViewOther.DataBind();
                queryFix.Visible = false;
            }
            else if (totalMonth == 0)
            {
                GridViewOther.Visible = false;
                queryFix.Visible = true;
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
                    other_txt.Text = model.Other.ToString();
                    GetRate(model.Hzzjcls, model.Yxzxls);
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
                    xdbdw_txt.Text = "";
                    ylfw_txt.Text = "";
                    fhcs_txt.Text = "";
                    bzx_txt.Text = "";
                    other_txt.Text = "";
                    per_txt.Text = "";
                    GridViewOther.Visible = false;
                    return;
                }
            }

        }
        /// <summary>
        /// 修改按钮
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void queryFix_Click(object sender, EventArgs e)
        {
            DCNYJBll bll = new DCNYJBll();
            string startDate = YearTimeEditStart.DateTime.ToString("yyyy-MM");
            string endDate = YearTimeEditEnd.DateTime.ToString("yyyy-MM");
            DateTime time2 = DateTime.Parse(endDate);
            DateTime time1 = DateTime.Parse(startDate);
            int totalMonth = time2.Year * 12 + time2.Month - time1.Year * 12 - time1.Month;
            if (totalMonth > 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('不得跨月修改上报数据！'); </script>");
                return;
            }
            else if (totalMonth == 0 && !String.IsNullOrEmpty(hzjcls_txt.Text.Trim()))
            {
                int n = 0;
                DCNYJ model = new DCNYJ();
                model.Report_dept = checkDept;
                model.Hzzjcls =Convert.ToInt32(hzjcls_txt.Text.Trim()) ;
                model.Yxzxls = Convert.ToInt32(yxzxls_txt.Text.Trim());
                model.Wgl = Convert.ToInt32(wgl_txt.Text.Trim());
                model.Xdj =Convert.ToInt32(xdj_txt.Text.Trim())  ;
                model.Sws= Convert.ToInt32(sws_txt.Text.Trim()) ;
                model.Wjcz = Convert.ToInt32(wjcz_txt.Text.Trim())  ;
                model.Tzq = Convert.ToInt32(tzq_txt.Text.Trim());
                model.Xdbdw=Convert.ToInt32(xdbdw_txt.Text.Trim()) ;
                model.Ylfw =Convert.ToInt32(ylfw_txt.Text.Trim());
                model.Fhcs  = Convert.ToInt32(fhcs_txt.Text.Trim()) ;
                model.Bzx = Convert.ToInt32(bzx_txt.Text.Trim());
                model.Other = other_txt.Text.Trim();
                n = bll.Update(model,startDate,endDate,null);
                if (n > 0)
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改成功！')</script>");

                else
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改失败！')</script>");

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
            string areaID = string.Empty;
            string startDate = YearTimeEditStart.DateTime.ToString("yyyy-MM");
            string endDate = YearTimeEditEnd.DateTime.ToString("yyyy-MM");
            DateTime time2 = DateTime.Parse(endDate);
            DateTime time1 = DateTime.Parse(startDate);
            int totalMonth = time2.Year * 12 + time2.Month - time1.Year * 12 - time1.Month;
            if (totalMonth > 0)
            {
                GridViewOther.Visible = true;
                DataSet ds = bll.QueryOther(startDate,endDate,checkDept,areaID);
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