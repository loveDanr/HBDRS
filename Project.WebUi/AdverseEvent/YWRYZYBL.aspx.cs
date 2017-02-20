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
    public partial class YWRYZYBL : MyBasePage
    {
        private static readonly SqlDatabase db = EnterpriseLibraryContainer.Current.GetInstance<SqlDatabase>("SQLConnString");
        private object bEventID = null;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxTreeView1.ExpandAll();
            if (!IsPostBack)
            {
                teBLH_PF_CXSJ.Value = "00:00";
                teJB_JZSJ.Value = DateTime.Now;
                teJB_BLSJ.Value = DateTime.Now;
                ASPxTimeEditReport.Value = DateTime.Now;
            }

        }


        protected void cp_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {

            //保存成功标志
            bool resflag = false;


            string insertbaseEvent = @"INSERT INTO [AE_ShareEventInfo]
                                       (
                                        [eventName]
                                       ,[eventCategory]
                                       ,[eventGrade]
                                       ,[eventDetails]
                                       ,[reportTime]
                                        ,[operator]
                                        ,[operatingDT])
                                 VALUES
                                       (
                                       @eventName, 
                                       @eventCategory, 
                                       @eventGrade, 
                                       @eventDetails, 
                                       @reportTime,
                                        @operator,
                                       Getdate());
                                    SELECT SCOPE_IDENTITY()";

            DbCommand dbEventcmd = db.GetSqlStringCommand(insertbaseEvent);
            db.AddInParameter(dbEventcmd, "eventName", DbType.String, "职业暴露-阳性");
            db.AddInParameter(dbEventcmd, "eventCategory", DbType.String, ASPxComboBoxEType.Value);
            //db.AddInParameter(dbEventcmd, "eventGrade", DbType.String, ASPxRadioButtonList1.Value);
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
            db.AddInParameter(dbEventcmd, "operator", DbType.String, loginUser.UserName);

            string insertzyblEvent = @"INSERT INTO [AE_ZYBL]
                                       (baseEventID
                                       ,[JB_Name]
                                       ,[JB_Sex]
                                       ,[JB_Age]
                                       ,[JB_LXFS]
                                       ,[JB_KS]
                                       ,[JB_GWLB]
                                       ,[JB_RYLB]
                                       ,[JB_JSLB]
                                       ,[JB_GZNX]
                                       ,[JB_BLSJ]
                                       ,[JB_BLDD]
                                       ,[JB_CSHD]
                                       ,[JB_JSPX]
                                       ,[JB_JZYM]
                                       ,[JB_YMMC]
                                       ,[JB_JZSJ]
                                       ,[JB_KTCS]
                                       ,[JB_XXGR]
                                       ,[JB_JSZL]
                                       ,[JB_CLBF]
                                       ,[JB_BHCS]
                                       ,[JB_ST]
                                       ,[BLFS_JC_PF]
                                       ,[BLFS_JC_BW]
                                       ,[BLFS_JC_JCMJ]
                                       ,[BLFS_JC_BLSJ]
                                       ,[BLFS_JC_WRWLY]
                                       ,[BLFS_QX_LX]
                                       ,[BLFS_QX_SSCD]
                                       ,[BLFS_QX_WRWLY]
                                       ,[BLFS_QT_PSCX]
                                       ,[BLFS_GLCZ]
                                       ,[BLY_HZXM]
                                       ,[BLY_HZZYH]
                                       ,[BLY_HZKS]
                                       ,[BLY_WZZGRZ]
                                       ,[BLY_HZBQ]
                                       ,[BLY_BDZL]
                                       ,[BLY_CD4]
                                       ,[BLY_BB_HZXM]
                                       ,[BLY_BB_HZZYH]
                                       ,[BLY_BB_TY]
                                       ,[BLY_BB_BDZL]
                                       ,[HBV]
                                       ,[HCV]
                                       ,[HIV]
                                       ,[BLH_PF_QSCX]
                                       ,[BLH_PF_FZ]
                                       ,[BLH_PF_XY]
                                       ,[BLH_PF_XDJMC]
                                       ,[BLH_PF_CXSJ]
                                       ,[BLH_PF_CXRY]
                                       ,[BLH_BZ])
                                 VALUES
                                       (@baseEventID,
                                       @JB_Name, 
                                       @JB_Sex, 
                                       @JB_Age, 
                                       @JB_LXFS,
                                       @JB_KS, 
                                       @JB_GWLB, 
                                       @JB_RYLB, 
                                       @JB_JSLB, 
                                       @JB_GZNX, 
                                       @JB_BLSJ, 
                                       @JB_BLDD, 
                                       @JB_CSHD, 
                                       @JB_JSPX, 
                                       @JB_JZYM, 
                                       @JB_YMMC, 
                                       @JB_JZSJ, 
                                       @JB_KTCS, 
                                       @JB_XXGR, 
                                       @JB_JSZL, 
                                       @JB_CLBF, 
                                       @JB_BHCS,
                                       @JB_ST,
                                       @BLFS_JC_PF, 
                                       @BLFS_JC_BW, 
                                       @BLFS_JC_JCMJ, 
                                       @BLFS_JC_BLSJ, 
                                       @BLFS_JC_WRWLY, 
                                       @BLFS_QX_LX, 
                                       @BLFS_QX_SSCD, 
                                       @BLFS_QX_WRWLY, 
                                       @BLFS_QT_PSCX, 
                                       @BLFS_GLCZ, 
                                       @BLY_HZXM, 
                                       @BLY_HZZYH, 
                                       @BLY_HZKS, 
                                       @BLY_WZZGRZ, 
                                       @BLY_HZBQ, 
                                       @BLY_BDZL, 
                                       @BLY_CD4, 
                                       @BLY_BB_HZXM, 
                                       @BLY_BB_HZZYH, 
                                       @BLY_BB_TY,
                                       @BLY_BB_BDZL, 
                                       @HBV, 
                                       @HCV, 
                                       @HIV, 
                                       @BLH_PF_QSCX, 
                                       @BLH_PF_FZ, 
                                       @BLH_PF_XY, 
                                       @BLH_PF_XDJMC, 
                                       @BLH_PF_CXSJ, 
                                       @BLH_PF_CXRY,
                                       @BLH_BZ )";

            DbCommand dbzyblEventcmd = db.GetSqlStringCommand(insertzyblEvent);
            db.AddInParameter(dbzyblEventcmd, "baseEventID", DbType.String);
            db.AddInParameter(dbzyblEventcmd, "JB_Name", DbType.String, txtJB_Name.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_Sex", DbType.String, cboJB_Sex.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_Age", DbType.String, txtJB_Age.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_LXFS", DbType.String, txtJB_LXFS.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_KS", DbType.String, cboJB_KS.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_GWLB", DbType.String, cboJB_GWLB.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_RYLB", DbType.String, cboJB_RYLB.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_JSLB", DbType.String, cboJB_JSLB.Value);
            db.AddInParameter(dbzyblEventcmd, "JB_GZNX", DbType.String, txtJB_GZNX.Value.ToString() + ASPxComboBoxGZNX.Value.ToString());
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
            db.AddInParameter(dbReportorcmd, "rPersonCategory", DbType.String, cborPersonCategory.Value);
            db.AddInParameter(dbReportorcmd, "rPostCategory", DbType.String, cborPostCategory.Value);
            db.AddInParameter(dbReportorcmd, "rWorkYears", DbType.String, txtrWorkYears.Value.ToString()+ASPxComboBoxDW.Value.ToString());
            db.AddInParameter(dbReportorcmd, "rClinicalDept", DbType.String, cborClinicalDept.Value);
            db.AddInParameter(dbReportorcmd, "rTechCategory", DbType.String, cborTechCategory.Value);
            db.AddInParameter(dbReportorcmd, "reportName", DbType.String, loginUser.UserName);

            using (DbConnection oneConn = db.CreateConnection())
            {
                oneConn.Open();
                DbTransaction oneTrans = oneConn.BeginTransaction();
                try
                {
                    bEventID = db.ExecuteScalar(dbEventcmd, oneTrans);


                    dbzyblEventcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteScalar(dbzyblEventcmd, oneTrans);
                    dbReportorcmd.Parameters["@baseEventID"].Value = bEventID;
                    db.ExecuteNonQuery(dbReportorcmd, oneTrans);
                    
                    oneTrans.Commit();
                    //oneTrans.Rollback();
                    resflag = true;

                }
                catch(Exception ex)
                {
                    oneTrans.Rollback();
                    resflag = false;
                    cp.JSProperties["cpSaveFlag"] = ex.Message;
                }

                oneConn.Close();
            }

            if (resflag)
            {
                cp.JSProperties["cpSaveFlag"] = "提交成功";
            }

        }

    }
}