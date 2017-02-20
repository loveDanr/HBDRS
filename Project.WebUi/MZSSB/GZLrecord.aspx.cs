using Project.Bll;
using Project.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.MZSSB
{
    public partial class GZLrecord : WebUi.App_Code.MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void save_Click(object sender, EventArgs e)
        {
            WorkLoadBll bll = new WorkLoadBll();
            WorkLoad model = new WorkLoad();
            model.OperateUser = loginUser.UserId;
            model.GzlDate = System.DateTime.Now.ToString("yyyy-MM-dd") ;
            model.GzlLoad = txtWorkLoad.Text;
            model.OperateDate = System.DateTime.Now.ToString();
            int n = bll.Insert(model);
            if(n>0)
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('保存成功！');</script>");
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('保存失败！');</script>");
            }
        }
    }
}