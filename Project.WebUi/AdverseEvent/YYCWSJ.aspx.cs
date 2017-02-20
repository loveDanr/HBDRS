using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class YYCWSJ : MyBasePage
    {
        private static readonly SqlDatabase db = EnterpriseLibraryContainer.Current.GetInstance<SqlDatabase>("SQLConnString");
        private DbConnection oneConn = null;
        private DbTransaction oneTrans = null;
        private object bEventID = null;
        private List<DbCommand> listDbCMDs = new List<DbCommand>();
        
        //protected void Page_PreInit(object sender,EventArgs e)
        //{
        //    DevExpress.Web.ASPxWebControl.SetIECompatibilityModeEdge(this.ASPxGridView2);
        //}
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxTreeView1.ExpandAll();
            if (!IsPostBack)
            {
                ASPxTimeEditOccur.Value = DateTime.Now;
                ASPxTimeEditReport.Value = DateTime.Now;
                ASPxTimeEditDeath.Value = DateTime.Now;
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
        protected void SqlDataSourceMedi_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Cancel = true;
            e.Command.Connection = oneConn;
            ReplaceNullWithDBNull(e.Command.Parameters);
            listDbCMDs.Add(e.Command);
        }
        protected void cp_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            //保存成功标志
            bool resflag = false;

            string insertbaseEvent = @"INSERT INTO [AE_ShareEventInfo]
                                       (
                                        [eventName]
                                       ,[eOccurTime]
                                       ,[eOccurDept]
                                       ,[eOccurSite]
                                       ,[eventCategory]
                                       ,[eventGrade]
                                       ,[eventDetails]
                                       ,[measures]
                                       ,[reportTime]
                                        ,[operator]
                                        ,[operatingDT])
                                 VALUES
                                       (
                                       @eventName, 
                                       @eOccurTime, 
                                       @eOccurDept, 
                                       @eOccurSite, 
                                       @eventCategory, 
                                       @eventGrade, 
                                       @eventDetails, 
                                       @measures,
                                       @reportTime,
                                        @operator,
                                       Getdate());
                                    SELECT SCOPE_IDENTITY()";

            DbCommand dbEventcmd = db.GetSqlStringCommand(insertbaseEvent);
            db.AddInParameter(dbEventcmd, "eventName", DbType.String, "药品不良事件-用药错误");
            db.AddInParameter(dbEventcmd, "eOccurTime", DbType.String, ASPxTimeEditOccur.Value);
            db.AddInParameter(dbEventcmd, "eOccurDept", DbType.String, ASPxComboBoxPDept.Value);
            db.AddInParameter(dbEventcmd, "eOccurSite", DbType.String, ASPxComboBoxSite.Value);
            db.AddInParameter(dbEventcmd, "eventCategory", DbType.String, ASPxDropDownEditEtype.Value);
            if (ASPxTreeView1.SelectedNode != null)
            {
                db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, ASPxTreeView1.SelectedNode.Parent.Text + "—" + ASPxTreeView1.SelectedNode.Text);
            }
            else
            {
                db.AddInParameter(dbEventcmd, "eventGrade", DbType.String,System.DBNull.Value);
            }
            db.AddInParameter(dbEventcmd, "eventDetails", DbType.String, ASPxMemoDetails.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "measures", DbType.String, ASPxMemoMeasures.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "reportTime", DbType.String, ASPxTimeEditReport.Value);
            db.AddInParameter(dbEventcmd, "operator", DbType.String, loginUser.UserName);



            string insertMediEvent = @"INSERT INTO [AE_MediEventInfo]
                                       ([baseEventID]
                                       ,[YPSFFG]
                                       ,[HZSFSYYP]
                                       ,[TGXGZL])
                                 VALUES
                                       (@baseEventID,
                                       @YPSFFG,
                                       @HZSFSYYP,
                                       @TGXGZL )";

            DbCommand dbMediEventcmd = db.GetSqlStringCommand(insertMediEvent);
            db.AddInParameter(dbMediEventcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbMediEventcmd, "YPSFFG", DbType.String, ASPxComboBoxYPSF.Value);
            db.AddInParameter(dbMediEventcmd, "HZSFSYYP", DbType.String,ASPxComboBoxHZSF.Value) ;
            db.AddInParameter(dbMediEventcmd, "TGXGZL", DbType.String, ASPxComboBoxYPCFZL.Value);

            string insertPatient = @"INSERT INTO [AE_PatientInfo]
                                   ([hospitalID]
                                   ,[baseEventID]
                                   ,[patientName]
                                   ,[patientSex]
                                   ,[patientAge]
                                   ,[jobTitle]
                                    ,[pContact]
                                   ,[clinicalDiagonse]
                                    ,[nationality])
                             VALUES
                                   (@hospitalID, 
                                    @baseEventID,
                                   @patientName, 
                                   @patientSex, 
                                   @patientAge, 
                                   @jobTitle,
                                    @pContact,
                                   @clinicalDiagonse,
                                    @nationality)";
            DbCommand dbPatientcmd = db.GetSqlStringCommand(insertPatient);
            db.AddInParameter(dbPatientcmd, "hospitalID", DbType.String, ASPxTextBoxHID.Value);
            db.AddInParameter(dbPatientcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbPatientcmd, "patientName", DbType.String, ASPxTextBoxPName.Value);
            db.AddInParameter(dbPatientcmd, "patientSex", DbType.String, ASPxComboBoxSex.Value);
            db.AddInParameter(dbPatientcmd, "patientAge", DbType.String, ASPxTextBoxAge.Value);
            db.AddInParameter(dbPatientcmd, "jobTitle", DbType.String, ASPxTextBoxJob.Value);
            db.AddInParameter(dbPatientcmd, "pContact", DbType.String, ASPxTextBoxPContact.Value);
            db.AddInParameter(dbPatientcmd, "clinicalDiagonse", DbType.String, ASPxTextBoxCDia.Value);
            db.AddInParameter(dbPatientcmd, "nationality", DbType.String, ASPxTextBoxNa.Value);

            string insertPatientInjury = @"INSERT INTO [AE_PatientInjuryInfo]
                                           ([baseEventID]
                                           ,[RescueMeasure]
                                           ,[CJBWCD]
                                           ,[ZSSHBWCD]
                                           ,[RecoveryProcedure]
                                           ,[CauseOfDeath]
                                           ,[TimeOfDeath])
                                     VALUES
                                           (@baseEventID, 
                                           @RescueMeasure, 
                                           @CJBWCD, 
                                           @ZSSHBWCD, 
                                           @RecoveryProcedure, 
                                           @CauseOfDeath, 
                                           @TimeOfDeath)";
            DbCommand dbPatientInjuryCMD = db.GetSqlStringCommand(insertPatientInjury);
            db.AddInParameter(dbPatientInjuryCMD, "baseEventID", DbType.String);
            db.AddInParameter(dbPatientInjuryCMD, "RescueMeasure", DbType.String, ASPxTextBoxResMea.Value);
            db.AddInParameter(dbPatientInjuryCMD, "CJBWCD", DbType.String, ASPxTextBoxCJBW.Value);
            db.AddInParameter(dbPatientInjuryCMD, "ZSSHBWCD", DbType.String, ASPxTextBoxZSSH.Value);
            db.AddInParameter(dbPatientInjuryCMD, "RecoveryProcedure", DbType.String, ASPxTextBoxRecov.Value);
            db.AddInParameter(dbPatientInjuryCMD, "CauseOfDeath", DbType.String, ASPxTextBoxCauseD.Value);
            db.AddInParameter(dbPatientInjuryCMD, "TimeOfDeath", DbType.String, ASPxTimeEditDeath.Value);

            string insertReportor = @"INSERT INTO [AE_ReportorInfo]
                                   (
                                    [baseEventID]
                                   ,[rPersonCategory]
                                   ,[rPostCategory]
                                   ,[rWorkYears]
                                   ,[rClinicalDept]
                                   ,[rTechCategory]
                                    ,[rContact]
                                    ,[reportName])
                             VALUES
                                   (
                                   @baseEventID, 
                                   @rPersonCategory,
                                   @rPostCategory,
                                   @rWorkYears,
                                   @rClinicalDept,
                                   @rTechCategory,
                                    @rContact,
                                    @reportName)";
            DbCommand dbReportorcmd = db.GetSqlStringCommand(insertReportor);
            db.AddInParameter(dbReportorcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbReportorcmd, "rPersonCategory", DbType.String, ASPxComboBoxPer.Value);
            db.AddInParameter(dbReportorcmd, "rPostCategory", DbType.String, ASPxComboBoxPost.Value);
            db.AddInParameter(dbReportorcmd, "rWorkYears", DbType.String, ASPxTextBoxWorkY.Value);
            db.AddInParameter(dbReportorcmd, "rClinicalDept", DbType.String, ASPxComboBoxRDept.Value);
            db.AddInParameter(dbReportorcmd, "rTechCategory", DbType.String, ASPxComboBoxTech.Value);
            db.AddInParameter(dbReportorcmd, "rContact", DbType.String, ASPxTextBoxrContact.Value);
            db.AddInParameter(dbReportorcmd, "reportName", DbType.String, loginUser.UserName);


            using (oneConn = db.CreateConnection())
            {
                oneConn.Open();
                oneTrans = oneConn.BeginTransaction();
                try
                {
                    bEventID = db.ExecuteScalar(dbEventcmd, oneTrans);

                    dbMediEventcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbMediEventcmd, oneTrans);
                    dbPatientcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbPatientcmd, oneTrans);
                    dbPatientInjuryCMD.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbPatientInjuryCMD,oneTrans);
                    dbReportorcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbReportorcmd, oneTrans);


                    ASPxGridView1.UpdateEdit();
                    ASPxGridView2.UpdateEdit();
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