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
    public partial class SXBLFY : MyBasePage
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
                ASPxTimeEditOccur.Value = DateTime.Now;
                ASPxTimeEditReport.Value = DateTime.Now;
                ASPxTimeEditFeed.Value = DateTime.Now;
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
            //基本共用事件
            string insertbaseEvent = @"INSERT INTO [AE_ShareEventInfo]
                                       (
                                        [eventName]
                                       ,[eOccurTime]
                                       ,[eOccurDept]
                                       ,[eOccurSite]
                                       ,[reportTime]
                                       ,[eventGrade]
                                       ,[eventDetails]
                                       ,[measures]
                                        ,[operator]
                                       ,[operatingDT])
                                 VALUES
                                       (
                                       @eventName, 
                                       @eOccurTime, 
                                       @eOccurDept, 
                                       @eOccurSite, 
                                       @reportTime, 
                                       @eventGrade, 
                                       @eventDetails, 
                                       @measures,
                                    @operator,
                                       Getdate());
                                    SELECT SCOPE_IDENTITY()";

            DbCommand dbEventcmd = db.GetSqlStringCommand(insertbaseEvent);
            db.AddInParameter(dbEventcmd, "eventName", DbType.String, "输血不良事件");
            db.AddInParameter(dbEventcmd, "eOccurTime", DbType.String, ASPxTimeEditOccur.Value);
            db.AddInParameter(dbEventcmd, "eOccurDept", DbType.String, ASPxComboBoxPDept.Value);
            db.AddInParameter(dbEventcmd, "eOccurSite", DbType.String, ASPxComboBoxSite.Value);
            db.AddInParameter(dbEventcmd, "reportTime", DbType.String, ASPxTimeEditReport.Value);
            db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, ASPxRadioButtonList1.Value);
            db.AddInParameter(dbEventcmd, "eventDetails", DbType.String, ASPxMemoDetails.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "measures", DbType.String, ASPxMemoMeasures.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "operator", DbType.String, loginUser.UserName);

            string insertBloodEvent = @"INSERT INTO [AE_BloodEventInfo]
                                       (
                                       [baseEventID]
                                       ,[pABO]
                                       ,[pRHD]
                                       ,[BGZKTJC]
                                       ,[JWSXS]
                                       ,[clinicalDiagonse]
                                       ,[XYZJMC]
                                       ,[sABO]
                                       ,[sRHD]
                                       ,[BCSXFYZZ]
                                       ,[FYCXSJ]
                                       ,[SXFYLX])
                                 VALUES
                                       (
                                       @baseEventID, 
                                       @pABO, 
                                       @pRHD, 
                                       @BGZKTJC, 
                                       @JWSXS, 
                                       @clinicalDiagonse, 
                                       @XYZJMC, 
                                       @sABO, 
                                       @sRHD, 
                                       @BCSXFYZZ, 
                                       @FYCXSJ, 
                                       @SXFYLX )";
            DbCommand dbBloodEventcmd = db.GetSqlStringCommand(insertBloodEvent);
            db.AddInParameter(dbBloodEventcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbBloodEventcmd, "pABO", DbType.String, ASPxComboBoxPABO.Value);
            db.AddInParameter(dbBloodEventcmd, "pRHD", DbType.String, ASPxComboBoxPRHD.Value);
            db.AddInParameter(dbBloodEventcmd, "BGZKTJC", DbType.String, ASPxComboBox5.Value);
            db.AddInParameter(dbBloodEventcmd, "JWSXS", DbType.String, ASPxComboBox6.Value);
            db.AddInParameter(dbBloodEventcmd, "clinicalDiagonse", DbType.String, ASPxTextBox1.Value);
            db.AddInParameter(dbBloodEventcmd, "XYZJMC", DbType.String, ASPxComboBox7.Value);
            db.AddInParameter(dbBloodEventcmd, "sABO", DbType.String, ASPxComboBoxSABO.Value);
            db.AddInParameter(dbBloodEventcmd, "sRHD", DbType.String, ASPxComboBoxSRHD.Value);
            db.AddInParameter(dbBloodEventcmd, "BCSXFYZZ", DbType.String, ASPxComboBox10.Value);
            db.AddInParameter(dbBloodEventcmd, "FYCXSJ", DbType.String, ASPxTimeEditFeed.Value);
            db.AddInParameter(dbBloodEventcmd, "SXFYLX", DbType.String, ASPxComboBoxFeed.Value);
            //患者信息
            string insertPatient = @"INSERT INTO [AE_PatientInfo]
                                   ([hospitalID]
                                    ,[baseEventID]
                                    ,[patientName]
                                    ,[patientSex]
                                    ,[patientAge]
                                    ,[nationality]
                                    ,[maritalStatus]
                                    ,[pregnantNums]
                                    ,[birthNums])
                             VALUES
                                   (@hospitalID, 
                                    @baseEventID,
                                    @patientName, 
                                    @patientSex, 
                                    @patientAge, 
                                    @nationality,
                                    @maritalStatus,
                                    @pregnantNums,
                                    @birthNums
                                    )";
            DbCommand dbPatientcmd = db.GetSqlStringCommand(insertPatient);
            db.AddInParameter(dbPatientcmd, "hospitalID", DbType.String, ASPxTextBoxHID.Value);
            db.AddInParameter(dbPatientcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbPatientcmd, "patientName", DbType.String, ASPxTextBoxPName.Value);
            db.AddInParameter(dbPatientcmd, "patientSex", DbType.String, ASPxComboBoxSex.Value);
            db.AddInParameter(dbPatientcmd, "patientAge", DbType.String, ASPxTextBoxAge.Value);
            db.AddInParameter(dbPatientcmd, "nationality", DbType.String, ASPxTextBoxN.Value);
            db.AddInParameter(dbPatientcmd, "maritalStatus", DbType.String, ASPxComboBoxM.Value);
            db.AddInParameter(dbPatientcmd, "pregnantNums", DbType.String, ASPxTextBoxPre.Value);
            db.AddInParameter(dbPatientcmd, "birthNums", DbType.String, ASPxTextBoxBir.Value);
            //报告人信息
            string insertReportor = @"INSERT INTO [AE_ReportorInfo]
                                   (
                                    [baseEventID]
                                   ,[rPersonCategory]
                                   ,[rPostCategory]
                                   ,[rWorkYears]
                                   ,[rClinicalDept]
                                   ,[rTechCategory]
                                    ,[reportName])
                             VALUES
                                   (
                                   @baseEventID, 
                                   @rPersonCategory,
                                   @rPostCategory,
                                   @rWorkYears,
                                   @rClinicalDept,
                                   @rTechCategory,
                                    @reportName)";
            DbCommand dbReportorcmd = db.GetSqlStringCommand(insertReportor);
            db.AddInParameter(dbReportorcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbReportorcmd, "rPersonCategory", DbType.String, ASPxComboBoxPer.Value);
            db.AddInParameter(dbReportorcmd, "rPostCategory", DbType.String, ASPxComboBoxPost.Value);
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


                    dbPatientcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbPatientcmd, oneTrans);
                    dbReportorcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbReportorcmd, oneTrans);
                    dbBloodEventcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbBloodEventcmd, oneTrans);
                    //当事人
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