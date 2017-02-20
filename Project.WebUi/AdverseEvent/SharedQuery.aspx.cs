using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.WebUi.App_Code;

namespace Project.WebUi.AdverseEvent
{
    public partial class SharedQuery : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxTimeEditStart.DateTime = System.DateTime.Now.AddMonths(-1).Date;
                ASPxTimeEditEnd.DateTime = System.DateTime.Now;
                //string ss = "2014年3月18日09：30，护士赵   彩云在病房为12床患者铺床时，13床患者冯世壁(14014206前列腺增生)对赵彩云说：“护士，我输液的手有点疼。”赵彩云经过观察发现穿刺处明显隆起，液体外渗，便为其拔掉穿刺针，嘱其按压。（液体为生理盐水100ｍL加注射用头孢美唑纳1 克）她用胶布将针头固定在茂菲氏滴管上，在固定的过程中不小心手指被针头扎破。";
                //string dd = "      立即查看患者，患者子宫收缩好，阴道出血不多，向患者解释，立即继续进行中频脉冲电治疗，促进子宫复旧。";
                
                //string res = ss.Trim().Replace(Environment.NewLine,"");
                //res = ss.Trim().Replace(" ", "");
                //res = ss.Trim().Replace(" ", "");
                //string dres = dd.Trim();
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
                SqlDataSource1.SelectCommand = "SELECT (select DeptName from Department where DeptID=eOccurDept) eOccurDept,a.*,b.rClinicalDept FROM [AE_ShareEventInfo] a LEFT JOIN  AE_ReportorInfo b ON a.baseEventID= b.baseEventID  WHERE b.rClinicalDept =@rClinicalDept AND AEflag=@AEflag AND reportTime >= @startTime AND reportTime <= @endTime  AND eventGrade LIKE @eventGrade AND recordState=1 ORDER BY baseEventID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("eventGrade", ASPxComboBoxEventGrade.Value.ToString() + "%");
                SqlDataSource1.SelectParameters.Add("rClinicalDept", loginUser.DeptId);
                
                SqlDataSource1.SelectParameters.Add("AEflag", System.Data.DbType.Boolean, "true");
            }
            else
            {
                SqlDataSource1.SelectCommand = "SELECT (select DeptName from Department where DeptID=eOccurDept) eOccurDept,a.* ,(select DeptName from Department where DeptID=rClinicalDept) rClinicalDept FROM [AE_ShareEventInfo] a LEFT JOIN  AE_ReportorInfo b ON a.baseEventID= b.baseEventID  WHERE  b.rClinicalDept =@rClinicalDept AND AEflag=@AEflag AND reportTime >= @startTime AND reportTime <= @endTime AND recordState=1 ORDER BY baseEventID ";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startTime", ASPxTimeEditStart.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("endTime", ASPxTimeEditEnd.DateTime.ToString());
                SqlDataSource1.SelectParameters.Add("rClinicalDept", loginUser.DeptId);
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