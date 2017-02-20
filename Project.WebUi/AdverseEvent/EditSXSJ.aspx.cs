using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using System.Data;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class EditSXSJ : MyBasePage
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
                " SELECT [eOccurTime],[eOccurDept],[eOccurSite],[eventGrade],[eventDetails],[measures],[reportTime] FROM AE_ShareEventInfo WHERE recordState=1 AND  baseEventID = @baseEventID;" +
                " SELECT [hospitalID],[patientName],[patientSex],[patientAge],[nationality],[maritalStatus],[pregnantNums],[birthNums] FROM AE_PatientInfo WHERE  baseEventID = @baseEventID;" +
                " SELECT [rPersonCategory],[rPostCategory],[rWorkYears],[rClinicalDept],[rTechCategory] FROM AE_ReportorInfo WHERE  baseEventID = @baseEventID;" +
                " SELECT [pABO],[pRHD],[BGZKTJC],[JWSXS],[clinicalDiagonse],[XYZJMC],[sABO],[sRHD],[BCSXFYZZ],[FYCXSJ],[SXFYLX] FROM AE_BloodEventInfo WHERE  baseEventID = @baseEventID;" +
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
                ASPxTextBoxN.Value = dr["nationality"];
                ASPxComboBoxM.Value = dr["maritalStatus"];
                ASPxTextBoxPre.Value = dr["pregnantNums"];
                ASPxTextBoxBir.Value = dr["birthNums"];
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
            dr = db.ExecuteDataSet(queryEventcmd).Tables[3].Rows[0];
            if (dr != null)
            {
                ASPxComboBoxPABO.Value = dr["pABO"];
                ASPxComboBoxPRHD.Value = dr["pRHD"];
                ASPxComboBox5.Value = dr["BGZKTJC"];
                ASPxComboBox6.Value = dr["JWSXS"];
                ASPxTextBox1.Value = dr["clinicalDiagonse"];
                ASPxComboBox7.Value = dr["XYZJMC"];
                ASPxComboBoxSABO.Value = dr["sABO"];
                ASPxComboBoxSRHD.Value = dr["sRHD"];
                ASPxComboBox10.Value = dr["BCSXFYZZ"];
                ASPxTimeEditFeed.Value = dr["FYCXSJ"];
                ASPxComboBoxFeed.Value = dr["SXFYLX"];
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
            //基本共用事件
            string updatebaseEvent = @"UPDATE [AE_ShareEventInfo]
                                       SET
                                        [eOccurTime]    =@eOccurTime, 
                                        [eOccurDept]    =@eOccurDept, 
                                        [eOccurSite]    =@eOccurSite, 
                                        [reportTime]    =@reportTime, 
                                        [eventGrade]    =@eventGrade, 
                                        [eventDetails]  =@eventDetails, 
                                        [measures]      =@measures 
                                 WHERE recordState=1 AND  baseEventID=@baseEventID;";

            DbCommand dbEventcmd = db.GetSqlStringCommand(updatebaseEvent);
            //db.AddInParameter(dbEventcmd, "eventName", DbType.String, "输血不良事件");
            db.AddInParameter(dbEventcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbEventcmd, "eOccurTime", DbType.String, ASPxTimeEditOccur.Value);
            db.AddInParameter(dbEventcmd, "eOccurDept", DbType.String, ASPxComboBoxPDept.Value);
            db.AddInParameter(dbEventcmd, "eOccurSite", DbType.String, ASPxComboBoxSite.Value);
            db.AddInParameter(dbEventcmd, "reportTime", DbType.String, ASPxTimeEditReport.Value);
            db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, ASPxRadioButtonList1.Value);
            db.AddInParameter(dbEventcmd, "eventDetails", DbType.String, ASPxMemoDetails.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "measures", DbType.String, ASPxMemoMeasures.Text.Trim().Replace(" ", ""));

            string updateBloodEvent = @"UPDATE [AE_BloodEventInfo]
                                       SET
                                       [pABO]             =@pABO,    
                                       [pRHD]             =@pRHD, 
                                       [BGZKTJC]          =@BGZKTJC, 
                                       [JWSXS]            =@JWSXS, 
                                       [clinicalDiagonse] =@clinicalDiagonse,
                                       [XYZJMC]           =@XYZJMC, 
                                       [sABO]             =@sABO, 
                                       [sRHD]             =@sRHD, 
                                       [BCSXFYZZ]         =@BCSXFYZZ, 
                                       [FYCXSJ]           =@FYCXSJ, 
                                       [SXFYLX]           =@SXFYLX 
                                 WHERE baseEventID =@baseEventID;";

            DbCommand dbBloodEventcmd = db.GetSqlStringCommand(updateBloodEvent);
            db.AddInParameter(dbBloodEventcmd, "baseEventID", DbType.String,bEventID);
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
            string updatePatient = @"UPDATE [AE_PatientInfo]
                                     SET
                                     [hospitalID]     =@hospitalID, 
                                     [patientName]    =@patientName, 
                                     [patientSex]     =@patientSex, 
                                     [patientAge]     =@patientAge, 
                                     [nationality]    =@nationality,
                                     [maritalStatus]  =@maritalStatus,
                                     [pregnantNums]   =@pregnantNums,
                                     [birthNums]      =@birthNums
                             WHERE  baseEventID=@baseEventID;";

            DbCommand dbPatientcmd = db.GetSqlStringCommand(updatePatient);
            db.AddInParameter(dbPatientcmd, "baseEventID", DbType.String,bEventID);
            db.AddInParameter(dbPatientcmd, "hospitalID", DbType.String, ASPxTextBoxHID.Value);
            db.AddInParameter(dbPatientcmd, "patientName", DbType.String, ASPxTextBoxPName.Value);
            db.AddInParameter(dbPatientcmd, "patientSex", DbType.String, ASPxComboBoxSex.Value);
            db.AddInParameter(dbPatientcmd, "patientAge", DbType.String, ASPxTextBoxAge.Value);
            db.AddInParameter(dbPatientcmd, "nationality", DbType.String, ASPxTextBoxN.Value);
            db.AddInParameter(dbPatientcmd, "maritalStatus", DbType.String, ASPxComboBoxM.Value);
            db.AddInParameter(dbPatientcmd, "pregnantNums", DbType.String, ASPxTextBoxPre.Value);
            db.AddInParameter(dbPatientcmd, "birthNums", DbType.String, ASPxTextBoxBir.Value);
            //报告人信息
            string updateReportor = @"UPDATE [AE_ReportorInfo]
                                   SET
                                   [rPersonCategory] =@rPersonCategory,
                                   [rPostCategory]   =@rPostCategory,
                                   [rWorkYears]      =@rWorkYears,
                                   [rClinicalDept]   =@rClinicalDept,
                                   [rTechCategory]   =@rTechCategory
                             WHERE baseEventID =@baseEventID;";
            //                                  [reportName]      =@reportName
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