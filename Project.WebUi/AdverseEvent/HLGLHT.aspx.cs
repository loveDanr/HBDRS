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
    public partial class HLGLHT : MyBasePage
    {
        private static readonly SqlDatabase db = EnterpriseLibraryContainer.Current.GetInstance<SqlDatabase>("SQLConnString");
        private DbConnection oneConn = null;
        private DbTransaction oneTrans = null;
        private object bEventID = null;
        private List<DbCommand> listDbCMDs = new List<DbCommand>();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxTreeView1.ExpandAll();
            if (!IsPostBack)
            {
                ASPxCheckBoxBL.Visible = false;
                ASPxTimeEditOccur.Value = DateTime.Now;
                ASPxTimeEditReport.Value = DateTime.Now;
                ASPxTimeEditCatheter.Value = DateTime.Now;
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
            //保存成功标志
            bool resflag = false;

            string insertbaseEvent = @"INSERT INTO [AE_ShareEventInfo]
                                       (
                                        [eventName]
                                       ,[eOccurTime]
                                       ,[eOccurDept]
                                       ,[eOccurSite]
                                       ,[eventGrade]
                                       ,[eventDetails]
                                       ,[measures]
                                       ,[reportTime]
                                       ,[AEflag]
                                        ,[operator]
                                        ,[operatingDT])
                                 VALUES
                                       (
                                       @eventName, 
                                       @eOccurTime, 
                                       @eOccurDept, 
                                       @eOccurSite, 
                                       @eventGrade, 
                                       @eventDetails, 
                                       @measures,
                                       @reportTime,
                                       @AEflag,
                                       @operator,
                                       Getdate());
                                    SELECT SCOPE_IDENTITY()";

            DbCommand dbEventcmd = db.GetSqlStringCommand(insertbaseEvent);
            db.AddInParameter(dbEventcmd, "eventName", DbType.String, "护理不良事件-管路滑脱");
            db.AddInParameter(dbEventcmd, "eOccurTime", DbType.String, ASPxTimeEditOccur.Value);
            db.AddInParameter(dbEventcmd, "eOccurDept", DbType.String, ASPxComboBoxPDept.Value);
            db.AddInParameter(dbEventcmd, "eOccurSite", DbType.String, ASPxComboBoxSite.Value);
            //db.AddInParameter(dbEventcmd, "eventCategory", DbType.String, ASPxComboBoxEType.Value);
            if (ASPxTreeView1.SelectedNode != null)
            {
                db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, ASPxTreeView1.SelectedNode.Parent.Text + "—" + ASPxTreeView1.SelectedNode.Text);
            }
            else
            {
                db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, System.DBNull.Value);
            }
            db.AddInParameter(dbEventcmd, "eventDetails", DbType.String, ASPxMemoDetails.Text.Trim().Replace(" ", ""));
            //db.AddInParameter(dbEventcmd, "eventResult", DbType.String, ASPxComboBoxEResult.Value);
            db.AddInParameter(dbEventcmd, "measures", DbType.String, ASPxMemoMeasures.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "reportTime", DbType.String, ASPxTimeEditReport.Value);
            db.AddInParameter(dbEventcmd, "AEflag", DbType.Boolean, ASPxCheckBoxBL.Checked);
            db.AddInParameter(dbEventcmd, "operator", DbType.String, loginUser.UserName);

            string insertPipeEvent = @"INSERT INTO [AE_PipeSlipEventInfo]
                                   ([baseEventID]
                                   ,[CatheterTime]
                                   ,[CatheterType]
                                   ,[PConsciousState]
                                   ,[PMentalState]
                                   ,[PActivity]
                                   ,[PSelfCare]
                                   ,[Fixation]
                                   ,[HealthEducation]
                                   ,[LeashUsage]
                                   ,[SFSYZJJ]
                                   ,[HGTLSGZRY]
                                   ,[HZJWTL]
                                   ,[Complication]
                                   ,[SubmitReport]
                                   ,[YWPBZ]
                                   ,[HTCLCS])
                             VALUES
                                   (@baseEventID, 
                                   @CatheterTime, 
                                   @CatheterType, 
                                   @PConsciousState, 
                                   @PMentalState, 
                                   @PActivity, 
                                   @PSelfCare, 
                                   @Fixation, 
                                   @HealthEducation, 
                                   @LeashUsage, 
                                   @SFSYZJJ, 
                                   @HGTLSGZRY, 
                                   @HZJWTL, 
                                   @Complication, 
                                   @SubmitReport, 
                                   @YWPBZ, 
                                   @HTCLCS)";

            DbCommand dbPipeEventcmd = db.GetSqlStringCommand(insertPipeEvent);
            db.AddInParameter(dbPipeEventcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbPipeEventcmd, "CatheterTime", DbType.String, ASPxTimeEditCatheter.Value);
            db.AddInParameter(dbPipeEventcmd, "CatheterType", DbType.String, ASPxComboBoxCatheterType.Value);
            db.AddInParameter(dbPipeEventcmd, "PConsciousState", DbType.String, ASPxComboBoxPConsciousState.Value);
            db.AddInParameter(dbPipeEventcmd, "PMentalState", DbType.String, ASPxComboBoxPMentalState.Value);
            db.AddInParameter(dbPipeEventcmd, "PActivity", DbType.String, ASPxComboBoxPActivity.Value);
            db.AddInParameter(dbPipeEventcmd, "PSelfCare", DbType.String, ASPxComboBoxPSelfCare.Value);
            db.AddInParameter(dbPipeEventcmd, "Fixation", DbType.String, ASPxComboBoxFixation.Value);
            db.AddInParameter(dbPipeEventcmd, "HealthEducation", DbType.String, ASPxComboBoxHealthEducation.Value);
            db.AddInParameter(dbPipeEventcmd, "LeashUsage", DbType.String, ASPxComboBoxLeashUsage.Value);
            db.AddInParameter(dbPipeEventcmd, "SFSYZJJ", DbType.String, ASPxComboBoxSFSYZJJ.Value);
            db.AddInParameter(dbPipeEventcmd, "HGTLSGZRY", DbType.String, ASPxComboBoxHGTLSGZRY.Value);
            db.AddInParameter(dbPipeEventcmd, "HZJWTL", DbType.String, ASPxComboBoxHZJWTL.Value);
            db.AddInParameter(dbPipeEventcmd, "Complication", DbType.String, ASPxComboBoxComplication.Value);
            db.AddInParameter(dbPipeEventcmd, "SubmitReport", DbType.String, ASPxComboBoxSubmitReport.Value);
            db.AddInParameter(dbPipeEventcmd, "YWPBZ", DbType.String, ASPxComboBoxYWPBZ.Value);
            db.AddInParameter(dbPipeEventcmd, "HTCLCS", DbType.String, ASPxComboBoxHTCLCS.Value);

            string insertPatient = @"INSERT INTO [AE_PatientInfo]
                                   ([hospitalID]
                                   ,[baseEventID]
                                   ,[patientName]
                                   ,[patientSex]
                                   ,[patientAge]
                                   ,[nurseLevel]
                                   ,[clinicalDiagonse])
                             VALUES
                                   (@hospitalID, 
                                    @baseEventID,
                                   @patientName, 
                                   @patientSex, 
                                   @patientAge, 
                                   @nurseLevel,
                                   @clinicalDiagonse)";
            DbCommand dbPatientcmd = db.GetSqlStringCommand(insertPatient);
            db.AddInParameter(dbPatientcmd, "hospitalID", DbType.String, ASPxTextBoxHID.Value);
            db.AddInParameter(dbPatientcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbPatientcmd, "patientName", DbType.String, ASPxTextBoxPName.Value);
            db.AddInParameter(dbPatientcmd, "patientSex", DbType.String, ASPxComboBoxSex.Value);
            db.AddInParameter(dbPatientcmd, "patientAge", DbType.String, ASPxTextBoxAge.Value);
            db.AddInParameter(dbPatientcmd, "nurseLevel", DbType.String, ASPxComboBoxNLevel.Value);
            db.AddInParameter(dbPatientcmd, "clinicalDiagonse", DbType.String, ASPxTextBoxCDia.Value);


            string insertReportor = @"INSERT INTO [AE_ReportorInfo]
                                   (
                                    [baseEventID]
                                   ,[rPersonCategory]
                                   ,[rPostCategory]
                                    ,[rPostLevel]
                                   ,[rWorkYears]
                                   ,[rClinicalDept]
                                   ,[rTechCategory]
                                   ,[reportName])
                             VALUES
                                   (
                                   @baseEventID, 
                                   @rPersonCategory,
                                   @rPostCategory,
                                    @rPostLevel,
                                   @rWorkYears,
                                   @rClinicalDept,
                                   @rTechCategory,
                                   @reportName)";
            DbCommand dbReportorcmd = db.GetSqlStringCommand(insertReportor);
            db.AddInParameter(dbReportorcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbReportorcmd, "rPersonCategory", DbType.String, ASPxComboBoxPer.Value);
            db.AddInParameter(dbReportorcmd, "rPostCategory", DbType.String, ASPxComboBoxPost.Value);
            db.AddInParameter(dbReportorcmd, "rPostLevel", DbType.String, ASPxComboBoxPostLevel.Value);
            db.AddInParameter(dbReportorcmd, "rWorkYears", DbType.String, ASPxTextBoxWorkY.Value);
            db.AddInParameter(dbReportorcmd, "rClinicalDept", DbType.String, ASPxComboBoxRDept.Value);
            db.AddInParameter(dbReportorcmd, "rTechCategory", DbType.String, ASPxComboBoxTech.Value);
            db.AddInParameter(dbReportorcmd, "reportName", DbType.String, loginUser.UserName);

            using (oneConn = db.CreateConnection())
            {
                oneConn.Open();
                oneTrans = oneConn.BeginTransaction();
                try
                {
                    bEventID = db.ExecuteScalar(dbEventcmd, oneTrans);

                    dbPipeEventcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbPipeEventcmd, oneTrans);
                    dbPatientcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbPatientcmd, oneTrans);
                    dbReportorcmd.Parameters["@baseEventID"].Value = bEventID;
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