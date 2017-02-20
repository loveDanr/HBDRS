using Project.Bll;
using Project.Common;
using Project.Model;
using Project.WebUi.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.JQGL
{
    public partial class QJ_leavePage : MyBasePage
    {
        protected LoginUserInfo LoginUser = null;
        private string date;
        private string pzrId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                startDate.DateTime = System.DateTime.Now;
                endDate.DateTime = System.DateTime.Now.AddDays(1);
                ShowData();
                TotalDays();
                GetLoginUserInfo();
            }
            TotalDays();
            GetLoginUserInfo();
        }
        /// <summary>
        /// 获取登录用户信息
        /// </summary>
        private void GetLoginUserInfo()
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            DepartmentBll bll = new DepartmentBll();
            Department dept = bll.GetDepartment(loginUser.DeptId);
            txt_ApproverId.Text = loginUser.UserName;
            pzrId = loginUser.UserId;
            DeptName.Text = dept.DeptName;
        }
        private void TotalDays()
        {
            string beginTime = Convert.ToString(startDate.DateTime);
            string endTime = Convert.ToString(endDate.DateTime);
            DateTime endTime1 = DateTime.Parse(endTime);
            DateTime beginTime1 = DateTime.Parse(beginTime);
            TimeSpan time = endTime1 - beginTime1;
            int days = time.Days;
            Days_label.Text = Convert.ToString(days);
        }
        protected void ShowData()
        {
            string id = Request["UserId"];
            LoginUserInfo loginUser = new LoginUserInfo();
             UserInfoBll bll = new UserInfoBll();
             UserInfo model = bll.GetModel(id);
             if (model != null)
             {
                 txt_Username.Text = model.UserName;
                 txt_ApproverId.Text = loginUser.UserName;
             }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if(String.IsNullOrEmpty(txt_Reason.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('请填写请假原因！'); </script>");
            }
           string id = Request["UserId"];
            QJ model = new QJ();
            QjBll qjBll = new QjBll();
            date = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            model.UserID = id;
            model.QjDate = date;
            model.QjDays = Convert.ToInt32(Days_label.Text.Trim());
            model.Reason = txt_Reason.Text.Trim();
            model.ApproverId = pzrId;
            
            int n = qjBll.Insert(model, null);
            int m = qjBll.updatePersonal(model.QjDays,model.UserID);
            if (n > 0&&m>0)
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('请假成功！');frameElement.api.opener.location.reload();  </script>");

            else
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存失败！');frameElement.api.opener.location.reload(); </script>");

        }
        /// <summary>
        /// 共计请假天数
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void CountBtn_Click(object sender, EventArgs e)
        {
            TotalDays();
        }



    }
}