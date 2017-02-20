<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuerySXSJ.aspx.cs" Inherits="Project.WebUi.AdverseEvent.QuerySXSJ"  %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">
        var cmd;
        function gridEndCallBack(s, e) {
            if (cmd == "STARTEDIT") {
                self.location.href = "."+s.cpPageUrl;
            }
        }
        function gridBeginCallBack(s, e) {
            cmd = e.command;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
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
                    事件等级
                </td>
                <td>
                    <dx:ASPxComboBox ID="ASPxComboBoxEventGrade" runat="server" SelectedIndex="0" Width="100px"
                        ValueType="System.String">
                        <Items>
                            <dx:ListEditItem Selected="True" Text="全部" Value="全部" />
                            <dx:ListEditItem Text="Ⅰ级事件" Value="Ⅰ级事件（警训事件）" />
                            <dx:ListEditItem Text="II级事件" Value="Ⅱ级事件（不良后果事件）" />
                            <dx:ListEditItem Text="III级事件" Value="Ⅲ级事件（未造成后果事件）" />
                            <dx:ListEditItem Text="Ⅳ级事件" Value="Ⅳ级事件（临界错误事件）" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="查询" OnClick="ASPxButtonQuery_Click">
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
            KeyFieldName="baseEventID;eventName" OnBeforePerformDataSelect="ASPxGridView1_BeforePerformDataSelect"
            OnRowDeleting="ASPxGridView1_RowDeleting" 
            onstartrowediting="ASPxGridView1_StartRowEditing">
            <ClientSideEvents  BeginCallback="gridBeginCallBack"  EndCallback="gridEndCallBack" />
            <Columns>
                <dx:GridViewCommandColumn Caption="操作" ShowDeleteButton="True" ShowEditButton="true" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="baseEventID" Caption="事件ID" ReadOnly="True" VisibleIndex="3">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="eventName" Caption="事件名称" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="eOccurDept" Caption="事件发生科室" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="hospitalID" Caption="住院号" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="patientName" Caption="患者姓名" 
                    VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn Caption="详细信息" VisibleIndex="2">
                    <DataItemTemplate>
                        <%# "<a href='ReportEvent.aspx?id=" + Eval("baseEventID") + "&name=" + Server.UrlEncode(Eval("eventName")== null ? string.Empty : Eval("eventName").ToString()) + "' target='report_window'>详细信息</a>"%>
                    </DataItemTemplate>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataComboBoxColumn Caption="患者ABO血型" FieldName="pABO" 
                    VisibleIndex="10">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="pRHD" VisibleIndex="11" 
                    Caption="患者Rh(D)血型">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BCSXFYZZ" Caption="输血反应症状与体征" 
                    VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="输血反应类型" FieldName="SXFYLX" 
                    VisibleIndex="13">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsBehavior ConfirmDelete="True" AllowDragDrop="False" AllowSort="False" />
            <SettingsPager AlwaysShowPager="True">
            </SettingsPager>
            <SettingsText ConfirmDelete="确定删除吗？"  CommandDelete="删除" CommandEdit="编辑" />
            
                
                
                
                
            
            <SettingsDataSecurity AllowInsert="False" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>">
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
