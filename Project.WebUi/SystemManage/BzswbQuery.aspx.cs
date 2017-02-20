using Project.Common;
using Project.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.SystemManage
{
    public partial class BzswbQuery : System.Web.UI.Page
    {
        Bll.BzswbBll bw = new Bll.BzswbBll();

        LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void GetLoginUserInfo()
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(text10.Value))
            {
                Response.Write("<script>alert('请选择开始日期！');location.replace('BzswbQuery.aspx')</script>");
                return;

            }
            if (string.IsNullOrEmpty(text1.Value))
            {
                Response.Write("<script>alert('请选择结束日期！');location.replace('BzswbQuery.aspx')</script>");
                return;
            }
            GetLoginUserInfo();
            string begin = text10.Value.Trim();
            string end = text1.Value.Trim();
            string ks = LoginUser.DeptId;
            DataSet ds = bw.queryTime(begin,end,ks);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Write("<script>window.location.href='../SystemManage/BzswbIndex.aspx'</script>");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Write("<script>window.location.href='../SystemManage/BzswbPrint.aspx'</script>");
        }
    }
}