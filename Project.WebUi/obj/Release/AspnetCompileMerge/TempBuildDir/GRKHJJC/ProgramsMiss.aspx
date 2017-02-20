<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProgramsMiss.aspx.cs" Inherits="Project.WebUi.GRKHJJC.ProgramsMiss" %>
<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>监测漏报查询</title>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table align="center">
            <tr>
                <td>
                    上报年份
                </td>
                <td>
                    <dx:ASPxTimeEdit ID="ASPxTimeEditStart" runat="server" DisplayFormatString="yyyy"
                        EditFormat="Custom" EditFormatString="yyyy" Width="90px">
                    </dx:ASPxTimeEdit>
                </td>
                <td>
                    年季度月
                </td>
                <td>
                    <dx:ASPxComboBox ID="cbbNJDY" runat="server" Width="100px">
                        <Items>
                            <dx:ListEditItem Text="年" Value="年" Selected="true" />
                            <dx:ListEditItem Text="上半年" Value="上半年" />
                            <dx:ListEditItem Text="下半年" Value="下半年" />
                            <dx:ListEditItem Text="第一季度" Value="第一季度" />
                            <dx:ListEditItem Text="第二季度" Value="第二季度" />
                            <dx:ListEditItem Text="第三季度" Value="第三季度" />
                            <dx:ListEditItem Text="第四季度" Value="第四季度" />
                            <dx:ListEditItem Text="月" Value="月" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td>
                    <dx:ASPxSpinEdit ID="ASPxSpinEdit1" runat="server" Number="0" MaxValue="12" 
                        MinValue="1" Width="50px">
                    </dx:ASPxSpinEdit>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="查询" 
                        onclick="ASPxButtonQuery_Click"  >
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" Width="100%" Font-Size="Large">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="MonitoredDeptName" ReadOnly="True" 
                VisibleIndex="0" Caption="部门">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MonitorFrequencyASK" ReadOnly="True" 
                VisibleIndex="2" Caption="监测要求份数">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MonitorProgramName" ReadOnly="True" 
                VisibleIndex="1" Caption="监测项目">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MonitoredDeptName" VisibleIndex="5" Caption="上报科室">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="resCount" ReadOnly="True" 
                VisibleIndex="7" Caption="实际上报份数">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="diff" ReadOnly="True" VisibleIndex="8" 
                Caption="漏报份数">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager AlwaysShowPager="True" PageSize="20">
        </SettingsPager>
        <Settings ShowHeaderFilterButton="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>" 
        onselecting="SqlDataSource1_Selecting" >
    <SelectParameters>
    <asp:Parameter Name="startDate" />
    <asp:Parameter Name="endDate" />
    <asp:Parameter Name="unitValue" />
    </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>

