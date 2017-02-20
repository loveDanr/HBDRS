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
using DevExpress.Web;

namespace Project.WebUi
{
    public partial class Welcome : System.Web.UI.Page
    {
        protected LoginUserInfo LoginUser = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoginUser = CommonFun.GetCookieUserData<LoginUserInfo>(this.Page);
            LoginUserName.Text = LoginUser.UserName;
        }
    }
}
