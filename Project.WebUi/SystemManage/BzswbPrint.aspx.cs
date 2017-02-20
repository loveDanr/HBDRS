using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.SystemManage
{
    public partial class BzswbPrint : System.Web.UI.Page
    {
        Bll.BzswbBll bw = new Bll.BzswbBll();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataSet ds = bw.queryTime();
                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            string sj = text10.Value;

            DataSet ds = bw.queryTime(sj);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string rq = Convert.ToString(GridView1.DataKeys[e.RowIndex].Values["rq"]);
            string ks = Convert.ToString(GridView1.DataKeys[e.RowIndex].Values["ks"]);
            int n = bw.delBzswbSb(ks, rq);
            if (n > 0)
                Response.Write("<script>alert('删除成功！');window.location.href='BzswbPrint.aspx'</script>");
            else
                Response.Write("<script>alert('删除不成功！');</script>");

        }
    

    }
}