using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class EditYLFS : MyBasePage
    {
        private static readonly SqlDatabase db = EnterpriseLibraryContainer.Current.GetInstance<SqlDatabase>("SQLConnString");
        private DbConnection oneConn = null;
        private DbTransaction oneTrans = null;
        private object bEventID = null;
        private List<DbCommand> listDbCMDs = new List<DbCommand>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bEventID = Request.QueryString["baseEventID"];
                InitFromSql();
            }
        }
        private void InitFromSql()
        {
            string selectSql = "BEGIN" +
                " SELECT [eOccurTime],[eOccurDept],[eOccurSite],[eventCategory],[eventGrade],[eventDetails],[measures],[reportTime] FROM AE_ShareEventInfo WHERE recordState=1 AND  baseEventID = @baseEventID;" +
                " SELECT [hospitalID],[patientName],[patientSex],[patientAge],[jobTitle],[clinicalDiagonse] FROM AE_PatientInfo WHERE  baseEventID = @baseEventID;" +
                " SELECT [rPersonCategory],[rPostCategory],[rWorkYears],[rClinicalDept],[rTechCategory] FROM AE_ReportorInfo WHERE  baseEventID = @baseEventID;" +
                " END;";

            DbCommand queryEventcmd = db.GetSqlStringCommand(selectSql);
            db.AddInParameter(queryEventcmd, "baseEventID", DbType.String, bEventID);
            DataRow dr = db.ExecuteDataSet(queryEventcmd).Tables[0].Rows[0];
            if (dr != null)
            {
                ASPxTimeEditReport.Value = dr["reportTime"];
                ASPxTimeEditOccur.Value = dr["eOccurTime"];
                ASPxComboBoxPDept.Value = dr["eOccurDept"];
                ASPxComboBoxSite.Value = dr["eOccurSite"];
                ASPxComboBoxEType.Value = dr["eventCategory"];
                ASPxMemoDetails.Value = dr["eventDetails"];
                ASPxMemoMeasures.Value = dr["measures"];
                ASPxRadioButtonList1.Value = dr["eventGrade"];

            }
            dr = db.ExecuteDataSet(queryEventcmd).Tables[1].Rows[0];
            if (dr != null)
            {
                ASPxTextBoxHID.Value = dr["hospitalID"];
                ASPxTextBoxPName.Value = dr["patientName"];
                ASPxComboBoxSex.Value = dr["patientSex"];
                ASPxTextBoxAge.Value = dr["patientAge"];
                ASPxTextBoxJob.Value = dr["jobTitle"];
                ASPxTextBoxCDia.Value = dr["clinicalDiagonse"];
            }
            dr = db.ExecuteDataSet(queryEventcmd).Tables[2].Rows[0];
            if (dr != null)
            {
                ASPxComboBoxRDept.Value = dr["rClinicalDept"];
                ASPxComboBoxPost.Value = dr["rPostCategory"];
                ASPxComboBoxPer.Value = dr["rPersonCategory"];
                ASPxComboBoxTech.Value = dr["rTechCategory"];
                ASPxTextBoxWorkY.Value = dr["rWorkYears"];
            }
        }
        protected void SqlDataSourceParty_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Cancel = true;
            e.Command.Connection = oneConn;
            ReplaceNullWithDBNull(e.Command.Parameters);
            listDbCMDs.Add(e.Command);

            //e.Command.Transaction = oneTrans;
            //e.Command.Parameters["@baseEventID"].Value =bEventID.ToString();
            //db.ExecuteNonQuery(e.Command,oneTrans);

        }
        private void ReplaceNullWithDBNull(DbParameterCollection paras)
        {
            foreach (DbParameter ipara in paras)
            {
                if (ipara.Value == null)
                    ipara.Value = System.DBNull.Value;
            }
        }

        protected void cp_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            bEventID = Request.QueryString["baseEventID"];
            //保存成功标志
            bool resflag = false;
            string updateInsertBaseEvent = @"SET IDENTITY_INSERT  AE_ShareEventInfo ON;
INSERT INTO [AE_ShareEventInfo]
           ([baseEventID]
           ,[eventNo]
           ,[eventName]
           ,[eOccurTime]
           ,[eDiscoverTime]
           ,[eOccurDept]
           ,[eOccurSite]
           ,[eventCategory]
           ,[eventGrade]
           ,[eventDetails]
           ,[measures]
           ,[eventResult]
           ,[reportTime]
           ,[AEflag]
           ,[recordState]
           ,[operator]
           ,[operatingDT])
SELECT [baseEventID]
      ,[eventNo]
      ,[eventName]
      ,[eOccurTime]
      ,[eDiscoverTime]
      ,[eOccurDept]
      ,[eOccurSite]
      ,[eventCategory]
      ,[eventGrade]
      ,[eventDetails]
      ,[measures]
      ,[eventResult]
      ,[reportTime]
      ,[AEflag]
      ,(SELECT MAX([recordState]) FROM dbo.AE_ShareEventInfo WHERE baseEventID =@baseEventID)+1
      ,[operator]
      ,[operatingDT]
  FROM [AE_ShareEventInfo]
  WHERE recordState=1 AND  baseEventID =@baseEventID;
