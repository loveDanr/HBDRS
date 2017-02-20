<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChartHL.aspx.cs" Inherits="Project.WebUi.AdverseEvent.ChartHL"  %>

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
    <div style="width: 600px; margin: auto;">
        <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" DataSourceID="SqlDataSource1"
            Height="350px" Width="600px" CrosshairEnabled="True">
            <diagramserializable>
                <cc1:SimpleDiagram EqualPieSize="False">
                </cc1:SimpleDiagram>
            </diagramserializable>
            <legend alignmenthorizontal="Center" alignmentvertical="BottomOutside" direction="LeftToRight">
            </legend>
            <seriesserializable>
                <cc1:Series ArgumentDataMember="eventName" Name="各类事件比例" 
                    SynchronizePointOptions="False" ValueDataMembersSerializable="zj">
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
                        <cc1:PiePointOptions PointView="ArgumentAndValues">
                            <valuenumericoptions format="Percent" />
<ValueNumericOptions Format="Percent"></ValueNumericOptions>
                        </cc1:PiePointOptions>
                    </legendpointoptionsserializable>
                </cc1:Series>
            </seriesserializable>
            <titles>
             <cc1:ChartTitle Text="各类事件比例" />
         </titles>
        </dxchartsui:WebChartControl>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="        SELECT  
        eventName,COUNT(*) zj
FROM   AE_ShareEventInfo 
WHERE  eventName IN ( '护理不良事件-压疮', '护理不良事件-输液反应', '护理不良事件-跌倒/坠床',
                             '护理不良事件-管路滑脱', '护理不良事件-其他' )
        AND reportTime &gt;= @startTime
        AND reportTime &lt;= @endTime 
        AND AEflag = 1
        AND recordState=1
  GROUP BY eventName">
            <SelectParameters>
                <asp:ControlParameter ControlID="ASPxTimeEditStart" Name="startTime" PropertyName="DateTime" />
                <asp:ControlParameter ControlID="ASPxTimeEditEnd" Name="endTime" PropertyName="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
