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
  
namespace Project.WebUi.SystemManage
{
    public partial class PwdChange : System.Web.UI.Page
    {
        protected LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {
                GetLoginUserInfo();
        }


        private void GetLoginUserInfo()
        {
            
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
        }


        protected void btnSave_Click(object sender, EventArgs e)
         {
            string old_Pwd = CommonFun.GetMD5(oldPwd.Text.Trim());
            string new_Pwd = newPwd.Text.Trim();
            string con_Pwd = confirmPwd.Text.Trim();
            
            UserInfoBll bll = new UserInfoBll();
            UserInfo user = new UserInfo();
            if (old_Pwd != LoginUser.UserPwd)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('原密码输入错误！');</script>");
                return;
            }
            else if(new_Pwd!=con_Pwd)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('密码输入不一致，请重新输入！');</script>");
                newPwd.Text = ""; confirmPwd.Text = "";
                return;
            }
            int n = 0;
            
            user.UserId = LoginUser.UserId;
            user.UserPwd =  CommonFun.GetMD5(new_Pwd);
  

            n = bll.UpdatePwd(user, null);
            if (n > 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改成功！请使用新密码重新登录！');window.top.location.pathname=\"/UserExit.aspx\";</script>");
                //FormsAuthentication.SignOut();
                //Response.Redirect("~/UserExit.aspx");
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改失败！');</script>");
            }
        }
    }
}