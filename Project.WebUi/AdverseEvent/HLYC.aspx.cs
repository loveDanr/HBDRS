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
    public partial class HLYC : MyBasePage
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
                ASPxTimeEditInfromFamilyTime.Value = DateTime.Now;
                ASPxTimeEditOccur.Value = DateTime.Now;
                ASPxTimeEditReport.Value = DateTime.Now;
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
            if (ASPxCheckBoxBL.Checked)
            {
                db.AddInParameter(dbEventcmd, "eventName", DbType.String, "护理不良事件-非预期压疮");
            }
            else
            {
                db.AddInParameter(dbEventcmd, "eventName", DbType.String, "压疮事件");
            }
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


            string insertPressEvent = @"INSERT INTO [AE_PressureSoresEventInfo]
                                       ([baseEventID]
                                       ,[PressureArea]
                                       ,[AreaLength]
                                       ,[AreaWidth]
                                       ,[AreaDepth]
                                       ,[POccurPeriod]
                                       ,[BeforeSource]
                                       ,[PressureLevel]
                                       ,[PNoAvoid]
                                       ,[PressureReason]
                                       ,[ExcludeCases]
                                       ,[RiskAssessFlag]
                                       ,[InfromFamily]
                                       ,[InfromFamilyTime]
                                       ,[ExudationStatus]
                                       ,[ExudationColor]
                                       ,[ExudationSmell]
                                       ,[ExudationAmount]
                                       ,[InfectionFlag]
                                       ,[TissueNecrosis]
                                       ,[SurroundingState]
                                       ,[NursingPrecautions]
                                       ,[SubmitReport])
                                 VALUES
                                       (@baseEventID, 
                                       @PressureArea, 
                                       @AreaLength, 
                                       @AreaWidth, 
                                       @AreaDepth, 
                                       @POccurPeriod, 
                                       @BeforeSource, 
                                       @PressureLevel, 
                                       @PNoAvoid, 
                                       @PressureReason, 
                                       @ExcludeCases, 
                                       @RiskAssessFlag, 
                                       @InfromFamily, 
                                       @InfromFamilyTime, 
                                       @ExudationStatus, 
                                       @ExudationColor, 
                                       @ExudationSmell, 
                                       @ExudationAmount, 
                                       @InfectionFlag, 
                                       @TissueNecrosis, 
                                       @SurroundingState, 
                                       @NursingPrecautions, 
                                       @SubmitReport )";

            DbCommand dbPressEventcmd = db.GetSqlStringCommand(insertPressEvent);
            db.AddInParameter(dbPressEventcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbPressEventcmd, "PressureArea", DbType.String, ASPxComboBoxPressureArea.Value);
            db.AddInParameter(dbPressEventcmd, "AreaLength", DbType.String, ASPxTextBoxAreaLength.Value);
            db.AddInParameter(dbPressEventcmd, "AreaWidth", DbType.String, ASPxTextBoxAreaWidth.Value);
            db.AddInParameter(dbPressEventcmd, "AreaDepth", DbType.String, ASPxTextBoxAreaDepth.Value);
            db.AddInParameter(dbPressEventcmd, "POccurPeriod", DbType.String, ASPxComboBoxPOccurPeriod.Value);
            db.AddInParameter(dbPressEventcmd, "BeforeSource", DbType.String, ASPxComboBoxBeforeSource.Value);
            db.AddInParameter(dbPressEventcmd, "PressureLevel", DbType.String, ASPxComboBoxPressureLevel.Value);
            db.AddInParameter(dbPressEventcmd, "PNoAvoid", DbType.String, ASPxComboBoxPNoAvoid.Value);
            db.AddInParameter(dbPressEventcmd, "PressureReason", DbType.String, ASPxDropDownEditPressReason.Value);
            db.AddInParameter(dbPressEventcmd, "ExcludeCases", DbType.String, ASPxComboBoxExcludeCases.Value);
            db.AddInParameter(dbPressEventcmd, "RiskAssessFlag", DbType.String, ASPxComboBoxRiskAssessFlag.Value);
            db.AddInParameter(dbPressEventcmd, "InfromFamily", DbType.String, ASPxComboBoxInfromFamily.Value);
            db.AddInParameter(dbPressEventcmd, "InfromFamilyTime", DbType.String, ASPxTimeEditInfromFamilyTime.Value);
            db.AddInParameter(dbPressEventcmd, "ExudationStatus", DbType.String, ASPxComboBoxExudationStatus.Value);
            db.AddInParameter(dbPressEventcmd, "ExudationColor", DbType.String, ASPxTextBoxExudationColor.Value);
            db.AddInParameter(dbPressEventcmd, "ExudationSmell", DbType.String, ASPxTextBoxExudationSmell.Value);
            db.AddInParameter(dbPressEventcmd, "ExudationAmount", DbType.String, ASPxTextBoxExudationAmount.Value);
            db.AddInParameter(dbPressEventcmd, "InfectionFlag", DbType.String, ASPxComboBoxInfectionFlag.Value);
            db.AddInParameter(dbPressEventcmd, "TissueNecrosis", DbType.String, ASPxComboBoxTissueNecrosis.Value);
            db.AddInParameter(dbPressEventcmd, "SurroundingState", DbType.String, ASPxComboBoxSurroundingState.Value);
            db.AddInParameter(dbPressEventcmd, "NursingPrecautions", DbType.String, ASPxComboBoxNursingPrecautions.Value);
            db.AddInParameter(dbPressEventcmd, "SubmitReport", DbType.String, ASPxComboBoxSubmitReport.Value);

            string insertPatient = @"INSERT INTO [AE_PatientInfo]
                                   ([hospitalID]
                                   ,[baseEventID]
                                   ,[patientName]
                                   ,[patientSex]
                                   ,[patientAge]
                                    ,[patientWeight]
                                   ,[clinicalDiagonse])
                             VALUES
                                   (@hospitalID, 
                                    @baseEventID,
                                   @patientName, 
                                   @patientSex, 
                                   @patientAge, 
                                    @patientWeight,
                                   @clinicalDiagonse)";
            DbCommand dbPatientcmd = db.GetSqlStringCommand(insertPatient);
            db.AddInParameter(dbPatientcmd, "hospitalID", DbType.String, ASPxTextBoxHID.Value);
            db.AddInParameter(dbPatientcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbPatientcmd, "patientName", DbType.String, ASPxTextBoxPName.Value);
            db.AddInParameter(dbPatientcmd, "patientSex", DbType.String, ASPxComboBoxSex.Value);
            db.AddInParameter(dbPatientcmd, "patientAge", DbType.String, ASPxTextBoxAge.Value);
            db.AddInParameter(dbPatientcmd, "patientWeight", DbType.String, ASPxTextBoxPWeight.Value);
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

                    dbPressEventcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbPressEventcmd, oneTrans);
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