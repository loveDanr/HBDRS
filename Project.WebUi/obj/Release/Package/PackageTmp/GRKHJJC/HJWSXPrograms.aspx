<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HJWSXPrograms.aspx.cs" Inherits="Project.WebUi.GRKHJJC.HJWSXPrograms" %>

<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>监测计划</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"   Width="100%"
            DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" 
            HorizontalAlign="Center" ShowHeaderWhenEmpty="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="MonitoredDeptName" HeaderText="部门" 
                    ReadOnly="True" SortExpression="MonitoredDeptName" >
                <ItemStyle Width="150px" BorderColor="#507CD1"  BorderWidth="1px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="MonitorProgramName" HeaderText="监测项目" 
                    ReadOnly="True" SortExpression="MonitorProgramName" >
                <ItemStyle Width="200px" BorderColor="#507CD1"  BorderWidth="1px" />
                </asp:BoundField>
                <asp:BoundField DataField="MonitorFrequencyName" HeaderText="监测要求" 
                    ReadOnly="True" SortExpression="MonitorFrequencyName" >
                <ItemStyle Width="100px" BorderColor="#507CD1"  BorderWidth="1px" />
                </asp:BoundField>
                <asp:BoundField DataField="Notes" HeaderText="备注" SortExpression="Notes" >
                <ItemStyle Width="200px" BorderColor="#507CD1"  BorderWidth="1px" />
                </asp:BoundField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" BorderWidth="1px" BorderColor="#507CD1" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SQLConnString %>" SelectCommand="SELECT  
            (SELECT MonitoredDeptName FROM dbo.GRK_MonitoredDept  WHERE MonitoredDeptID=a.MonitoredDeptID) MonitoredDeptName
,(SELECT MonitorProgramName FROM dbo.GRK_MonitorProgram WHERE MonitorProgramID=a.MonitorProgramID) MonitorProgramName
,(SELECT CONVERT(NVARCHAR(2),[MonitorFrequencyValue])+MonitorFrequencyUnit FROM dbo.GRK_MonitorFrequency  WHERE MonitorFrequencyID = a.MonitorFrequencyID )  MonitorFrequencyName
,Notes
FROM GRK_DeptProgram a"></asp:SqlDataSource>

    </div>
    </form>
</body>
</html>

