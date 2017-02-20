using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;


namespace Project.WebUi.AdverseEvent
{
    public partial class QueryHLSJ : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxCheckBoxBL.Visible = false;
                ASPxTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-1).Date;
                ASPxTimeEditEnd.DateTime = System.DateTime.Now;
            }
        }

        protected void ASPxButtonQuery_Click(object sender, EventArgs e)
        {
            ASPxGridView1.DataBind();
            ASPxGridView2.DataBind();
        }

        protected void ASPxGridView1_BeforePerformDataSelect(object sender, EventArgs e)
        {
            if (ASPxComboBoxEventGrade.Text != "全部")
            {
                SqlDataSource1.SelectCommand = @"SELECT (select DeptName from Department where DeptID=eOccurDept) eOccurDeptName, b.baseEventID,b.eventName,b.eventGrade,b.eOccurTime,b.eOccurDept,b.reportTime
                                                            FROM  AE_ShareEventInfo b 
                                                            WHERE b.eventName IN ('护理不良事件-压疮','护理不良事件-输液反应','护理不良事件-跌倒/坠床','护理不良事件-坠床','护理不良事件-跌倒','护理不良事件-管路滑脱','护理不良事件-其他','压疮事件')
                                                            AND reportTime >= @startTime AND reportTime <= @endTime 
                                                            AND eventGrade LIKE @eventGrade 
                                                            AND AEflag=@AEflag
                                                            AND recordState=1
                                                            ORDER BY baseEventID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("eventGrade", ASPxComboBoxEventGrade.Value.ToString() + "%");
                SqlDataSource1.SelectParameters.Add("AEflag",System.Data.DbType.Boolean,ASPxCheckBoxBL.Checked.ToString());
                //SqlDataSource1.SelectParameters.Add("AEflag", System.Data.DbType.Boolean, "true");
            }
            else
            {
                SqlDataSource1.SelectCommand = @"SELECT (select DeptName from Department where DeptID=eOccurDept) eOccurDeptName, b.baseEventID,b.eventName,b.eventGrade,b.eOccurTime,b.eOccurDept,b.reportTime
                                                            FROM   AE_ShareEventInfo b 
                                                            WHERE  b.eventName IN ('护理不良事件-压疮','护理不良事件-输液反应','护理不良事件-跌倒/坠床','护理不良事件-坠床','护理不良事件-跌倒','护理不良事件-管路滑脱','护理不良事件-其他','压疮事件')
                                                            AND reportTime >= @startTime AND reportTime <= @endTime 
                                                            AND AEflag=@AEflag
                                                            AND recordState=1
                                                            ORDER BY baseEventID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("AEflag", System.Data.DbType.Boolean, ASPxCheckBoxBL.Checked.ToString());
            }
        }

        protected void ASPxGridView1_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            //SqlDataSource1.DeleteCommand = "DELETE FROM AE_ShareEventInfo WHERE baseEventID=" + e.Keys["baseEventID"].ToString();
            SqlDataSource1.DeleteCommand = "UPDATE AE_ShareEventInfo SET recordState = 0 WHERE baseEventID=" + e.Keys["baseEventID"].ToString() + " and recordState= 1 ";
        }

        protected void ASPxGridView1_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {

            e.Cancel = true ;
            string pageName =string.Empty;
            string [] paras = e.EditingKeyValue.ToString().Split('|') ;
            if (paras != null && paras.Length >= 2)
            {
                if (paras[1] == "护理不良事件-压疮")
                {
                    pageName = "EditHLYC.aspx";
                }
                if (paras[1] == "护理不良事件-管路滑脱")
                {
                    pageName = "EditHLGLHT.aspx";
                }
                if (paras[1] == "护理不良事件-跌倒/坠床")
                {
                    pageName = "EditHLDDZC.aspx";
                }
                if (paras[1] == "护理不良事件-坠床")
                {
                    pageName = "EditHLDDZC.aspx";
                }
                if (paras[1] == "护理不良事件-跌倒")
                {
                    pageName = "EditHLDDZC.aspx";
                }
                if (paras[1] == "护理不良事件-输液反应")
                {
                    pageName = "EditHLSYFY.aspx";
                }
                if (paras[1] == "护理不良事件-其他")
                {
                    pageName = "EditHLQT.aspx";
                }
                if (paras[1] == "压疮事件")
                {
                    pageName = "EditHLYC.aspx";
                }
            }
            else
            {
                return;
            }
            ASPxGridView1.JSProperties["cpPageUrl"] = string.Format("/{0}?baseEventID={1}", pageName, paras[0]);
        // Response.RedirectLocation=  string.Format("{0}?baseEventID={1}", pageName, paras[0]);
            //Response.Redirect(string.Format("{0}?baseEventID={1}", pageName, paras[0]));
        }

        protected void ASPxGridView2_BeforePerformDataSelect(object sender, EventArgs e)
        {
            if (ASPxComboBoxEventGrade.Text != "全部")
            {
                SqlDataSource2.SelectCommand = @"SELECT  b.baseEventID,a.dPostLevel,a.dWorkYears
                                                            FROM  AE_PartyInfo a LEFT JOIN  AE_ShareEventInfo b ON a.baseEventID= b.baseEventID 
                                                            WHERE b.eventName IN ('护理不良事件-压疮','护理不良事件-输液反应','护理不良事件-跌倒/坠床','护理不良事件-管路滑脱','护理不良事件-其他','压疮事件')
                                                            AND reportTime >= @startTime AND reportTime <= @endTime 
                                                            AND eventGrade LIKE @eventGrade 
                                                            AND AEflag=@AEflag
                                                            ORDER BY baseEventID";
                SqlDataSource2.SelectParameters.Clear();
                SqlDataSource2.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource2.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource2.SelectParameters.Add("eventGrade", ASPxComboBoxEventGrade.Value.ToString() + "%");
                SqlDataSource2.SelectParameters.Add("AEflag", System.Data.DbType.Boolean, ASPxCheckBoxBL.Checked.ToString());
            }
            else
            {
                SqlDataSource2.SelectCommand = @"SELECT  b.baseEventID,a.dPostLevel,a.dWorkYears
                                                            FROM  AE_PartyInfo a LEFT JOIN  AE_ShareEventInfo b ON a.baseEventID= b.baseEventID 
                                                            WHERE  b.eventName IN ('护理不良事件-压疮','护理不良事件-输液反应','护理不良事件-跌倒/坠床','护理不良事件-管路滑脱','护理不良事件-其他','压疮事件')
                                                            AND reportTime >= @startTime AND reportTime <= @endTime 
                                                            AND AEflag=@AEflag
                                                            ORDER BY baseEventID";
                SqlDataSource2.SelectParameters.Clear();
                SqlDataSource2.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource2.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource2.SelectParameters.Add("AEflag", System.Data.DbType.Boolean, ASPxCheckBoxBL.Checked.ToString());
            }
        }
    }
}