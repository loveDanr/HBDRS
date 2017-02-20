using Project.Common;
using Project.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Project.Bll;


namespace Project.WebUi.SystemManage
{
    public partial class BzswbIndex : System.Web.UI.Page
    {
        Bll.BzswbBll bw = new Bll.BzswbBll();
        Bzswb bzswb = new Bzswb();
        LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            GetLoginUserInfo();
            TextKS.Value = GetDeptName(LoginUser.DeptId);
            TextJLR.Value = LoginUser.UserName;
        }
        private void GetLoginUserInfo()
        {

            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
        }

        /// <summary>
        /// 通过UserId读取科室名称
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        protected string GetDeptName(string deptId)
        {
            DepartmentBll deptBll = new DepartmentBll();
            Department dept = deptBll.GetDepartment(deptId);
            string deptName = "";
            deptName = dept.DeptName;
            return deptName;

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(text10.Value))
            {
                Response.Write("<script>alert('请选择日期！');location.replace('BzswbIndex.aspx')</script>");
                return;

            }
            if (string.IsNullOrEmpty(TextSl.Value))
            {
                Response.Write("<script>alert('请输入填报数量！');location.replace('BzswbIndex.aspx')</script>");
                return;
            }
            int n = 0;
            bzswb.Rq = text10.Value;
            bzswb.Ks = LoginUser.DeptId;
            bzswb.Sbr = LoginUser.UserId;
            bzswb.Sl = TextSl.Value;

            if (bzswb != null)
            {
                n = bw.CheckKSIDExist(bzswb, null);
                if (n > 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('该月已经申报！');</script>");

                    return;
                }
                else
                {

                    if (bw.insertBzswb(bzswb, null) > 0)
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('申报成功！');</script>");
                    else
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('申报不成功！');</script>");
                }
            }
        }

        protected void btnQuery_click(object sender, EventArgs e)
        {
            Response.Write("<script>window.location.href='../SystemManage/BzswbQuery.aspx'</script>");
        }
    }
}