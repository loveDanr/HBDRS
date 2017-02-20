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
using DevExpress.Web;

namespace Project.WebUi.AdverseEvent
{
    public partial class EditYPZL : MyBasePage
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
                bEventID = Request.QueryString["baseEventID"];
                InitFromSql();
            }
        }
        private void InitFromSql()
        {
            string selectSql = "BEGIN" +
                " SELECT [eOccurTime],[eDiscoverTime],[eOccurDept],[eOccurSite],[eventCategory],[eventGrade],[eventDetails],[measures],[reportTime] FROM AE_ShareEventInfo WHERE  recordState=1 AND baseEventID = @baseEventID;" +
                " SELECT [hospitalID],[patientName],[patientSex],[patientAge],[nationality],[jobTitle],[pContact],[clinicalDiagonse] FROM AE_PatientInfo WHERE  baseEventID = @baseEventID;" +
                " SELECT [rPersonCategory],[rPostCategory],[rWorkYears],[rClinicalDept],[rTechCategory],[rContact] FROM AE_ReportorInfo WHERE  baseEventID = @baseEventID;" +
                " SELECT [YPSFFG],[HZSFSYYP],[TGXGZL] FROM AE_MediEventInfo WHERE  baseEventID = @baseEventID;" +
                " SELECT [RescueMeasure],[CJBWCD],[ZSSHBWCD],[RecoveryProcedure],[CauseOfDeath],[TimeOfDeath] FROM AE_PatientInjuryInfo WHERE  baseEventID = @baseEventID;" +
                " END;";

            DbCommand queryEventcmd = db.GetSqlStringCommand(selectSql);
            db.AddInParameter(queryEventcmd, "baseEventID", DbType.String, bEventID);
            DataRow dr = db.ExecuteDataSet(queryEventcmd).Tables[0].Rows[0];
            if (dr != null)
            {
                ASPxTimeEditReport.Value = dr["reportTime"];
                ASPxTimeEditOccur.Value = dr["eOccurTime"];
                ASPxTimeEditDiscover.Value = dr["eDiscoverTime"];
                ASPxComboBoxPDept.Value = dr["eOccurDept"];
                ASPxComboBoxSite.Value = dr["eOccurSite"];
                ASPxComboBoxEType.Value = dr["eventCategory"];
                ASPxMemoDetails.Value = dr["eventDetails"];
                ASPxMemoMeasures.Value = dr["measures"];
                TreeViewNode tvn = null;
                if (dr["eventGrade"] != null)
                {
                    string[] res = dr["eventGrade"].ToString().Split('—');
                    if (res.Length == 2)
                    {
                        tvn = ASPxTreeView1.Nodes.FindByText(res[1]);
                    }
                }
                if (tvn != null)
                {
                    tvn.Checked = true;
                    ASPxTreeView1.SelectedNode = tvn;
                }

            }
            dr = db.ExecuteDataSet(queryEventcmd).Tables[1].Rows[0];
            if (dr != null)
            {
                ASPxTextBoxHID.Value = dr["hospitalID"];
                ASPxTextBoxPName.Value = dr["patientName"];
                ASPxComboBoxSex.Value = dr["patientSex"];
                ASPxTextBoxAge.Value = dr["patientAge"];
                ASPxTextBoxNa.Value = dr["nationality"];
                ASPxTextBoxJob.Value = dr["jobTitle"];
                ASPxTextBoxPContact.Value = dr["pContact"];
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
                ASPxTextBoxrContact.Value = dr["rContact"];
            }
            dr = db.ExecuteDataSet(queryEventcmd).Tables[3].Rows[0];
            if (dr != null)
            {
                ASPxComboBoxYPSF.Value = dr["YPSFFG"];
                ASPxComboBoxHZSF.Value = dr["HZSFSYYP"];
                ASPxComboBoxYPCFZL.Value = dr["TGXGZL"];
            }
            dr = db.ExecuteDataSet(queryEventcmd).Tables[4].Rows[0];
            if (dr != null)
            {
                ASPxTextBoxResMea.Value = dr["RescueMeasure"];
                ASPxTextBoxCJBW.Value = dr["CJBWCD"];
                ASPxTextBoxZSSH.Value = dr["ZSSHBWCD"];
                ASPxTextBoxRecov.Value = dr["RecoveryProcedure"];
                ASPxTextBoxCauseD.Value = dr["CauseOfDeath"];
                ASPxTimeEditDeath.Value = dr["TimeOfDeath"];

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
                                        [eOccurTime]     =@eOccurTime, 
                                        [eDiscoverTime]  =@eDiscoverTime,
                                        [eOccurDept]     =@eOccurDept, 
                                        [eOccurSite]     =@eOccurSite, 
                                        [eventCategory]  =@eventCategory,
                                        [eventGrade]     =@eventGrade, 
                                        [eventDetails]   =@eventDetails, 
                                        [measures]       =@measures,
                                        [reportTime]     =@reportTime,
                                        [operator]=@operator,
                                        [operatingDT]=Getdate()
                                 WHERE recordState=1 AND baseEventID=@baseEventID;";

            DbCommand dbEventcmd = db.GetSqlStringCommand(updatebaseEvent);
            //db.AddInParameter(dbEventcmd, "eventName", DbType.String, "药品不良事件-药品质量");
            db.AddInParameter(dbEventcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbEventcmd, "eOccurTime", DbType.String, ASPxTimeEditOccur.Value);
            db.AddInParameter(dbEventcmd, "eDiscoverTime", DbType.String, ASPxTimeEditDiscover.Value);
            db.AddInParameter(dbEventcmd, "eOccurDept", DbType.String, ASPxComboBoxPDept.Value);
            db.AddInParameter(dbEventcmd, "eOccurSite", DbType.String, ASPxComboBoxSite.Value);
            db.AddInParameter(dbEventcmd, "eventCategory", DbType.String, ASPxComboBoxEType.Value);
            if (ASPxTreeView1.SelectedNode != null)
            {
                db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, ASPxTreeView1.SelectedNode.Parent.Text + "—" + ASPxTreeView1.SelectedNode.Text);
            }
            else
            {
                db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, System.DBNull.Value);
            }
            db.AddInParameter(dbEventcmd, "eventDetails", DbType.String, ASPxMemoDetails.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "measures", DbType.String, ASPxMemoMeasures.Text.Trim().Replace(" ", ""));
            db.AddInParameter(dbEventcmd, "reportTime", DbType.String, ASPxTimeEditReport.Value);
            db.AddInParameter(dbEventcmd, "operator", DbType.String, loginUser.UserName);


            string updateMediEvent = @"UPDATE [AE_MediEventInfo]
                                       SET
                                       [YPSFFG]    =@YPSFFG,
                                       [HZSFSYYP]  =@HZSFSYYP,
                                       [TGXGZL]    =@TGXGZL 
                                 WHERE baseEventID=@baseEventID;";

            DbCommand dbMediEventcmd = db.GetSqlStringCommand(updateMediEvent);
            db.AddInParameter(dbMediEventcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbMediEventcmd, "YPSFFG", DbType.String, ASPxComboBoxYPSF.Value);
            db.AddInParameter(dbMediEventcmd, "HZSFSYYP", DbType.String, ASPxComboBoxHZSF.Value);
            db.AddInParameter(dbMediEventcmd, "TGXGZL", DbType.String, ASPxComboBoxYPCFZL.Value);

            string updatePatient = @"UPDATE [AE_PatientInfo]
                                    SET
                                    [hospitalID]          =@hospitalID, 
                                    [patientName]         =@patientName, 
                                    [patientSex]          =@patientSex, 
                                    [patientAge]          =@patientAge, 
                                    [jobTitle]            =@jobTitle,
                                    [pContact]            =@pContact,
                                    [clinicalDiagonse]    =@clinicalDiagonse,
                                    [nationality]         =@nationality
                             WHERE   baseEventID=@baseEventID;";


            DbCommand dbPatientcmd = db.GetSqlStringCommand(updatePatient);

            db.AddInParameter(dbPatientcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbPatientcmd, "hospitalID", DbType.String, ASPxTextBoxHID.Value);
            db.AddInParameter(dbPatientcmd, "patientName", DbType.String, ASPxTextBoxPName.Value);
            db.AddInParameter(dbPatientcmd, "patientSex", DbType.String, ASPxComboBoxSex.Value);
            db.AddInParameter(dbPatientcmd, "patientAge", DbType.String, ASPxTextBoxAge.Value);
            db.AddInParameter(dbPatientcmd, "jobTitle", DbType.String, ASPxTextBoxJob.Value);
            db.AddInParameter(dbPatientcmd, "pContact", DbType.String, ASPxTextBoxPContact.Value);
            db.AddInParameter(dbPatientcmd, "clinicalDiagonse", DbType.String, ASPxTextBoxCDia.Value);
            db.AddInParameter(dbPatientcmd, "nationality", DbType.String, ASPxTextBoxNa.Value);

            string updatePatientInjury = @"INSERT INTO [AE_PatientInjuryInfo]
                                           SET
                                           [RescueMeasure]       =@RescueMeasure,  
                                           [CJBWCD]              =@CJBWCD, 
                                           [ZSSHBWCD]            =@ZSSHBWCD, 
                                           [RecoveryProcedure]   =@RecoveryProcedure, 
                                           [CauseOfDeath]        =@CauseOfDeath, 
                                           [TimeOfDeath]         =@TimeOfDeath
                                     WHERE  baseEventID = @baseEventID;";

            DbCommand dbPatientInjuryCMD = db.GetSqlStringCommand(updatePatientInjury);
            db.AddInParameter(dbPatientInjuryCMD, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbPatientInjuryCMD, "RescueMeasure", DbType.String, ASPxTextBoxResMea.Value);
            db.AddInParameter(dbPatientInjuryCMD, "CJBWCD", DbType.String, ASPxTextBoxCJBW.Value);
            db.AddInParameter(dbPatientInjuryCMD, "ZSSHBWCD", DbType.String, ASPxTextBoxZSSH.Value);
            db.AddInParameter(dbPatientInjuryCMD, "RecoveryProcedure", DbType.String, ASPxTextBoxRecov.Value);
            db.AddInParameter(dbPatientInjuryCMD, "CauseOfDeath", DbType.String, ASPxTextBoxCauseD.Value);
            db.AddInParameter(dbPatientInjuryCMD, "TimeOfDeath", DbType.String, ASPxTimeEditDeath.Value);

            string updateReportor = @"UPDATE [AE_ReportorInfo]
                                    SET
                                    [rPersonCategory]  =@rPersonCategory,
                                    [rPostCategory]    =@rPostCategory,
                                    [rWorkYears]       =@rWorkYears,
                                    [rClinicalDept]    =@rClinicalDept,
                                    [rTechCategory]    =@rTechCategory,
                                    [rContact]         =@rContact

                             WHERE     baseEventID= @baseEventID;";
            //                                    [reportName]       =@reportName
            DbCommand dbReportorcmd = db.GetSqlStringCommand(updateReportor);
            db.AddInParameter(dbReportorcmd, "baseEventID", DbType.String,bEventID);
            db.AddInParameter(dbReportorcmd, "rPersonCategory", DbType.String, ASPxComboBoxPer.Value);
            db.AddInParameter(dbReportorcmd, "rPostCategory", DbType.String, ASPxComboBoxPost.Value);
            db.AddInParameter(dbReportorcmd, "rWorkYears", DbType.String, ASPxTextBoxWorkY.Value);
            db.AddInParameter(dbReportorcmd, "rClinicalDept", DbType.String, ASPxComboBoxRDept.Value);
            db.AddInParameter(dbReportorcmd, "rTechCategory", DbType.String, ASPxComboBoxTech.Value);
            db.AddInParameter(dbReportorcmd, "rContact", DbType.String, ASPxTextBoxrContact.Value);
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
                    db.ExecuteNonQuery(dbMediEventcmd, oneTrans);
                    db.ExecuteNonQuery(dbPatientcmd, oneTrans);
                    db.ExecuteNonQuery(dbPatientInjuryCMD, oneTrans);
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