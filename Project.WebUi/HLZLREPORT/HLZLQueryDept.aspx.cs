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

namespace Project.WebUi.HLZLREPORT
{
    public partial class HLZLQueryDept : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        public string checkDept = null;         //科室名称
        public string check_year = null;        //年
        public int check_season;  //季度
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            check_year = YearTimeEdit.Text;
            check_season = Convert.ToInt32(sbReason.SelectedValue.Trim());
            checkDept = Convert.ToString(loginUser.DeptId);
            if (!IsPostBack)
            {
                checkDept = Convert.ToString(loginUser.DeptId);
                YearTimeEdit.Text = DateTime.Now.Year.ToString();
                check_year = DateTime.Now.Year.ToString();
                check_season = GetQuarterByDate(Convert.ToInt32(DateTime.Now.Month.ToString()));
                sbReason.Text = Convert.ToString(check_season);
                ASPxDropDownEditDept.Enabled = false;
                ASPxDropDownEditDept.Text = GetDeptName();
                GridView1.DataBind();
            }
        }
        /// <summary>
        /// 根据月份获取季度
        /// </summary>
        /// <param name="month"></param>
        /// <returns></returns>
        private int GetQuarterByDate(int month)
        {
            if (month >= 1 && month <= 3)
            {
                return 1;
            }

            if (month >= 4 && month <= 6)
            {
                return 2;
            }

            if (month >= 7 && month <= 9)
            {
                return 3;
            }

            if (month >= 10 && month <= 12)
            {
                return 4;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 获取当前登录人的科室名称
        /// </summary>
        private string GetDeptName()
        {
            string deptname;
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(loginUser.DeptId);
            deptname = dept.DeptName;
            return deptname;
        }
        /// <summary>
        /// GridView根据科室id读取科室名称
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

        protected void submit_Click(object sender, EventArgs e)
        {
            GridView1.DataBind();
        }
        private double sum_bbzrhs = 0;
        private double sum_ybzrhs = 0;
        private double sum_bbszhz = 0;
        private double sum_ybszhz = 0;
        private double sum_zg_work_time = 0;
        private double sum_wcg_days = 0;
        private double sum_zy_stys = 0;
        private double sum_yc_gwhz = 0;
        private double sum_zc_ddhz = 0;

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
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
                sum_bbzrhs += Convert.ToDouble(e.Row.Cells[3].Text);
                sum_ybzrhs += Convert.ToDouble(e.Row.Cells[4].Text);
                sum_bbszhz += Convert.ToDouble(e.Row.Cells[5].Text);
                sum_ybszhz += Convert.ToDouble(e.Row.Cells[6].Text);
                sum_zg_work_time += Convert.ToDouble(e.Row.Cells[7].Text);
                sum_wcg_days += Convert.ToDouble(e.Row.Cells[8].Text);
                sum_zy_stys += Convert.ToDouble(e.Row.Cells[9].Text);
                sum_yc_gwhz += Convert.ToDouble(e.Row.Cells[10].Text);
                sum_zc_ddhz += Convert.ToDouble(e.Row.Cells[11].Text);
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {

                e.Row.Cells[1].Text = sum_bbzrhs.ToString("F");
                e.Row.Cells[2].Text = sum_ybzrhs.ToString("F");
                e.Row.Cells[3].Text = sum_bbszhz.ToString("F");
                e.Row.Cells[4].Text = sum_ybszhz.ToString("F");
                e.Row.Cells[5].Text = sum_zg_work_time.ToString("F");
                e.Row.Cells[6].Text = sum_wcg_days.ToString("F");
                e.Row.Cells[7].Text = sum_zy_stys.ToString("F");
                e.Row.Cells[8].Text = sum_yc_gwhz.ToString("F");
                e.Row.Cells[9].Text = sum_zc_ddhz.ToString("F");

            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string value = e.Row.Cells[0].Text;
            }
        }


        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {

                TableCellCollection tcc = e.Row.Cells;
                tcc.Clear();
                e.Row.Cells.Add(new TableCell());
                e.Row.Cells[0].Attributes.Add("colspan", "3");
                e.Row.Cells[0].Text = "合计";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[1].Text = "";//
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[2].Text = "";//
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[3].Text = "";//
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[4].Text = "";//
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[5].Text = "";//
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[6].Text = "";//
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[7].Text = "";
                e.Row.Cells.Add(new TableCell());

                e.Row.Cells[8].Text = "";
                e.Row.Cells.Add(new TableCell());


                e.Row.Cells[9].Text = "</th></tr><tr>";
            }
        }

        protected void GridView1_DataBinding(object sender, EventArgs e)
        {
            HLZLBll bll = new HLZLBll();
            HLZL model = new HLZL();
            string areaID = string.Empty;
            DataSet ds = bll.GetReportInfo(check_year, Convert.ToInt32(check_season), checkDept, areaID);
            GridView1.DataSource = ds.Tables[0].DefaultView;
            GridView1.DataKeyNames = new string[] { "id" };//主键
        }
    }
}