SET IDENTITY_INSERT  AE_ShareEventInfo OFF;
";

            DbCommand dbEventcmdLOG = db.GetSqlStringCommand(updateInsertBaseEvent);
            db.AddInParameter(dbEventcmdLOG, "baseEventID", DbType.String, bEventID);

            string updatebaseEvent = @"UPDATE [AE_ShareEventInfo]
                                       SET                 
                                        [eOccurTime]       =@eOccurTime, 
                                        [eOccurDept]       =@eOccurDept, 
                                        [eOccurSite]       =@eOccurSite, 
                                        [eventCategory]    =@eventCategory,
                                        [eventGrade]       =@eventGrade, 
                                        [eventDetails]     =@eventDetails, 
                                        [measures]         =@measures,
                                        [reportTime]     =@reportTime
                                 WHERE  recordState=1 AND baseEventID =@baseEventID;";

            DbCommand dbEventcmd = db.GetSqlStringCommand(updatebaseEvent);
            db.AddInParameter(dbEventcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbEventcmd, "eOccurTime", DbType.String, ASPxTimeEditOccur.Value);
            db.AddInParameter(dbEventcmd, "eOccurDept", DbType.String, ASPxComboBoxPDept.Value);
            db.AddInParameter(dbEventcmd, "eOccurSite", DbType.String, ASPxComboBoxSite.Value);
            db.AddInParameter(dbEventcmd, "eventCategory", DbType.String, ASPxComboBoxEType.Value);
            db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, ASPxRadioButtonList1.Value);
            db.AddInParameter(dbEventcmd, "eventDetails", DbType.String, ASPxMemoDetails.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "measures", DbType.String, ASPxMemoMeasures.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "reportTime", DbType.String, ASPxTimeEditReport.Value);

            string updatePatient = @"UPDATE [AE_PatientInfo]
                             SET   [hospitalID]        =@hospitalID,    
                                   [patientName]       =@patientName, 
                                   [patientSex]        =@patientSex, 
                                   [patientAge]        =@patientAge, 
                                   [jobTitle]          =@jobTitle,
                                   [clinicalDiagonse]  =@clinicalDiagonse,
                             WHERE baseEventID =@baseEventID;";

            DbCommand dbPatientcmd = db.GetSqlStringCommand(updatePatient);
            db.AddInParameter(dbPatientcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbPatientcmd, "hospitalID", DbType.String, ASPxTextBoxHID.Value);
            db.AddInParameter(dbPatientcmd, "patientName", DbType.String, ASPxTextBoxPName.Value);
            db.AddInParameter(dbPatientcmd, "patientSex", DbType.String, ASPxComboBoxSex.Value);
            db.AddInParameter(dbPatientcmd, "patientAge", DbType.String, ASPxTextBoxAge.Value);
            db.AddInParameter(dbPatientcmd, "jobTitle", DbType.String, ASPxTextBoxJob.Value);
            db.AddInParameter(dbPatientcmd, "clinicalDiagonse", DbType.String, ASPxTextBoxCDia.Value);

            string updateReportor = @"UPDATE [AE_ReportorInfo]
                                   SET [rPersonCategory]    =@rPersonCategory,
                                       [rPostCategory]      =@rPostCategory,
                                       [rWorkYears]         =@rWorkYears,
                                       [rClinicalDept]      =@rClinicalDept,
                                       [rTechCategory]      =@rTechCategory  
                             WHERE  baseEventID = @baseEventID;";
            //                                       [reportName]         =@reportName   
            DbCommand dbReportorcmd = db.GetSqlStringCommand(updateReportor);
            db.AddInParameter(dbReportorcmd, "baseEventID", DbType.String,bEventID);
            db.AddInParameter(dbReportorcmd, "rPersonCategory", DbType.String, ASPxComboBoxPer.Value);
            db.AddInParameter(dbReportorcmd, "rPostCategory", DbType.String, ASPxComboBoxPost.Value);
            db.AddInParameter(dbReportorcmd, "rWorkYears", DbType.String, ASPxTextBoxWorkY.Value);
            db.AddInParameter(dbReportorcmd, "rClinicalDept", DbType.String, ASPxComboBoxRDept.Value);
            db.AddInParameter(dbReportorcmd, "rTechCategory", DbType.String, ASPxComboBoxTech.Value);
            //db.AddInParameter(dbReportorcmd, "reportName", DbType.String, new UserCache().UserName);
            //db.AddInParameter(dbReportorcmd, "reportName", DbType.String, "");


            using (oneConn = db.CreateConnection())
            {
                oneConn.Open();
                oneTrans = oneConn.BeginTransaction();
                try
                {
                    db.ExecuteNonQuery(dbEventcmdLOG, oneTrans);
                    db.ExecuteNonQuery(dbEventcmd, oneTrans);
                    db.ExecuteNonQuery(dbPatientcmd, oneTrans);
                    db.ExecuteNonQuery(dbReportorcmd, oneTrans);

                    ASPxGridView1.UpdateEdit();
                    foreach (DbCommand icmd in listDbCMDs)
                    {
                        icmd.Parameters["@baseEventID"].Value = bEventID;
                        db.ExecuteNonQuery(icmd, oneTrans);
                    }

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
    }
}