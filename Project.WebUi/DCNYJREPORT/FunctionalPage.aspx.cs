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

namespace Project.WebUi.DCNYJREPORT
{
    public partial class FunctionalPage : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DC_AspxYear.DateTime = System.DateTime.Now;
                GetDeptName();
            }
        }

        private void GetDeptName()
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(loginUser.DeptId);
            DCsbks.Text = dept.DeptName;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DCNYJ model = new DCNYJ();
            DCNYJBll bll = new DCNYJBll();
            model.Report_date = DC_AspxYear.DateTime.ToString("yyyy-MM-dd hh:mm:ss");
            model.Report_dept = loginUser.DeptId;
            model.Hzzjcls = Convert.ToInt32(hzjcls_txt.Text.Trim());
            model.Yxzxls = Convert.ToInt32(yxzxls_txt.Text.Trim());
            model.Wgl = Convert.ToInt32(wgl_txt.Text.Trim());
            model.Xdj = Convert.ToInt32(xdj_txt.Text.Trim());
            model.Sws = Convert.ToInt32(sws_txt.Text.Trim());
            model.Wjcz = Convert.ToInt32(wjcz_txt.Text.Trim());
            model.Tzq = Convert.ToInt32(tzq_txt.Text.Trim());
            model.Xdbdw = Convert.ToInt32(xdbdw_txt.Text.Trim());
            model.Ylfw = Convert.ToInt32(ylfw_txt.Text.Trim());
            model.Fhcs = Convert.ToInt32(fhcs_txt.Text.Trim());
            model.Bzx = Convert.ToInt32(bzx_txt.Text.Trim());
            model.Other = other_txt.Text.Trim();

            int n;
            if (model != null)
            {
                n = bll.CheckExist(model, null);
                if (n > 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('本月已填报！');</script>");
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