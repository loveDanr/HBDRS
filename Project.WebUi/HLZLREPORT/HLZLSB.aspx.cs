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

namespace Project.WebUi.HLZLREPORT
{
    public partial class HLZLSB : MyBasePage
    {
        private string date;
        protected LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                sbsj.Text = DateTime.Now.ToString("yyyy年MM月dd日");
                ASPxRYear.Text = DateTime.Now.Year.ToString();
                sbReason.Text = ((DateTime.Now.Month - 1) / 3 + 1).ToString();
                GetDeptName();
            }
        }

        private void GetDeptName()
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(loginUser.DeptId);
            sbks.Text = dept.DeptName;
        }
        /// <summary>
        /// 保存
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void submit_Click(object sender, EventArgs e)
        {
            int  season = Convert.ToInt32(sbReason.Text);
            date = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            HLZL model = new HLZL();
            HLZLBll bll = new HLZLBll();
            model.report_date = date;
            model.report_dept = loginUser.DeptId;
            model.bb_zrhs = Convert.ToDecimal(this.TextBox10.Text.Trim());
            model.yb_zrhs = Convert.ToDecimal(this.TextBox11.Text.Trim());
            model.bb_szhz = Convert.ToDecimal(this.TextBox12.Text.Trim());
            model.yb_szhz = Convert.ToDecimal(this.TextBox13.Text.Trim());
            model.zg_work_time = Convert.ToDecimal(this.TextBox14.Text.Trim());
            model.wcg_days = Convert.ToDecimal(this.TextBox15.Text.Trim());
            model.zy_stys = Convert.ToDecimal(this.TextBox16.Text.Trim());
            model.yc_gwhz = Convert.ToDecimal(this.TextBox17.Text.Trim());
            model.zc_ddhz = Convert.ToDecimal(this.TextBox18.Text.Trim());
            model.report_year = ASPxRYear.Text;
            model.report_season = season;
            
            int n;
            if (model!=null)
            {
                n = bll.CheckExist(model,null);
                if (n > 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('本季度已填报！');</script>");
                }
                else
                {
                    n = bll.Insert(model, null);
                    if (n > 0)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存成功！');</script>");
                        return;
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存失败！');</script>");
                        return;
                    }
                }
 

            }
        }

    }
}