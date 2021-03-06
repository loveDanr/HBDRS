﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class QueryEvents : MyBasePage
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
                SqlDataSource1.SelectCommand = "SELECT (select DeptName from Department where DeptID=eOccurDept) eOccurDeptName,* FROM [AE_ShareEventInfo] WHERE reportTime >= @startTime AND reportTime <= @endTime AND AEflag=@AEflag AND recordState=1 AND eventGrade LIKE @eventGrade ORDER BY baseEventID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("eventGrade", ASPxComboBoxEventGrade.Value.ToString()+"%");
                SqlDataSource1.SelectParameters.Add("AEflag", System.Data.DbType.Boolean, "true");
            }
            else
            {
                SqlDataSource1.SelectCommand = "SELECT (select DeptName from Department where DeptID=eOccurDept) eOccurDeptName,* FROM [AE_ShareEventInfo] WHERE reportTime >= @startTime AND AEflag=@AEflag AND recordState=1 AND reportTime <= @endTime  ORDER BY baseEventID ";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("AEflag", System.Data.DbType.Boolean, "true");
            }
        }

        protected void ASPxGridView1_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            //SqlDataSource1.DeleteCommand = "DELETE FROM AE_ShareEventInfo WHERE baseEventID=" + e.Keys["baseEventID"].ToString();
            SqlDataSource1.DeleteCommand = "UPDATE AE_ShareEventInfo SET recordState = 0 WHERE baseEventID=" + e.Keys["baseEventID"].ToString() + " and recordState= 1 ";
        }

        protected void ASPxGridView1_HeaderFilterFillItems(object sender, DevExpress.Web.ASPxGridViewHeaderFilterEventArgs e)
        {
            if (e.Column.FieldName != "eventGrade") return;
            e.Values.Clear();
            e.AddShowAll();
            e.AddValue("Ⅰ级事件（警训事件）", string.Empty, "[eventGrade] LIKE 'Ⅰ级事件（警训事件）%'");
            e.AddValue("Ⅱ级事件（不良后果事件）", string.Empty, "[eventGrade] LIKE 'Ⅱ级事件（不良后果事件）%'");
            e.AddValue("Ⅲ级事件（未造成后果事件）", string.Empty, "[eventGrade] LIKE 'Ⅲ级事件（未造成后果事件）%'");
            e.AddValue("Ⅳ级事件（临界错误事件）", string.Empty, "[eventGrade] LIKE 'Ⅳ级事件（临界错误事件）%'");
            e.Values[0].DisplayText = "(全部)";

        }
    }
}