<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PivotGridDept.aspx.cs"
    Inherits="Project.WebUi.AdverseEvent.PivotGridDept"  %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>科室不良事件统计</title>
    <style type="text/css">
    *
    {
        font-size:12pt;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 800px; margin: auto;">
        <table>
            <tr>
                <td>
                    <dx:ASPxTimeEdit runat="server" ID="teYear" EditFormat="Custom" EditFormatString="yyyy"
                        Width="70px">
                    </dx:ASPxTimeEdit>
                </td>
                <td>
                    年份
                </td>
                <td>
                    <dx:ASPxButton runat="server" Text="查询">
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1"
            AutoGenerateColumns="False" 
            OnBeforePerformDataSelect="ASPxGridView1_BeforePerformDataSelect">
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="合计" ShowInColumn="事件名称" 
                    SummaryType="Count" />
                <dx:ASPxSummaryItem FieldName="1月" ShowInColumn="1月" DisplayFormat="{0}" SummaryType="Sum"   />
                <dx:ASPxSummaryItem FieldName="2月" ShowInColumn="2月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="3月" ShowInColumn="3月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="4月" ShowInColumn="4月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="5月" ShowInColumn="5月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="6月" ShowInColumn="6月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="7月" ShowInColumn="7月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="8月" ShowInColumn="8月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="9月" ShowInColumn="9月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="10月" ShowInColumn="10月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="11月" ShowInColumn="11月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="12月" ShowInColumn="12月" DisplayFormat="{0}" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0}" FieldName="total" ShowInColumn="合计" 
                    SummaryType="Sum" />
            </TotalSummary>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="事件名称" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="1月" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="2月" ReadOnly="True" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="3月" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="4月" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="5月" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="6月" ReadOnly="True" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="7月" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="8月" ReadOnly="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="9月" ReadOnly="True" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="10月" ReadOnly="True" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="11月" ReadOnly="True" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="12月" ReadOnly="True" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="合计" FieldName="total" 
                    UnboundExpression="[1月]+[2月]+[3月]+[4月]+[5月]+[6月]+[7月]+[8月]+[9月]+[10月]+[11月]+[12月]" UnboundType="Integer" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsBehavior AllowDragDrop="False" AllowGroup="False"></SettingsBehavior>
            <SettingsPager Mode="ShowAllRecords">
            </SettingsPager>
            <Settings ShowTitlePanel="True" ShowFooter="True"></Settings>
            <SettingsText Title="ABCD "></SettingsText>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT eventName AS '事件名称', 
[1] AS '1月' , [2] AS '2月', [3] AS '3月', [4] AS '4月',[5] AS '5月',[6] AS '6月',[7] AS '7月',[8] AS '8月',[9] AS '9月',
[10] AS '10月',[11] AS '11月',[12] AS '12月'
FROM
(SELECT a.baseEventID, eventName ,MONTH(reportTime) AS mm
FROM    AE_ShareEventInfo a , AE_ReportorInfo b
WHERE b.baseEventID = a.baseEventID AND recordState = 1 AND b.rClinicalDept=@dept AND YEAR(reportTime) = @year AND eventName <> '压疮事件' ) AS SourceTable
PIVOT
(
count(baseEventID)
FOR mm IN ( [1], [2], [3], [4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PivotTable">
            <SelectParameters>
                <asp:Parameter Name="dept" />
                <asp:Parameter Name="year" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
