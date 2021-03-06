﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatisticsEvent.aspx.cs"
    Inherits="Project.WebUi.AdverseEvent.StatisticsEvent" %>

<%@ Register Assembly="DevExpress.XtraCharts.v15.2.Web, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table align="center">
        <tr>
            <td>
                上报日期
            </td>
            <td>
                <dx:ASPxTimeEdit ID="ASPxTimeEditStart" runat="server" DisplayFormatString="yyyy-MM-dd"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd" Width="90px">
                </dx:ASPxTimeEdit>
            </td>
            <td>
                —
            </td>
            <td>
                <dx:ASPxTimeEdit ID="ASPxTimeEditEnd" runat="server" DisplayFormatString="yyyy-MM-dd"
                    EditFormat="Custom" EditFormatString="yyyy-MM-dd" Width="90px">
                </dx:ASPxTimeEdit>
            </td>
            <td>
                <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="统计" Height="21px">
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <div style="margin: auto; width: 800px;">
        <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" DataSourceID="SqlDataSource1"
            Height="500px" Width="800px" CrosshairEnabled="True" OnCustomDrawSeriesPoint="WebChartControl1_CustomDrawSeriesPoint">
            <diagramserializable>
                <cc1:XYDiagram>
                    <axisx visibleinpanesserializable="-1">
                    </axisx>
                    <axisy visibleinpanesserializable="-1">
                    </axisy>
                </cc1:XYDiagram>
            </diagramserializable>
            <legend alignmenthorizontal="Center" alignmentvertical="BottomOutside" direction="LeftToRight">
            </legend>
            <seriesserializable>
                <cc1:Series ArgumentDataMember="eventName" Name="各类事件比例" 
                    SynchronizePointOptions="False" LabelsVisibility="True" 
                    ValueDataMembersSerializable="zj">
                    <viewserializable>
                        <cc1:SideBySideBarSeriesView ColorEach="True">
                        </cc1:SideBySideBarSeriesView>
                    </viewserializable>
                    <labelserializable>
                        
                    <cc1:SideBySideBarSeriesLabel ShowForZeroValues="True"><pointoptionsserializable><cc1:PointOptions><valuenumericoptions 
                        format="Number" precision="0" />
                        </cc1:PointOptions></pointoptionsserializable></cc1:SideBySideBarSeriesLabel></labelserializable>
                    <legendpointoptionsserializable>
                        
                    <cc1:PointOptions PointView="Argument"><valuenumericoptions 
                            format="General" />
                        </cc1:PointOptions></legendpointoptionsserializable>
                </cc1:Series>
            </seriesserializable>
            <titles>
             <cc1:ChartTitle Text="各类事件比例" />
         </titles>
        </dxchartsui:WebChartControl>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT   SUBSTRING(eventName,1,CASE CHARINDEX ( '-' ,eventName) WHEN 0 THEN (LEN(eventName))   ELSE (CHARINDEX ( '-' ,eventName)-1) END ) AS eventName ,COUNT(*) AS zj,COUNT(*)*(1.0)/(SELECT COUNT(*) FROM dbo.AE_ShareEventInfo) AS ss  FROM AE_ShareEventInfo WHERE reportTime &gt;= @startTime
        AND reportTime &lt;= @endTime  AND eventName <> '压疮事件' AND recordState=1 GROUP BY  SUBSTRING(eventName,1,CASE CHARINDEX ( '-' ,eventName) WHEN 0 THEN (LEN(eventName))  ELSE (CHARINDEX ( '-' ,eventName)-1)  END )">
            <SelectParameters>
                <asp:ControlParameter ControlID="ASPxTimeEditStart" Name="startTime" 
                    PropertyName="DateTime" />
                <asp:ControlParameter ControlID="ASPxTimeEditEnd" Name="endTime" 
                    PropertyName="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div style="margin: auto; width: 800px;">
        <dxchartsui:WebChartControl ID="WebChartControl2" runat="server" CrosshairEnabled="True"
            DataSourceID="SqlDataSource2" Height="500px" Width="800px">
            <diagramserializable>
             <cc1:SimpleDiagram EqualPieSize="False">
             </cc1:SimpleDiagram>
         </diagramserializable>
            <legend alignmenthorizontal="Center" alignmentvertical="BottomOutside" direction="LeftToRight">
            </legend>
            <seriesserializable>
             <cc1:Series ArgumentDataMember="eventGrade" Name="Series 1" 
                 ValueDataMembersSerializable="zj" SynchronizePointOptions="False">
                 <viewserializable>
                     <cc1:PieSeriesView RuntimeExploding="False">
                     </cc1:PieSeriesView>
                 </viewserializable>
                 <labelserializable>
                     <cc1:PieSeriesLabel>
                         <pointoptionsserializable>
                             <cc1:PiePointOptions PointView="ArgumentAndValues">
<ValueNumericOptions Format="Percent"></ValueNumericOptions>
                             </cc1:PiePointOptions>
                         </pointoptionsserializable>
                     </cc1:PieSeriesLabel>
                 </labelserializable>
                 <legendpointoptionsserializable>
                     <cc1:PiePointOptions PointView="Argument">
<ValueNumericOptions Format="General"></ValueNumericOptions>
                     </cc1:PiePointOptions>
                 </legendpointoptionsserializable>
             </cc1:Series>
         </seriesserializable>
            <titles>
             <cc1:ChartTitle Text="各级事件比例" />
         </titles>
        </dxchartsui:WebChartControl>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT SUBSTRING(eventGrade,1,CHARINDEX ( '—' ,eventGrade)-1) AS eventGrade ,COUNT(*) AS zj FROM AE_ShareEventInfo WHERE reportTime &gt;= @startTime
        AND reportTime &lt;= @endTime  AND eventName <> '压疮事件' AND recordState=1 GROUP BY SUBSTRING(eventGrade,1,CHARINDEX ( '—' ,eventGrade)-1) ">
            <SelectParameters>
                <asp:ControlParameter ControlID="ASPxTimeEditStart" Name="startTime" 
                    PropertyName="DateTime" />
                <asp:ControlParameter ControlID="ASPxTimeEditEnd" Name="endTime" 
                    PropertyName="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
