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

namespace Project.WebUi.HLBQ
{
    public partial class HLBQWH : System.Web.UI.Page
    {

        string GriviewSelectKey = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxGridView1.DataBind();
            if (ASPxGridView1.FocusedRowIndex > -1)
            {
                GriviewSelectKey = ASPxGridView1.GetRowValues(ASPxGridView1.FocusedRowIndex, new string[1] { "AreaID" }).ToString();
            }
            if (ASPxListBox1.IsCallback)
            {
                ASPxListBox1.DataBind();
            }

            if (ASPxListBox2.IsCallback)
            {
                ASPxListBox2.DataBind();
            }

        }

        protected void ASPxGridView1_DataBinding(object sender, EventArgs e)
        {
            HLBQBll bll = new HLBQBll();
            ASPxGridView1.DataSource = bll.GetallHLX_Area().Columns.Count == 0 ? null : bll.GetallHLX_Area();
        }

        protected void ASPxGridView1_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {

            string AreaName = Convert.ToString(e.NewValues["AreaName"]);
            string AreaManager = Convert.ToString(e.NewValues["AreaManager"]);
            HLBQBll bll = new HLBQBll();
            HLX_Area model = new HLX_Area();
            model.AreaManager = AreaManager;
            model.AreaName = AreaName;
            int n = -1;
            if (model != null)
            {
                n = bll.Insert(model, null);
                if (n > 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存成功！');</script>");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存失败！');</script>");

                }
            }
            e.Cancel = true;
            ASPxGridView1.CancelEdit();
            ASPxGridView1.DataBind();

        }

        protected void ASPxGridView1_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            HLBQBll bll = new HLBQBll();
            HLX_Area model = new HLX_Area();
            model.AreaID = e.Keys["AreaID"].ToString();
            bll.Delete(model);
            e.Cancel = true;
            ASPxGridView1.CancelEdit();
            ASPxGridView1.DataBind();
        }

        protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            HLBQBll bll = new HLBQBll();
            HLX_Area model = new HLX_Area();
            model.AreaID = e.Keys["AreaID"].ToString();
            model.AreaManager = e.NewValues["AreaManager"].ToString();
            model.AreaName = e.NewValues["AreaName"].ToString();
            bll.Update(model);
            e.Cancel = true;
            ASPxGridView1.CancelEdit();
            ASPxGridView1.DataBind();
        }


        protected void ASPxListBox1_DataBinding(object sender, EventArgs e)
        {
            HLBQBll bll = new HLBQBll();
            //GriviewSelectKey = Convert.ToInt32(ASPxGridView1.GetRowValues(ASPxGridView1.FocusedRowIndex, new string[1] { "AreaID" }));
            DataTable dt = bll.GetDeptInArea(GriviewSelectKey);
            ASPxListBox1.DataSource = dt;
        }

        protected void ASPxListBox2_DataBinding(object sender, EventArgs e)
        {
            HLBQBll bll = new HLBQBll();
            DataTable dt = bll.GetDeptNotInArea();
            ASPxListBox2.DataSource = dt;
        }

        protected void ASPxListBox1_Callback(object sender, CallbackEventArgsBase e)
        {
            if (string.IsNullOrEmpty(e.Parameter)) return;

            int index = -1;
            index = ASPxGridView1.FocusedRowIndex;
            DepartmentBll deptBll = new DepartmentBll();
            if (index > -1)
            {
                foreach (string itemValue in e.Parameter.Split(','))
                {
                    //GriviewSelectKey = Convert.ToInt32(ASPxGridView1.GetRowValues(ASPxGridView1.FocusedRowIndex, new string[1] { "AreaID" }));
                    deptBll.UpdatePQ(itemValue, GriviewSelectKey, null);
                }
            }
        }

        protected void ASPxListBox2_Callback(object sender, CallbackEventArgsBase e)
        {
            if (string.IsNullOrEmpty(e.Parameter)) return;

            int index = -1;
            string areaid = string.Empty;
            index = ASPxGridView1.FocusedRowIndex;
            DepartmentBll deptBll = new DepartmentBll();

            if (index > -1)
            {
                foreach (string itemValue in e.Parameter.Split(','))
                {
                    deptBll.UpdatePQ(itemValue, areaid, null);

                }
            }

        }









    }
}