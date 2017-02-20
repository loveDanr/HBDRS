<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChartZYBL.aspx.cs" Inherits="Project.WebUi.AdverseEvent.ChartZYBL" %>

<%@ Register Assembly="DevExpress.XtraCharts.v15.2.Web, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" 
                    onselectedindexchanged="ASPxComboBox1_SelectedIndexChanged" SelectedIndex="0">
                    <Items>
                        <dx:ListEditItem Selected="True" Text="暴露地点" Value="JB_BLDD" />
                        <dx:ListEditItem Text="科室" Value="JB_KS" />
                        <dx:ListEditItem Text="暴露时从事何种医疗活动" Value="JB_CSHD" />
                        <dx:ListEditItem Text="器械类型" Value="BLFS_QX_LX" />
                        <dx:ListEditItem Text="损伤程度" Value="BLFS_QX_SSCD" />
                        <dx:ListEditItem Text="关联操作" Value="BLFS_GLCZ" />
                        <dx:ListEditItem Text="暴露源患者病情" Value="BLY_HZBQ" /><dx:ListEditItem Text="报告人工作年限" Value="rWorkYears" />
                    </Items>
                </dx:ASPxComboBox>
            </td>
            <td>
                <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="统计" Height="21px">
                </dx:ASPxButton>
            </td>
            <td>
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="导出" Height="21px"  AutoPostBack="false">
            <ClientSideEvents Click="function(s,e){webChart.SaveToDisk('xls');}" />
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <div style="width: 600px; margin: auto;">
        <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" DataSourceID="SqlDataSource1"
            Height="350px" Width="600px" CrosshairEnabled="True" ClientInstanceName="webChart">
            <diagramserializable>
                <cc1:SimpleDiagram EqualPieSize="False">
                </cc1:SimpleDiagram>
            </diagramserializable>
            <legend alignmenthorizontal="Center" alignmentvertical="BottomOutside" direction="LeftToRight">
            </legend>
            <seriesserializable>
                <cc1:Series Name="事件各项比例" ArgumentDataMember="adm"
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
             <cc1:ChartTitle Text="各项事件比例" />
         </titles>
        </dxchartsui:WebChartControl>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT COUNT(*) zj,ISNULL(JB_BLDD,'空值') as adm FROM dbo.AE_ZYBL b, dbo.AE_ShareEventInfo a , AE_ReportorInfo c
WHERE  b.baseEventID = a.baseEventID AND c.baseEventID = a.baseEventID AND reportTime &gt;= @startTime
        AND reportTime &lt;= @endTime
        AND recordState=1 
GROUP BY JB_BLDD">
            <SelectParameters>
                <asp:ControlParameter ControlID="ASPxTimeEditStart" Name="startTime" PropertyName="DateTime" />
                <asp:ControlParameter ControlID="ASPxTimeEditEnd" Name="endTime" PropertyName="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
