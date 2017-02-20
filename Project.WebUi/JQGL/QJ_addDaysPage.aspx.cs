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
using Project.WebUi.App_Code;

namespace Project.WebUi.JQGL
{
    public partial class QJ_addDaysPage : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUserInfo();
            }
        }
        /// <summary>
        /// 获取用户信息
        /// </summary>
        protected void GetUserInfo()
        {
            string userid = Request["UserId"];
            if (!string.IsNullOrEmpty(userid))
            {
                QJ_TotalBll QJ_total_bll = new QJ_TotalBll();
                QJ_Total Qj_model = QJ_total_bll.GetModel(userid);
                UserInfoBll Userbll = new UserInfoBll();

                UserInfo model = Userbll.GetModel(userid);
                txt_userid.Text = userid;
                txt_username.Text = model.UserName;
                txt_totalDays.Text =Convert.ToString(Qj_model.TotalDays);
                txt_restDays.Text =Convert.ToString(Qj_model.RestDays);
                Name.Text = txt_username.Text;
            }
        }

        /// <summary>
        /// 点击保存按钮增加假期天数
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            QJ_TotalBll bll = new QJ_TotalBll();
            string userid = txt_userid.Text.Trim();
            int totaldays =Convert.ToInt32(txt_totalDays.Text.Trim());
            int restdays =Convert.ToInt32(txt_restDays.Text.Trim());
            int n = bll.Update(userid,totaldays,restdays);
            if (n > 0 )
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('增加假期成功！');frameElement.api.opener.location.reload();  </script>");

            else
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存失败！请查看是否有填写错误！');frameElement.api.opener.location.reload(); </script>");

        }
 
    }
}