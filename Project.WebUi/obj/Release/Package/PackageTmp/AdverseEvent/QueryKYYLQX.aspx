<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryKYYLQX.aspx.cs" Inherits="Project.WebUi.AdverseEvent.QueryKYYLQX" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
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
                    <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="查询">
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
            KeyFieldName="ID" Width="100%">
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID" Caption="事件ID" ReadOnly="True" VisibleIndex="2">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn Caption="编辑" VisibleIndex="1">
                    <DataItemTemplate>
                        <%# "<a href='KYYLQX.aspx?id=" + Eval("ID") + "' target='edit_window'>编辑</a>"%>
                    </DataItemTemplate>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataTextColumn FieldName="rBGRQ" VisibleIndex="15" Caption="报告时间">
                    <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="报告科室" FieldName="rBGKS" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="产品批号" FieldName="qcCPBH" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="患者姓名" FieldName="pName" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="产品名称" FieldName="qCPMC" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="注册账号" FieldName="qZCZH" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn Caption="打印预览" VisibleIndex="17">
                    <DataItemTemplate>
                        <%# "<a href='PrintKYYLQX.aspx?id=" + Eval("ID") + "' target='report_window'>打印预览</a>"%>
                    </DataItemTemplate>
                </dx:GridViewDataHyperLinkColumn>
            </Columns>
            <SettingsBehavior ConfirmDelete="True" AllowDragDrop="False" AllowSort="False" />
            <SettingsPager AlwaysShowPager="True">
            </SettingsPager>
            <SettingsText ConfirmDelete="确定删除吗？" CommandDelete="删除" CommandEdit="编辑" />
            <SettingsDataSecurity AllowInsert="False" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT ID,rBGRQ,(SELECT DeptName From Department where deptid = rBGKS )rBGKS , qcCPBH , pName,qZCZH,qCPMC  FROM [AE_KYYLQX] where rBGRQ >=@startDate and rBGRQ <=@endDate"
            DeleteCommand="DELETE FROM AE_KYYLQX WHERE ID=@ID"  >
            <SelectParameters>
                <asp:ControlParameter ControlID="ASPxTimeEditStart" Name="startDate" 
                    PropertyName="DateTime" />
                <asp:ControlParameter ControlID="ASPxTimeEditEnd" Name="endDate" 
                    PropertyName="DateTime" />
                <asp:Parameter Name="rBGKS" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
