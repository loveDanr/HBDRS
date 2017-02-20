using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using DevExpress.Web;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using System.Data;


namespace Project.WebUi.GRKHJJC
{
    public partial class TXSTXYbgsh : Project.WebUi.App_Code.MyBasePage
    {
        private static readonly SqlDatabase db = EnterpriseLibraryContainer.Current.GetInstance<SqlDatabase>("SQLConnString");
        private DbConnection oneConn = null;
        private DbTransaction oneTrans = null;
        private int reportID = -1;
        private List<DbCommand> listDbCMDs = new List<DbCommand>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Int32.TryParse(Request.QueryString["id"], out reportID);
            if (!IsPostBack)
            {
                SetUPControls();
            }
        }
        private void SetUPControls()
        {
            DataTable dt;
            using (DbConnection dbc = db.CreateConnection())
            {
                dt = db.ExecuteDataSet(CommandType.Text, "SELECT [ReportID], [DeptID], [Grade],[PreparationPeriod],  [LabSample], [LabObject], [Transportor], [TransportDate], [Reportor], [ReportDate], [Checkor] FROM [GRK_JYBG] WHERE ReportID = '" + reportID + "'").Tables[0];
            }
            if (dt != null && dt.Rows.Count > 0)
            {
                ASPxComboBoxDept.Value = dt.Rows[0]["DeptID"];
                ASPxComboBoxGrade.Value = dt.Rows[0]["Grade"];
                ASPxTextBoxPreparationPeriod.Value = dt.Rows[0]["PreparationPeriod"];
                ASPxTextBoxLabSample.Value = dt.Rows[0]["LabSample"];
                ASPxComboBoxT.Value = dt.Rows[0]["Transportor"];
                ASPxDateEditT.Value = dt.Rows[0]["TransportDate"];
                ASPxComboBoxR.Value = dt.Rows[0]["Reportor"];
                ASPxDateEditR.Value = dt.Rows[0]["ReportDate"];
                ASPxComboBoxC.Value = dt.Rows[0]["Checkor"];
            }
        }

        private void ReplaceNullWithDBNull(DbParameterCollection paras)
        {
            foreach (DbParameter ipara in paras)
            {
                if (ipara.Value == null)
                    ipara.Value = System.DBNull.Value;
            }
        }

        protected void SqlDataSourceItem_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Cancel = true;
            e.Command.Connection = oneConn;
            e.Command.Parameters["@ReportID"].Value = reportID;
            double res = Convert.ToDouble(e.Command.Parameters["@MonitorRes"].Value);
            double min = Convert.ToDouble(e.Command.Parameters["@RefMin"].Value);
            double max = Convert.ToDouble(e.Command.Parameters["@RefMax"].Value);
            if (res > max || res < min)
            {
                e.Command.Parameters["@stateFlag"].Value = true;
            }
            else
            {
                e.Command.Parameters["@stateFlag"].Value = false;
            }
            ReplaceNullWithDBNull(e.Command.Parameters);
            listDbCMDs.Add(e.Command);



        }


        protected void cp_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            //保存成功标志
            bool resflag = false;

            string updateReport = @"UPDATE GRK_JYBG SET DeptID =@DeptID, Grade =@Grade,PreparationPeriod =@PreparationPeriod, LabSample =@LabSample, 
Transportor =@Transportor, TransportDate =@TransportDate, Reportor =@Reportor, 
ReportDate =@ReportDate, Checkor =@Checkor WHERE ReportID = @ReportID";
            DbCommand dbEventcmd = db.GetSqlStringCommand(updateReport);
            db.AddInParameter(dbEventcmd, "DeptID", DbType.String, ASPxComboBoxDept.Value);
            db.AddInParameter(dbEventcmd, "Grade", DbType.String, ASPxComboBoxGrade.Value);
            db.AddInParameter(dbEventcmd, "PreparationPeriod", DbType.String, ASPxTextBoxPreparationPeriod.Value);
            db.AddInParameter(dbEventcmd, "LabSample", DbType.String, ASPxTextBoxLabSample.Value);
            db.AddInParameter(dbEventcmd, "Transportor", DbType.String, ASPxComboBoxT.Value);
            db.AddInParameter(dbEventcmd, "TransportDate", DbType.String, ASPxDateEditT.Value);
            db.AddInParameter(dbEventcmd, "Reportor", DbType.String, ASPxComboBoxR.Value);
            db.AddInParameter(dbEventcmd, "ReportDate", DbType.String, ASPxDateEditR.Value);
            db.AddInParameter(dbEventcmd, "Checkor", DbType.String, ASPxComboBoxC.Value);
            db.AddInParameter(dbEventcmd, "ReportID", DbType.String, reportID);


            using (oneConn = db.CreateConnection())
            {
                oneConn.Open();
                oneTrans = oneConn.BeginTransaction();
                try
                {
                    db.ExecuteScalar(dbEventcmd, oneTrans);


                    //dbPatientcmd.Parameters["@baseEventID"].Value = bEventID;
                    //db.ExecuteNonQuery(dbPatientcmd, oneTrans);
                    //dbReportorcmd.Parameters["@baseEventID"].Value = bEventID;
                    //db.ExecuteNonQuery(dbReportorcmd, oneTrans);

                    ASPxGridViewDetails.UpdateEdit();

                    foreach (DbCommand icmd in listDbCMDs)
                    {
                        db.ExecuteNonQuery(icmd, oneTrans);
                    }

                    //
                    oneTrans.Commit();
                    //oneTrans.Rollback();
                    resflag = true;

                }
                catch
                {
                    oneTrans.Rollback();
                    resflag = false;
                }

                oneConn.Close();
            }

            if (resflag)
            {
                cp.JSProperties["cpSaveFlag"] = true;
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "saveFlag", "<script language='javascript'>alert('保存成功！');</script>");
                //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "alert", " alert('提交成功！')", true);

            }
            else
            {
                cp.JSProperties["cpSaveFlag"] = false;
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "saveFlag", "<script language='javascript'>alert('保存失败，请重新保存！');</script>");
                //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "alert", " alert('提交失败，请重新提交！')", true);
            }
        }

        protected void ASPxGridViewDetails_BeforePerformDataSelect(object sender, EventArgs e)
        {
            SqlDataSourceItem.SelectParameters["ReportID"].DefaultValue = reportID.ToString();
        }

        protected void SqlDataSourceItem_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Cancel = true;
            e.Command.Connection = oneConn;
            double res = Convert.ToDouble(e.Command.Parameters["@MonitorRes"].Value);
            double min = Convert.ToDouble(e.Command.Parameters["@RefMin"].Value);
            double max = Convert.ToDouble(e.Command.Parameters["@RefMax"].Value);
            if (res > max || res < min)
            {
                e.Command.Parameters["@stateFlag"].Value = true;
            }
            else
            {
                e.Command.Parameters["@stateFlag"].Value = false;
            }
            ReplaceNullWithDBNull(e.Command.Parameters);
            listDbCMDs.Add(e.Command);
        }

        protected void SqlDataSourceItem_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Cancel = true;
            e.Command.Connection = oneConn;
            ReplaceNullWithDBNull(e.Command.Parameters);
            listDbCMDs.Add(e.Command);
        }


    }
}