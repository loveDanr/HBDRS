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




namespace Project.WebUi.SystemManage
{
    public partial class DList : MyBasePage
    {
        DepartmentBll bll = new DepartmentBll();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                BindRpt();
            }
        }
        protected void BindRpt()
        {
            DepartmentBll Dbll = new DepartmentBll();
            List<Department> list = Dbll.getTopList();
            if (list != null)
            {
                this.rptList.DataSource = Dbll.getOrderList(list);
               
                this.rptList.DataBind();
            }
        }

        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "del")//如果是删除命令
            {

                
                string id = e.CommandArgument.ToString();

                DepartmentBll Dbll = new DepartmentBll();
                if (Dbll.DelDepartment(id, null) > 0)
                {
                    Response.Write("<script>alert('删除成功！');window.location.href='DList.aspx'</script>");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('删除失败！');</script>");
                }
            }
        }

        protected string GetDeptName(string deptID)
        {
            return bll.GetDepartment(deptID).DeptName;
        }

    }
}