using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class KYYLQX : MyBasePage
    {
        
        //
        protected void Page_Load(object sender, EventArgs e)
        {
            
            dateBGRQ.Date = System.DateTime.Now.Date;
            txtBGRQM.Text = loginUser.UserName;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            resMessage.Text = string.Empty;
            try
            {
                if(Request.QueryString["ID"]!= null)
                {
                    SqlDataSource1.Update();
                    resMessage.Text = "保存成功！";
                }
                else
                {
                    SqlDataSource1.Insert();
                    DevExpress.Web.ASPxEdit.ClearEditorsInContainer(ASPxFormLayout1);
                    resMessage.Text = "保存成功！";
                }
                
            }
            catch (Exception ex)
            {
                resMessage.Text = ex.Message;
            }
            
          
        }

        protected void SqlDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            string rs = string.Empty;
            int sx = rblSJBGZT.SelectedValues.Count;
            for (int i = 0; i < sx; i++)
            {
                rs += rblSJBGZT.SelectedValues[i] + ";";
            }
            e.Command.Parameters["@eBGZT"].Value = rs;
            e.Command.Parameters["@rBGKS"].Value = loginUser.DeptId;

        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@ID"].Value = Request.QueryString["ID"];
        }


        protected void ASPxFormLayout1_LayoutItemDataBound(object sender, DevExpress.Web.LayoutItemDataBoundEventArgs e)
        {
            if (e.LayoutItem.FieldName == "eBGZT")
            {
                string[] cblres = e.NestedControlValue.ToString().Split(';');
                for (int i = 0; i < cblres.Length - 1; i++)
                {
                    rblSJBGZT.Items.FindByValue(cblres[i]).Selected = true;
                }
            }
        }

        protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@ID"].Value = Request.QueryString["ID"];
            string rs = string.Empty;
            int sx = rblSJBGZT.SelectedValues.Count;
            for (int i = 0; i < sx; i++)
            {
                rs += rblSJBGZT.SelectedValues[i] + ";";
            }
            e.Command.Parameters["@eBGZT"].Value = rs;
        }

    }
}