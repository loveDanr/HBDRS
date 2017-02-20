<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YJHZ.aspx.cs" Inherits="Project.WebUi.MYDHS.YJHZ" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>意见汇总</title>
</head>
<body>
    <form id="form1" runat="server">
    <table>
        <tr>
             <td>
                    <asp:Label ID="LabelStartDate" runat="server" Text="日期:"></asp:Label>
                </td>
                <td>
                    <dx:ASPxTimeEdit ID="ASPxTimeEditStart" runat="server" DisplayFormatString="yyyy"
                        EditFormat="Custom" EditFormatString="yyyy" Width="60px">
                    </dx:ASPxTimeEdit>
                </td>
                <td>
                    <dx:ASPxComboBox ID="ASPxComboBoxHalfYear" runat="server" Width="65px">
                        <Items>
                            <dx:ListEditItem Text="上半年" Value="0" Selected="true" />
                            <dx:ListEditItem Text="下半年" Value="1" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            <td>
                <dx:ASPxComboBox ID="ASPxComboBoxCategory" runat="server" Width="50px" 
                    SelectedIndex="0" ValueType="System.String">
                    <Items>
                        <dx:ListEditItem Text="全部" Value="0" Selected="True" />
                        <dx:ListEditItem Text="医生" Value="1" />
                        <dx:ListEditItem Text="护士" Value="2" />
                    </Items>
                </dx:ASPxComboBox>
            </td>
            <td>
                <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="查询" OnClick="ASPxButtonQuery_Click">
                </dx:ASPxButton>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <div>
        <dx:ASPxDataView ID="ASPxDataView1" runat="server" 
            DataSourceID="SqlDataSource1" 
            onpageindexchanging="ASPxDataView1_PageIndexChanging">
            <ItemTemplate>
                <b>意见建议</b>:
                <asp:Label ID="意见建议Label" runat="server" Text='<%# Eval("意见建议") %>' />
                <br />
            </ItemTemplate>
            <PagerSettings>
                <Summary Text="页 {0}/{1}" />
            </PagerSettings>
        </dx:ASPxDataView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            >
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
