<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProgramsMaintain.aspx.cs"
    Inherits="Project.WebUi.GRKHJJC.ProgramsMaintain" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>监测计划维护</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
            KeyFieldName="MonitoredDeptID;MonitorProgramID" Width="100%" >
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" 
                    ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="4" Caption="备注" Width="200px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn FieldName="MonitoredDeptID"  VisibleIndex="1"  Caption="部门" Width="150px">
                    <PropertiesComboBox DataSourceID="dsMonitoredDept" TextField="MonitoredDeptName"
                        ValueField="MonitoredDeptID" IncrementalFilteringMode="Contains">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataComboBoxColumn FieldName="MonitorProgramID" VisibleIndex="2" Caption="监测项目" Width="200px">
                    <PropertiesComboBox DataSourceID="dsMonitorProgram" TextField="MonitorProgramName"
                        ValueField="MonitorProgramID">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataComboBoxColumn FieldName="MonitorFrequencyID" VisibleIndex="3" Caption="监测要求" Width="100px">
                    <PropertiesComboBox DataSourceID="dsMonitorFrequency" TextField="MonitorFrequencyName"
                        ValueField="MonitorFrequencyID">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>
            <SettingsBehavior AllowDragDrop="False" ConfirmDelete="True" />
            <SettingsPager AlwaysShowPager="True" PageSize="20">
            </SettingsPager>
            <Settings ShowHeaderFilterButton="True" />
            <SettingsText CommandCancel="取消" CommandDelete="删除" CommandEdit="编辑" 
                CommandNew="新增" CommandUpdate="更新" ConfirmDelete="确定删除？" />
            <Styles>
                <Header HorizontalAlign="Center">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT [MonitoredDeptID], [MonitorProgramID], [MonitorFrequencyID], [Notes] FROM [GRK_DeptProgram]"
            InsertCommand="INSERT INTO [GRK_DeptProgram]([MonitoredDeptID],[MonitorProgramID],[MonitorFrequencyID],[Notes])
                            VALUES (@MonitoredDeptID, @MonitorProgramID, @MonitorFrequencyID, @Notes)" 
            UpdateCommand="UPDATE dbo.GRK_DeptProgram SET MonitoredDeptID=@MonitoredDeptID ,MonitorProgramID=@MonitorProgramID,MonitorFrequencyID=@MonitorFrequencyID,Notes=@Notes
                            WHERE MonitoredDeptID=@Original_MonitoredDeptID AND MonitorProgramID=@Original_MonitorProgramID"
            DeleteCommand="DELETE FROM dbo.GRK_DeptProgram WHERE MonitoredDeptID=@Original_MonitoredDeptID AND MonitorProgramID=@Original_MonitorProgramID" OldValuesParameterFormatString="Original_{0}">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsMonitorProgram" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT  [MonitorProgramID],[ReportCateID],[MonitorProgramName]FROM [GRK_MonitorProgram]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsMonitoredDept" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT [MonitoredDeptID], [MonitoredDeptName] FROM [GRK_MonitoredDept]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsMonitorFrequency" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT [MonitorFrequencyID], CONVERT(NVARCHAR(2),[MonitorFrequencyValue])+[MonitorFrequencyUnit] [MonitorFrequencyName] FROM [GRK_MonitorFrequency]">
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
