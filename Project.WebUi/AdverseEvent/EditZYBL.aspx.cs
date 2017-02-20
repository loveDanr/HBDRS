using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using System.Data.Common;
using System.Data;
using DevExpress.Web;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class EditZYBL : MyBasePage
    {
        private static readonly SqlDatabase db = EnterpriseLibraryContainer.Current.GetInstance<SqlDatabase>("SQLConnString");

        private object bEventID = null;
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
            string selectSql = "BEGIN SELECT * FROM AE_ZYBL WHERE baseEventID = @baseEventID" +
                " SELECT [eventCategory],[eventGrade],[eventDetails],[reportTime] FROM AE_ShareEventInfo WHERE  [recordState]=1 AND baseEventID = @baseEventID;" +
                " SELECT [rPersonCategory],[rPostCategory],[rWorkYears],[rClinicalDept],[rTechCategory] FROM AE_ReportorInfo WHERE  baseEventID = @baseEventID;" +
                " END;";

            DbCommand queryEventcmd = db.GetSqlStringCommand(selectSql);
            db.AddInParameter(queryEventcmd, "baseEventID", DbType.String, bEventID);
            DataRow dr = db.ExecuteDataSet(queryEventcmd).Tables[0].Rows[0];
            if (dr != null)
            {
                txtJB_Name.Value = dr["JB_Name"];
                cboJB_Sex.Value = dr["JB_Sex"];
                txtJB_Age.Value = dr["JB_Age"];
                cboJB_KS.Value = dr["JB_KS"];
                cboJB_GWLB.Value = dr["JB_GWLB"];
                cboJB_RYLB.Value = dr["JB_RYLB"];
                cboJB_JSLB.Value = dr["JB_JSLB"];
                txtJB_GZNX.Value = dr["JB_GZNX"];
                teJB_BLSJ.Value = dr["JB_BLSJ"];
                cboJB_BLDD.Value = dr["JB_BLDD"];
                cboJB_CSHD.Value = dr["JB_CSHD"];
                cboJB_JSPX.Value = dr["JB_JSPX"];
                cboJB_JZYM.Value = dr["JB_JZYM"];
                cboJB_YMMC.Value = dr["JB_YMMC"];
                teJB_JZSJ.Value = dr["JB_JZSJ"];
                cboJB_KTCS.Value = dr["JB_KTCS"];
                cboJB_XXGR.Value = dr["JB_XXGR"];
                cboJB_JSZL.Value = dr["JB_JSZL"];
                cboJB_CLBF.Value = dr["JB_CLBF"];
                cboJB_BHCS.Value = dr["JB_BHCS"];
                cboJB_ST.Value = dr["JB_ST"];
                cboBLFS_JC_PF.Value = dr["BLFS_JC_PF"];
                txtBLFS_JC_BW.Value = dr["BLFS_JC_BW"];
                txtBLFS_JC_JCMJ.Value = dr["BLFS_JC_JCMJ"];
                cboBLFS_JC_BLSJ.Value = dr["BLFS_JC_BLSJ"];
                cboBLFS_JC_WRWLY.Value = dr["BLFS_JC_WRWLY"];
                cboBLFS_QX_LX.Value = dr["BLFS_QX_LX"];
                cboBLFS_QX_SSCD.Value = dr["BLFS_QX_SSCD"];
                cboBLFS_QX_WRWLY.Value = dr["BLFS_QX_WRWLY"];
                cboBLFS_QT_PSCX.Value = dr["BLFS_QT_PSCX"];
                cboBLFS_GLCZ.Value = dr["BLFS_GLCZ"];
                txtBLY_HZXM.Value = dr["BLY_HZXM"];
                txtBLY_HZZYH.Value = dr["BLY_HZZYH"];
                cboBLY_HZKS.Value = dr["BLY_HZKS"];
                cboBLY_WZZGRZ.Value = dr["BLY_WZZGRZ"];
                cboBLY_HZBQ.Value = dr["BLY_HZBQ"];
                txtBLY_BDZL.Value = dr["BLY_BDZL"];
                txtBLY_CD4.Value = dr["BLY_CD4"];
                txtBLY_BB_HZXM.Value = dr["BLY_BB_HZXM"];
                txtBLY_BB_HZZYH.Value = dr["BLY_BB_HZZYH"];
                cboBLY_BB_TY.Value = dr["BLY_BB_TY"];
                txtBLY_BB_BDZL.Value = dr["BLY_BB_BDZL"];
                cboHBV.Value = dr["HBV"];
                cboHCV.Value = dr["HCV"];
                cboHIV.Value = dr["HIV"];
                cboBLH_PF_QSCX.Value = dr["BLH_PF_QSCX"];
                cboBLH_PF_FZ.Value = dr["BLH_PF_FZ"];
                cboBLH_PF_XY.Value = dr["BLH_PF_XY"];
                txtBLH_PF_XDJMC.Value = dr["BLH_PF_XDJMC"];
                //teBLH_PF_CXSJ.Value = dr["BLH_PF_CXSJ"];
                //TimeSpan ts =  teBLH_PF_CXSJ.Value  as TimeSpan;
                teBLH_PF_CXSJ.DateTime = DateTime.Parse(dr["BLH_PF_CXSJ"].ToString());
                cboBLH_PF_CXRY.Value = dr["BLH_PF_CXRY"];
                ASPxMemoBLH_BZ.Value = dr["BLH_BZ"];
            }
            dr = db.ExecuteDataSet(queryEventcmd).Tables[1].Rows[0];
            if (dr != null)
            {
                ASPxTimeEditReport.Value = dr["reportTime"];
                ASPxComboBoxEType.Value = dr["eventCategory"];
                ASPxMemoDetails.Value = dr["eventDetails"];
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
            dr = db.ExecuteDataSet(queryEventcmd).Tables[2].Rows[0];
            if (dr != null)
            {
                cborClinicalDept.Value = dr["rClinicalDept"];
                cborPostCategory.Value = dr["rPostCategory"];
                cborPersonCategory.Value = dr["rPersonCategory"];
                cborTechCategory.Value = dr["rTechCategory"];
                txtrWorkYears.Value = dr["rWorkYears"];
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

            string updateBaseEvent = @"UPDATE [AE_ShareEventInfo]
                                        SET [eventCategory]=@eventCategory
                                       ,[eventGrade] =@eventGrade
                                       ,[eventDetails] =@eventDetails
                                       ,[reportTime] =@reportTime  
                                WHERE [recordState]=1 AND baseEventID=@baseEventID";

            DbCommand dbEventcmd = db.GetSqlStringCommand(updateBaseEvent);
            db.AddInParameter(dbEventcmd, "baseEventID", DbType.String, bEventID);
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
            db.AddInParameter(dbEventcmd, "reportTime", DbType.String, ASPxTimeEditReport.Value);

            string insertzyblEvent = @"UPDATE [AE_ZYBL]
                                       SET
                                        [JB_Name]          =@JB_Name, 
                                        [JB_Sex]           =@JB_Sex, 
                                        [JB_Age]           =@JB_Age, 
                                        [JB_KS]            =@JB_KS, 
                                        [JB_GWLB]          =@JB_GWLB, 
                                        [JB_RYLB]          =@JB_RYLB, 
                                        [JB_JSLB]          =@JB_JSLB, 
                                        [JB_GZNX]          =@JB_GZNX, 
                                        [JB_BLSJ]          =@JB_BLSJ, 
                                        [JB_BLDD]          =@JB_BLDD, 
                                        [JB_CSHD]          =@JB_CSHD, 
                                        [JB_JSPX]          =@JB_JSPX, 
                                        [JB_JZYM]          =@JB_JZYM, 
                                        [JB_YMMC]          =@JB_YMMC, 
                                        [JB_JZSJ]          =@JB_JZSJ, 
                                        [JB_KTCS]          =@JB_KTCS, 
                                        [JB_XXGR]          =@JB_XXGR, 
                                        [JB_JSZL]          =@JB_JSZL, 
                                        [JB_CLBF]          =@JB_CLBF, 
                                        [JB_BHCS]          =@JB_BHCS,
                                        [JB_ST]            =@JB_ST,
                                        [BLFS_JC_PF]       =@BLFS_JC_PF, 
                                        [BLFS_JC_BW]       =@BLFS_JC_BW, 
                                        [BLFS_JC_JCMJ]     =@BLFS_JC_JCMJ, 
                                        [BLFS_JC_BLSJ]     =@BLFS_JC_BLSJ, 
                                        [BLFS_JC_WRWLY]    =@BLFS_JC_WRWLY, 
                                        [BLFS_QX_LX]       =@BLFS_QX_LX, 
                                        [BLFS_QX_SSCD]     =@BLFS_QX_SSCD, 
                                        [BLFS_QX_WRWLY]    =@BLFS_QX_WRWLY, 
                                        [BLFS_QT_PSCX]     =@BLFS_QT_PSCX, 
                                        [BLFS_GLCZ]        =@BLFS_GLCZ, 
                                        [BLY_HZXM]         =@BLY_HZXM, 
                                        [BLY_HZZYH]        =@BLY_HZZYH, 
                                        [BLY_HZKS]         =@BLY_HZKS, 
                                        [BLY_WZZGRZ]       =@BLY_WZZGRZ, 
                                        [BLY_HZBQ]         =@BLY_HZBQ, 
                                        [BLY_BDZL]         =@BLY_BDZL, 
                                        [BLY_CD4]          =@BLY_CD4, 
                                        [BLY_BB_HZXM]      =@BLY_BB_HZXM, 
                                        [BLY_BB_HZZYH]     =@BLY_BB_HZZYH, 
                                        [BLY_BB_TY]        =@BLY_BB_TY,
                                        [BLY_BB_BDZL]      =@BLY_BB_BDZL, 
                                        [HBV]              =@HBV, 
                                        [HCV]              =@HCV, 
                                        [HIV]              =@HIV, 
                                        [BLH_PF_QSCX]      =@BLH_PF_QSCX, 
                                        [BLH_PF_FZ]        =@BLH_PF_FZ, 
                                        [BLH_PF_XY]        =@BLH_PF_XY, 
                                        [BLH_PF_XDJMC]     =@BLH_PF_XDJMC, 
                                        [BLH_PF_CXSJ]      =@BLH_PF_CXSJ, 
                                        [BLH_PF_CXRY]      =@BLH_PF_CXRY,
                                        [BLH_BZ]           =@BLH_BZ           
                                WHERE baseEventID =@baseEventID";

            DbCommand dbzyblEventcmd = db.GetSqlStringCommand(insertzyblEvent);
            db.AddInParameter(dbzyblEventcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbzyblEventcmd, "JB_Name", DbType.String, txtJB_Name.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_Sex", DbType.String, cboJB_Sex.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_Age", DbType.String, txtJB_Age.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_KS", DbType.String, cboJB_KS.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_GWLB", DbType.String, cboJB_GWLB.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_RYLB", DbType.String, cboJB_RYLB.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_JSLB", DbType.String, cboJB_JSLB.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_GZNX", DbType.String, txtJB_GZNX.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_BLSJ", DbType.String, teJB_BLSJ.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_BLDD", DbType.String, cboJB_BLDD.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_CSHD", DbType.String, cboJB_CSHD.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_JSPX", DbType.String, cboJB_JSPX.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_JZYM", DbType.String, cboJB_JZYM.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_YMMC", DbType.String, cboJB_YMMC.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_JZSJ", DbType.String, teJB_JZSJ.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_KTCS", DbType.String, cboJB_KTCS.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_XXGR", DbType.String, cboJB_XXGR.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_JSZL", DbType.String, cboJB_JSZL.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_CLBF", DbType.String, cboJB_CLBF.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_BHCS", DbType.String, cboJB_BHCS.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_ST", DbType.String, cboJB_ST.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_JC_PF", DbType.String, cboBLFS_JC_PF.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_JC_BW", DbType.String, txtBLFS_JC_BW.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_JC_JCMJ", DbType.String, txtBLFS_JC_JCMJ.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_JC_BLSJ", DbType.String, cboBLFS_JC_BLSJ.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_JC_WRWLY", DbType.String, cboBLFS_JC_WRWLY.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_QX_LX", DbType.String, cboBLFS_QX_LX.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_QX_SSCD", DbType.String, cboBLFS_QX_SSCD.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_QX_WRWLY", DbType.String, cboBLFS_QX_WRWLY.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_QT_PSCX", DbType.String, cboBLFS_QT_PSCX.Value);
            db.AddInParameter(dbzyblEventcmd, "BLFS_GLCZ", DbType.String, cboBLFS_GLCZ.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_HZXM", DbType.String, txtBLY_HZXM.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_HZZYH", DbType.String, txtBLY_HZZYH.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_HZKS", DbType.String, cboBLY_HZKS.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_WZZGRZ", DbType.String, cboBLY_WZZGRZ.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_HZBQ", DbType.String, cboBLY_HZBQ.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_BDZL", DbType.String, txtBLY_BDZL.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_CD4", DbType.String, txtBLY_CD4.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_BB_HZXM", DbType.String, txtBLY_BB_HZXM.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_BB_HZZYH", DbType.String, txtBLY_BB_HZZYH.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_BB_TY", DbType.String, cboBLY_BB_TY.Value);
            db.AddInParameter(dbzyblEventcmd, "BLY_BB_BDZL", DbType.String, txtBLY_BB_BDZL.Value);
            db.AddInParameter(dbzyblEventcmd, "HBV", DbType.String, cboHBV.Value);
            db.AddInParameter(dbzyblEventcmd, "HCV", DbType.String, cboHCV.Value);
            db.AddInParameter(dbzyblEventcmd, "HIV", DbType.String, cboHIV.Value);
            db.AddInParameter(dbzyblEventcmd, "BLH_PF_QSCX", DbType.String, cboBLH_PF_QSCX.Value);
            db.AddInParameter(dbzyblEventcmd, "BLH_PF_FZ", DbType.String, cboBLH_PF_FZ.Value);
            db.AddInParameter(dbzyblEventcmd, "BLH_PF_XY", DbType.String, cboBLH_PF_XY.Value);
            db.AddInParameter(dbzyblEventcmd, "BLH_PF_XDJMC", DbType.String, txtBLH_PF_XDJMC.Value);
            db.AddInParameter(dbzyblEventcmd, "BLH_PF_CXSJ", DbType.String, teBLH_PF_CXSJ.Value);
            db.AddInParameter(dbzyblEventcmd, "BLH_PF_CXRY", DbType.String, cboBLH_PF_CXRY.Value);
            db.AddInParameter(dbzyblEventcmd, "BLH_BZ", DbType.String, ASPxMemoBLH_BZ.Value);

            string updateReportor = @"UPDATE [AE_ReportorInfo]                                    
                                    SET [rPersonCategory]  =@rPersonCategory
                                   ,[rPostCategory]    =@rPostCategory
                                   ,[rWorkYears]       =@rWorkYears
                                   ,[rClinicalDept]    =@rClinicalDept
                                   ,[rTechCategory]    =@rTechCategory

                              WHERE baseEventID=@baseEventID";
            //                                   ,[reportName]       =@reportName
            DbCommand dbReportorcmd = db.GetSqlStringCommand(updateReportor);
            db.AddInParameter(dbReportorcmd, "baseEventID", DbType.String, bEventID);
            db.AddInParameter(dbReportorcmd, "rPersonCategory", DbType.String, cborPersonCategory.Value);
            db.AddInParameter(dbReportorcmd, "rPostCategory", DbType.String, cborPostCategory.Value);
            db.AddInParameter(dbReportorcmd, "rWorkYears", DbType.String, txtrWorkYears.Value);
            db.AddInParameter(dbReportorcmd, "rClinicalDept", DbType.String, cborClinicalDept.Value);
            db.AddInParameter(dbReportorcmd, "rTechCategory", DbType.String, cborTechCategory.Value);
            //db.AddInParameter(dbReportorcmd, "reportName", DbType.String, new UserCache().UserName);

            using (DbConnection oneConn = db.CreateConnection())
            {
                oneConn.Open();
                DbTransaction oneTrans = oneConn.BeginTransaction();
                try
                {
                    db.ExecuteNonQuery(dbEventcmdLOG, oneTrans);
                    db.ExecuteNonQuery(dbEventcmd, oneTrans);
                    db.ExecuteNonQuery(dbzyblEventcmd, oneTrans);
                    db.ExecuteNonQuery(dbReportorcmd, oneTrans);

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
            }
            else
            {
                cp.JSProperties["cpSaveFlag"] = false;
            }
        }

    }
}