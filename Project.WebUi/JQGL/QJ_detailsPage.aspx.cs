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

namespace Project.WebUi.JQGL
{
    public partial class QJ_detailsPage : MyBasePage
    {
        protected string pagetext = "";//分页html代码
        protected LoginUserInfo LoginUser = null;
        private string deptId = null;
        private string UserID = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                SetSql();
                BindRpt();
            }
       
           
        }


        //绑定列表数据
        protected void BindRpt()
        {

            int totalRecord = 0;//总记录条数
            int pageIndex = Request["pageindex"] == null ? 1 : Convert.ToInt32(Request["pageindex"]);//当前页码
            int pageSize = 10;//每页条数
            string parms = "";//传递给下一页的条件
            string sql = GetSql(out parms);//传递给SQL的查询条件
            QjBll bll = new QjBll();
            DataTable list = bll.GetList(pageIndex, pageSize, sql, out totalRecord);
            PagingHelper pa = new PagingHelper(pageIndex, pageSize, totalRecord, "QJ_detailsPage.aspx", parms, 10);
            pagetext = pa.CreatePageHtml();//生成分页html
            if (list != null)
            {
                this.rptList.DataSource = list;
                this.rptList.DataBind();
            }
        }
        /// <summary>
        /// 根据id获取用户名
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        protected string GetUserName(string userid)
        {
            if (!string.IsNullOrEmpty(userid))
            {
                UserInfoBll Userbll = new UserInfoBll();
                UserInfo model = Userbll.GetModel(userid);
                TitleName.Text = model.UserName;
            }
            return TitleName.Text;

        }

        //获取查询条件
        protected string GetSql(out string parms)
        {
            StringBuilder sql = new StringBuilder();//传递给SQL的查询条件
            StringBuilder url = new StringBuilder();//传递给下一页的条件
            if (!string.IsNullOrEmpty(UserID))
            {
                sql.AppendFormat("and UserId like '%{0}%' ", UserID);
                url.Append("&t1.UserId=" + UserID);
            }
            
            parms = url.ToString();
            return sql.ToString();
        }

        //设置查询条件
        protected void SetSql()
        {
            string id = Request["UserId"];
            if (!String.IsNullOrEmpty(id))
            {
                Session["UserId"] = id;
              
            }
                UserID = Session["UserId"].ToString();
        }

        /// <summary>
        /// 获取请假详细信息
        /// </summary>
        private void GetAllInfo()
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            QjBll bll = new QjBll();

            string userid = Request["UserId"];
            
            if (!string.IsNullOrEmpty(userid))
            {
                UserInfoBll Userbll = new UserInfoBll();
                UserInfo model = Userbll.GetModel(userid);
                TitleName.Text = model.UserName;
                rptList.DataSource = bll.GetDetailsById(userid);
                DataBind();
            }
        }
        /// <summary>
        /// 获取审批人姓名
        /// </summary>
        protected string  GetApproverName(string ApproverId)
        { 
            UserInfoBll bll = new UserInfoBll();
            UserInfo  model =  bll.GetModel(ApproverId);
            string ModelName = "";
            ModelName = model.UserName;
            return ModelName;
        }

        protected string ConvertDateFormat(string date)
        {
            DateTime dt = Convert.ToDateTime(date);
            string str = dt.ToString("yyyy年MM月dd日 hh:mm:ss");
            return str;
        }

     
    }
}