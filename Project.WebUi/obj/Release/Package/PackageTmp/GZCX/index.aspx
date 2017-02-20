<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Project.WebUi.GZCX.index" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>财务箱-工资查询</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center">
            <tr>
                <td>
                </td>
                <td class="style1">
                    <asp:Label ID="Label1" runat="server" Text="个人工资查询" Font-Bold="True" Font-Size="13pt"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="时间:"></asp:Label>
                </td>
                <td>
                    <dx:ASPxTimeEdit ID="ASPxDateEdit1" runat="server" DisplayFormatString="yyyy-MM"
                        EditFormat="Custom" EditFormatString="yyyy-MM" Width="77px">
                    </dx:ASPxTimeEdit>
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="至"></asp:Label>
                </td>
                <td>
                    <dx:ASPxTimeEdit ID="ASPxDateEdit2" runat="server" DisplayFormatString="yyyy-MM"
                        EditFormat="Custom" EditFormatString="yyyy-MM" Width="77px">
                    </dx:ASPxTimeEdit>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click1" Text="查  询">
                    </dx:ASPxButton>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButtonExport" runat="server" Text="导出Excel" OnClick="ASPxButtonExport_Click">
                    </dx:ASPxButton>
                </td>
                <td>
                    <dx:ASPxUploadControl ID="fupExcel" runat="server" Visible="False">
                        <ValidationSettings AllowedFileExtensions=".xls,.xlsx">
                        </ValidationSettings>
                        <BrowseButton Text="浏览...">
                        </BrowseButton>
                    </dx:ASPxUploadControl>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButtonImport" runat="server" Text="导入Excel" OnClick="ASPxButtonImport_Click"
                        Visible="False">
                    </dx:ASPxButton>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButtonClear" runat="server" Text="清除" Visible="False" OnClick="ASPxButtonClear_Click">
                    </dx:ASPxButton>
                </td>
                <td>
                    <dx:ASPxLabel ID="lblMessages" runat="server" Text="" Visible="false" ForeColor="Red">
                    </dx:ASPxLabel>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            DeleteCommand="delete from CWX_GZ where 签字 = @delDate">
            <DeleteParameters>
                <asp:Parameter Name="delDate" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
        </dx:ASPxGridViewExporter>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" KeyFieldName="人员编号" AutoGenerateColumns="False"
            DataSourceID="SqlDataSource1">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="人员编号" VisibleIndex="0" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="姓名" VisibleIndex="1" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="部门" VisibleIndex="2" Width="135px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="人员类别" VisibleIndex="3" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="岗位工资" VisibleIndex="4" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="薪级工资" VisibleIndex="5" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="百分之十活津贴" VisibleIndex="6" Width="100px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="基础性绩效工资" VisibleIndex="7" Width="100px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="福利补" VisibleIndex="8" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="医疗补贴" VisibleIndex="9" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="卫生补" VisibleIndex="10" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="住房补贴" VisibleIndex="11" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="房水电补" VisibleIndex="12" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="洗理费" VisibleIndex="13" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="护龄补贴" VisibleIndex="14" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="临时补" VisibleIndex="15" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="独子补" VisibleIndex="16" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="收１" VisibleIndex="17" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="收2" VisibleIndex="18" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="应发合计" VisibleIndex="19" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="住房公积金" VisibleIndex="20" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="物管" VisibleIndex="21" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="代扣税" VisibleIndex="22" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="支１" VisibleIndex="23" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="支2" VisibleIndex="24" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="支３" VisibleIndex="25" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="扣保险" VisibleIndex="26" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="支4" VisibleIndex="27" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="支5" VisibleIndex="28" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="支6" VisibleIndex="29" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="暖气费" VisibleIndex="30" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="扣百分之60" VisibleIndex="31" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="扣款合计" VisibleIndex="32" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="实发合计" VisibleIndex="33" Width="70px">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="签字" VisibleIndex="34" Width="70px">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsBehavior ColumnResizeMode="Control" AllowDragDrop="False"  />
            <SettingsPager PageSize="60" Position="Top" AlwaysShowPager="True">
            </SettingsPager>
            <Settings  ColumnMinWidth="70" />
            <SettingsText CommandCancel="取消" CommandEdit="编辑" CommandUpdate="更新" GroupPanel="请将分组列拖动至此处" />
            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
            <Styles>
                <Header HorizontalAlign="Center">
                </Header>
                <AlternatingRow Enabled="True">
                </AlternatingRow>
            </Styles>
        </dx:ASPxGridView>
    </div>
    </form>
</body>
</html>
