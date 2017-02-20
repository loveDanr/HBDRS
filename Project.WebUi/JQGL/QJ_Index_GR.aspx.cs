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
using System;

namespace Project.WebUi.JQGL
{
    public partial class QJ_Index_GR : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetPageInfo();
        }

        /// <summary>
        /// 根据用户id获取用户名称
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        protected string GetUserName(string id)
        {
            UserInfoBll bll = new UserInfoBll();
            UserInfo model = bll.GetModel(id);
            string ModelName = "";
            ModelName = model.UserName;
            return ModelName;
        }
        /// <summary>
        /// 绑定数据源，打开页面就显示自己的假期情况
        /// </summary>
        /// <param name="userid"></param>
        private void GetPageInfo()
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            string ID = LoginUser.UserId;
            string deptid = LoginUser.DeptId;
            Name.Text = LoginUser.UserName;
            QJ_TotalBll bll = new QJ_TotalBll();
            rptList.DataSource = bll.QueryStaffInfoByID(ID,deptid);
            DataBind();
        }
		/// <summary>
        /// 设置一个label，如果假期天数超标就显示红色并且字体变大
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
        protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lb = (Label)e.Item.FindControl("lbStatus");
                int n = Convert.ToInt32(lb.Text.Trim());
                if (n < 0)
                {
                    lb.ForeColor = System.Drawing.Color.Red;
                    lb.Font.Size = 15;
                }
            }
        }

    }
}