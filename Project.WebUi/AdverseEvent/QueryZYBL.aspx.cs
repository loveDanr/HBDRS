using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class QueryZYBL : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-1).Date;
                ASPxTimeEditEnd.DateTime = System.DateTime.Now;
            }
        }

        protected void ASPxButtonQuery_Click(object sender, EventArgs e)
        {
            ASPxGridView1.DataBind();
        }

        protected void ASPxGridView1_BeforePerformDataSelect(object sender, EventArgs e)
        {
            if (ASPxComboBoxEventGrade.Text != "全部")
            {
                SqlDataSource1.SelectCommand = @"SELECT a.baseEventID,eventName,JB_Name,(select DeptName from Department where DeptID=JB_KS) JB_KS,JB_GZNX,JB_GWLB,JB_BLSJ,JB_BLDD,BLFS_QX_LX,BLFS_JC_BW,BLFS_QX_SSCD,BLFS_GLCZ,BLY_HZBQ,BLH_PF_XY ,b.reportTime
                                                            FROM  AE_ZYBL a , AE_ShareEventInfo b 
                                                            WHERE a.baseEventID= b.baseEventID AND JB_BLSJ >= @startTime AND JB_BLSJ <= @endTime 
                                                            AND eventGrade LIKE @eventGrade 
                                                            AND recordState=1
                                                            ORDER BY baseEventID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("eventGrade", ASPxComboBoxEventGrade.Value.ToString() + "%");
            }
            else
            {
                SqlDataSource1.SelectCommand = @"SELECT a.baseEventID,eventName,JB_Name,(select DeptName from Department where DeptID=JB_KS)  JB_KS,JB_GZNX,JB_GWLB,JB_BLSJ,JB_BLDD,BLFS_QX_LX,BLFS_JC_BW,BLFS_QX_SSCD,BLFS_GLCZ,BLY_HZBQ,BLH_PF_XY ,b.reportTime
                                                            FROM  AE_ZYBL a , AE_ShareEventInfo b 
                                                            WHERE a.baseEventID= b.baseEventID AND JB_BLSJ >= @startTime AND JB_BLSJ <= @endTime 
                                                            AND recordState=1
                                                            ORDER BY baseEventID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
            }
        }

        protected void ASPxGridView1_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            //SqlDataSource1.DeleteCommand = "DELETE FROM AE_ShareEventInfo WHERE baseEventID=" + e.Keys["baseEventID"].ToString();
            SqlDataSource1.DeleteCommand = "UPDATE AE_ShareEventInfo SET recordState = 0 WHERE baseEventID=" + e.Keys["baseEventID"].ToString() + " and recordState= 1 ";

        }
        protected void ASPxGridView1_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            e.Cancel = true;
            string pageName = string.Empty;
            string[] paras = e.EditingKeyValue.ToString().Split('|');
            if (paras != null && paras.Length >= 2)
            {
                if (paras[1] == "职业暴露" || paras[1] == "职业暴露-阴性" || paras[1] == "职业暴露-阳性")
                {
                    pageName = "EditZYBL.aspx";
                }
            }
            else
            {
                return;
            }
            ASPxGridView1.JSProperties["cpPageUrl"] = string.Format("/{0}?baseEventID={1}&name={2}", pageName, paras[0],paras[1]);
        }
    }
}