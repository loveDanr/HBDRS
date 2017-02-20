using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.GRKHJJC
{
    public partial class ProgramsMiss : Project.WebUi.App_Code.MyBasePage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = @"SELECT MonitoredDeptName,MonitorProgramName,DeptID,resCount,resCount-MonitorFrequencyValue diff,CONVERT(NVARCHAR(2),MonitorFrequencyValue)+MonitorFrequencyUnit MonitorFrequencyASK FROM 
(
SELECT 
       MonitoredDeptID
	  ,(SELECT MonitoredDeptName FROM GRK_MonitoredDept WHERE MonitoredDeptID  = a.[MonitoredDeptID]) MonitoredDeptName
      ,(SELECT MonitorFrequencyValue  FROM GRK_MonitorFrequency WHERE MonitorFrequencyID=a.MonitorFrequencyID) MonitorFrequencyValue
      ,(SELECT MonitorFrequencyUnit  FROM GRK_MonitorFrequency WHERE MonitorFrequencyID=a.MonitorFrequencyID) MonitorFrequencyUnit
      ,(SELECT MonitorProgramName FROM GRK_MonitorProgram WHERE MonitorProgramID=a.MonitorProgramID) MonitorProgramName
      ,(SELECT 
      (SELECT ReportCateCode FROM GRK_ReportCategory WHERE ReportCateID=c.ReportCateID)  ReportCateCode
      FROM GRK_MonitorProgram c WHERE MonitorProgramID=a.MonitorProgramID) ReportCateCode
  FROM [GRK_DeptProgram] a
  WHERE a.MonitorProgramID IN (SELECT
      Sum(MonitorProgramID)
  FROM [GRK_MonitorProgram]
  GROUP BY ReportCateID HAVING COUNT(*)=1
  UNION
   SELECT
      MonitorProgramID FROM [GRK_MonitorProgram] a , dbo.GRK_ReportCategory b
      WHERE a.ReportCateID=b.ReportCateID AND  a.MonitorProgramName=b.ReportCateName and a.ReportCateID IN ( SELECT ReportCateID
  FROM [GRK_MonitorProgram]
  GROUP BY ReportCateID HAVING COUNT(*)>1))
) aa
LEFT OUTER JOIN
(
   SELECT DeptID , ReportCategory ,COUNT(*) resCount   FROM [GRK_JYBG] 
  WHERE TransportDate >= @startDate and TransportDate < @endDate
  GROUP BY DeptID, ReportCategory
) bb
ON aa.ReportCateCode =bb.ReportCategory AND  aa.MonitoredDeptID=bb.DeptID
WHERE aa.MonitorFrequencyUnit = @unitValue
UNION
SELECT MonitoredDeptName,MonitorProgramName,DeptID,resCount,resCount-MonitorFrequencyValue diff,CONVERT(NVARCHAR(2),MonitorFrequencyValue)+MonitorFrequencyUnit MonitorFrequencyASK FROM 
(
SELECT 
       MonitoredDeptID
	  ,(SELECT MonitoredDeptName FROM GRK_MonitoredDept WHERE MonitoredDeptID  = a.[MonitoredDeptID]) MonitoredDeptName
      ,(SELECT MonitorFrequencyValue  FROM GRK_MonitorFrequency WHERE MonitorFrequencyID=a.MonitorFrequencyID) MonitorFrequencyValue
      ,(SELECT MonitorFrequencyUnit  FROM GRK_MonitorFrequency WHERE MonitorFrequencyID=a.MonitorFrequencyID) MonitorFrequencyUnit
      ,(SELECT MonitorProgramName FROM GRK_MonitorProgram WHERE MonitorProgramID=a.MonitorProgramID) MonitorProgramName
  FROM [GRK_DeptProgram] a
   WHERE a.MonitorProgramID IN (  SELECT
      MonitorProgramID FROM [GRK_MonitorProgram] a , dbo.GRK_ReportCategory b
      WHERE a.ReportCateID=b.ReportCateID AND  a.MonitorProgramName<>b.ReportCateName and a.ReportCateID IN ( SELECT ReportCateID
  FROM [GRK_MonitorProgram] where ReportCateCode<>'JPZX_JJCSJC'
  GROUP BY ReportCateID HAVING COUNT(*)>1)
  )
) aa
LEFT OUTER JOIN
(
   SELECT DeptID , LabSample ,COUNT(*) resCount   FROM [GRK_JYBG] 
  WHERE TransportDate >= @startDate and TransportDate < @endDate
  GROUP BY DeptID, LabSample
) bb
ON bb.LabSample LIKE '%'+aa.MonitorProgramName+'%' AND  aa.MonitoredDeptName=bb.DeptID
WHERE aa.MonitorFrequencyUnit = @unitValue
UNION
SELECT MonitoredDeptName,MonitorProgramName,DeptID,resCount,resCount-MonitorFrequencyValue diff,CONVERT(NVARCHAR(2),MonitorFrequencyValue)+MonitorFrequencyUnit MonitorFrequencyASK FROM 
(
SELECT 
	 (SELECT MonitoredDeptName FROM GRK_MonitoredDept WHERE MonitoredDeptID  = a.[MonitoredDeptID]) MonitoredDeptName
      ,(SELECT MonitorFrequencyValue  FROM GRK_MonitorFrequency WHERE MonitorFrequencyID=a.MonitorFrequencyID) MonitorFrequencyValue
      ,(SELECT MonitorFrequencyUnit  FROM GRK_MonitorFrequency WHERE MonitorFrequencyID=a.MonitorFrequencyID) MonitorFrequencyUnit
      ,(SELECT MonitorProgramName FROM GRK_MonitorProgram WHERE MonitorProgramID=a.MonitorProgramID) MonitorProgramName
  FROM [GRK_DeptProgram] a
   WHERE a.MonitorProgramID IN (  SELECT
      MonitorProgramID FROM [GRK_MonitorProgram] a 
      WHERE a.ReportCateID IN ( SELECT ReportCateID
  FROM [dbo].[GRK_ReportCategory]WHERE ReportCateCode='JPZX_JJCSJC')
  )
) aa
LEFT OUTER JOIN
(
   SELECT DeptID ,MAX(LabSite) LabSite,COUNT(*) resCount   FROM [GRK_JYBG]
  WHERE  ReportCategory='JPZX_JJCSJC' AND  TransportDate >= @startDate and TransportDate < @endDate
  GROUP BY DeptID,SUBSTRING(LabSite,1,5)
) bb
ON bb.LabSite LIKE '%'+aa.MonitorProgramName+'%' AND  aa.MonitoredDeptName=bb.DeptID
WHERE aa.MonitorFrequencyUnit = @unitValue";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxTimeEditStart.DateTime = System.DateTime.Now;
            }
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

            if ( "年" == cbbNJDY.Value.ToString())
            {
                e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-01-01");
                e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.AddYears(1).ToString("yyyy-01-01");
                e.Command.Parameters["@unitValue"].Value = "份/年";
            }
            else if (cbbNJDY.Value == "上半年")
            {
                e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-01-01");
                e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-07-01");
                e.Command.Parameters["@unitValue"].Value = "份/半年";
            }
            else if (cbbNJDY.Value == "下半年")
            {
                e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-07-01");
                e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.AddYears(1).ToString("yyyy-01-01");
                e.Command.Parameters["@unitValue"].Value = "份/半年";
            }
            else if (cbbNJDY.Value == "第一季度")
            {
                e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-01-01");
                e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-04-01");
                e.Command.Parameters["@unitValue"].Value = "份/季度";
            }
            else if (cbbNJDY.Value == "第二季度")
            {
                e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-04-01");
                e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-07-01");
                e.Command.Parameters["@unitValue"].Value = "份/季度";
            }
            else if (cbbNJDY.Value == "第三季度")
            {
                e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-07-01");
                e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-10-01");
                e.Command.Parameters["@unitValue"].Value = "份/季度";
            }
            else if (cbbNJDY.Value == "第四季度")
            {
                e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-10-01");
                e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.AddYears(1).ToString("yyyy-01-01");
                e.Command.Parameters["@unitValue"].Value = "份/季度";
            }
            else
            {
                e.Command.Parameters["@unitValue"].Value = "份/月";
                switch (ASPxSpinEdit1.Value.ToString())
                {
                    case "1":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-01-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-02-01");
                        break;
                    case "2":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-02-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-03-01");
                        break;
                    case "3":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-03-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-04-01");
                        break;
                    case "4":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-04-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-05-01");
                        break;
                    case "5":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-05-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-06-01");
                        break;
                    case "6":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-06-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-07-01");
                        break;
                    case "7":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-07-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-08-01");
                        break;
                    case "8":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-08-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-09-01");
                        break;
                    case "9":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-09-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-10-01");
                        break;
                    case "10":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-10-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-11-01");
                        break;
                    case "11":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-11-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-12-01");
                        break;
                    case "12":
                        e.Command.Parameters["@startDate"].Value = ASPxTimeEditStart.DateTime.ToString("yyyy-12-01");
                        e.Command.Parameters["@endDate"].Value = ASPxTimeEditStart.DateTime.AddYears(1).ToString("yyyy-01-01");
                        break;


                }
            }
        }

        protected void ASPxButtonQuery_Click(object sender, EventArgs e)
        {
            ASPxGridView1.DataBind();
        }
    }
}