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
    public partial class QJ_Index : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        private string deptId = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetDeptId();
            GetDeptInfo();
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
        /// 获取科室ID
        /// </summary>
        private void GetDeptId()
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(loginUser.DeptId);
            Name.Text = dept.DeptName;
            deptId = LoginUser.DeptId;
        }
        /// <summary>
        /// 获取全科室的信息
        /// </summary>
        private void GetDeptInfo()
        {
            QJ_TotalBll bll = new QJ_TotalBll();
            rptList.DataSource = bll.GetDeptInfo(deptId);
            DataBind();
        }

        /// <summary>
        /// 查询假期天数按钮
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            QJ_TotalBll bll = new QJ_TotalBll();
            if (!String.IsNullOrEmpty(txtUserName.Text.Trim()))
            {
                rptList.DataSource = bll.QueryStaffInfo(txtUserName.Text.Trim(), deptId);
                DataBind();
                
            }
            else
            {
                rptList.DataSource = bll.GetDeptInfo(deptId);
                DataBind();
            }
        }

        protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lb = (Label)e.Item.FindControl("lbStatus");
                int n = Convert.ToInt32(lb.Text.Trim());
                if (n < 0)
                {
                    lb.ForeColor = System.Drawing.Color.Red;
                    lb.Font.Size=15;
                }
            }
        }



        }
}