using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;


namespace Project.WebUi.GRKHJJC
{
    public partial class TXSTXY : Project.WebUi.App_Code.MyBasePage
    {
        //private UserCache loginUser = new UserCache("hjwsx");
        private static string roleID = "7";
        //private UserCache loginUser = new UserCache("007026");
        //
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-2);
                ASPxTimeEditEnd.DateTime = System.DateTime.Now.AddDays(1);
               
                //ASPxGridViewMaster.SettingsDetail.ShowDetailRow = false;
                if (loginUser.RoleId.IndexOf(roleID)>-1)
                {
                    ASPxGridViewMaster.SettingsDataSecurity.AllowDelete = true;
                    ((GridViewDataHyperLinkColumn)ASPxGridViewMaster.Columns["ReportID"]).Visible = true;
                    ((GridViewDataComboBoxColumn)ASPxGridViewMaster.Columns["Reportor"]).EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.True;
                    ((GridViewDataDateColumn)ASPxGridViewMaster.Columns["ReportDate"]).EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.True;
                    ((GridViewDataComboBoxColumn)ASPxGridViewMaster.Columns["Checkor"]).EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.True;
                    ASPxGridViewMaster.ClientSideEvents.RowDblClick = " grid_RowDblClick";
                }
                else
                {
                    ASPxGridViewMaster.SettingsDataSecurity.AllowDelete = false;
                    ((GridViewDataHyperLinkColumn)ASPxGridViewMaster.Columns["ReportID"]).Visible = false;
                    ((GridViewDataComboBoxColumn)ASPxGridViewMaster.Columns["Reportor"]).EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.False;
                    ((GridViewDataDateColumn)ASPxGridViewMaster.Columns["ReportDate"]).EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.False;
                    ((GridViewDataComboBoxColumn)ASPxGridViewMaster.Columns["Checkor"]).EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.False;

                }


            }
        }
        protected void ASPxGridViewDetails_BeforePerformDataSelect(object sender, EventArgs e)
        {
            String para = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
            SqlDataSourceItem.SelectParameters["ReportID"].DefaultValue = para;
        }

        protected void ASPxGridViewDetails_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            String para = (sender as ASPxGridView).GetMasterRowKeyValue().ToString();
            SqlDataSourceItem.InsertParameters["ReportID"].DefaultValue = para;
        }


        protected void ASPxGridViewDetails_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {
            string fieldName = e.DataColumn.FieldName;
            if (fieldName == "ItemGrade")
            {
                e.Cell.Text = e.CellValue.ToString();
            }
        }

        protected void ASPxButtonQuery_Click(object sender, EventArgs e)
        {

        }

        protected void ASPxGridViewMaster_HeaderFilterFillItems(object sender, ASPxGridViewHeaderFilterEventArgs e)
        {
            e.Values.RemoveAt(2);e.Values.RemoveAt(1); //(Blanks)-(Non blanks)
            foreach (FilterValue item in e.Values)
            {
                if (item.DisplayText == "(All)")
                {
                    item.DisplayText = "(全部)";
                }
            }
        }

        protected void ASPxGridViewMaster_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {

            if (loginUser.RoleId.IndexOf(roleID)<0)
            {
                ASPxGridView grid = sender as ASPxGridView;
                if (!grid.IsNewRowEditing)
                {
                    object rep = grid.GetRowValuesByKeyValue(e.EditingKeyValue, "Reportor");
                    if (rep != null && rep.ToString() != "")
                    {
                        grid.JSProperties["cpEditEnabled"] = false;
                        e.Cancel = true;
                    }
                    else
                    {
                        grid.JSProperties["cpEditEnabled"] = true;
                    }
                }
                else
                {
                    grid.JSProperties["cpEditEnabled"] = true;
                }
            }
        }

        protected void ASPxGridViewDetails_Load(object sender, EventArgs e)
        {
            ASPxGridView detailGrid = sender as ASPxGridView;

            if (loginUser.RoleId.IndexOf(roleID)>-1)
            {
                //detailGrid.SettingsDataSecurity.AllowDelete = true;
                //detailGrid.SettingsDataSecurity.AllowEdit = true;
                detailGrid.SettingsDataSecurity.AllowInsert = true;
                detailGrid.Columns[0].Visible = true;
            }
            else
            {
                //detailGrid.SettingsDataSecurity.AllowDelete = false;
                //detailGrid.SettingsDataSecurity.AllowEdit = false;
                detailGrid.SettingsDataSecurity.AllowInsert = false;
                detailGrid.Columns[0].Visible = false;
            }
        }

        protected void ASPxGridViewMaster_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != GridViewRowType.Data) return;
            SqlDataSourceItem.SelectParameters["ReportID"].DefaultValue = e.KeyValue.ToString();
            System.Collections.IEnumerator et = SqlDataSourceItem.Select(DataSourceSelectArguments.Empty).GetEnumerator();
            while (et.MoveNext())
            {
                if (((System.Data.DataRowView)(et.Current)).Row["stateFlag"].Equals(true))
                {
                    e.Row.ForeColor = System.Drawing.Color.DarkRed;
                    return;
                }
            }

        }
    }
}