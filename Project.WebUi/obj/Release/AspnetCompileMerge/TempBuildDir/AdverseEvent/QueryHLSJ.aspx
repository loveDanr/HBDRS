<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryHLSJ.aspx.cs" Inherits="Project.WebUi.AdverseEvent.QueryHLSJ"
     %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">
        var cmd ;
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
                <dx:ASPxCheckBox ID="ASPxCheckBoxBL" runat="server" Text="是否不良事件" style="float:right;" Checked="True" CheckState="Checked" >
        </dx:ASPxCheckBox>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="查询" OnClick="ASPxButtonQuery_Click">
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
            KeyFieldName="baseEventID;eventName" OnBeforePerformDataSelect="ASPxGridView1_BeforePerformDataSelect"
            OnRowDeleting="ASPxGridView1_RowDeleting" OnStartRowEditing="ASPxGridView1_StartRowEditing">
            <ClientSideEvents  BeginCallback="gridBeginCallBack"  EndCallback="gridEndCallBack" />
            <Columns>
                <dx:GridViewCommandColumn Caption="操作" ShowDeleteButton="True" VisibleIndex="0" Width="60px"
                    ShowEditButton="True">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="baseEventID" Caption="事件ID" ReadOnly="True"
                    VisibleIndex="3">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="eventName" Caption="事件名称" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="eOccurDeptName" Caption="事件发生科室" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn Caption="详细信息" VisibleIndex="2">
                    <DataItemTemplate>
                        <%# "<a href='ReportEvent.aspx?id=" + Eval("baseEventID") + "&name=" + Server.UrlEncode(Eval("eventName")== null ? string.Empty : Eval("eventName").ToString()) + "' target='report_window'>详细信息</a>"%>
                    </DataItemTemplate>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataTextColumn FieldName="eOccurTime" Caption="事件发生时间" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="reportTime" VisibleIndex="11" Caption="报告时间">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="事件等级" FieldName="eventGrade" VisibleIndex="8">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <Settings ShowTitlePanel="True" />
            <SettingsBehavior ConfirmDelete="True" AllowDragDrop="False" AllowSort="False" />
            <SettingsPager AlwaysShowPager="True">
            </SettingsPager>
            <SettingsText ConfirmDelete="确定删除吗？" CommandDelete="删除" CommandEdit="编辑" Title="护理不良事件" />
            <SettingsDataSecurity AllowInsert="False" />
            <Styles>
                <TitlePanel Font-Bold="True" ForeColor="Black">
                </TitlePanel>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>">
        </asp:SqlDataSource>
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2"
            KeyFieldName="baseEventID" 
            onbeforeperformdataselect="ASPxGridView2_BeforePerformDataSelect">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="dPostLevel" Caption="当事人岗位层级" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="当事人工作年限" FieldName="dWorkYears" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager AlwaysShowPager="True">
            </SettingsPager>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>">
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
