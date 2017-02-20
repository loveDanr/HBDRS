<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridMYDYS.aspx.cs" Inherits="Project.WebUi.MYDYS.GridMYDYS" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v15.2.Web, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
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
                        <dx:ASPxDropDownEdit ID="ASPxDropDownEditDept" runat="server" ReadOnly="true" ClientInstanceName="dde"
                            AutoPostBack="false">
                            <DropDownWindowTemplate>
                                <dx:ASPxTreeView ID="ASPxTreeViewDept" runat="server" AllowSelectNode="True" NameField="AreaID"
                                    AutoPostBack="False" EnableCallBacks="true" TextField="AreaName" OnVirtualModeCreateChildren="ASPxTreeViewDept_VirtualModeCreateChildren">
                                    <ClientSideEvents NodeClick="function(s, e) {dde.SetKeyValue(e.node.name) ;dde.SetText(e.node.GetText());dde.HideDropDown(); e.processOnServer = false;}" />
                                </dx:ASPxTreeView>
                            </DropDownWindowTemplate>
                        </dx:ASPxDropDownEdit>
                    </td>
                    <td>
                        <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="查询" OnClick="ASPxButtonQuery_Click">
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
            <dx:ReportToolbar ID="ReportToolbar1" runat="server" ReportViewerID="ReportViewer1"
                ShowDefaultButtons="False">
                <Items>
                    <dx:ReportToolbarButton ItemKind="Search" />
                    <dx:ReportToolbarSeparator />
                    <dx:ReportToolbarButton ItemKind="PrintReport" />
                    <dx:ReportToolbarButton ItemKind="PrintPage" />
                    <dx:ReportToolbarSeparator />
                    <dx:ReportToolbarButton Enabled="False" ItemKind="FirstPage" />
                    <dx:ReportToolbarButton Enabled="False" ItemKind="PreviousPage" />
                    <dx:ReportToolbarLabel ItemKind="PageLabel" />
                    <dx:ReportToolbarComboBox ItemKind="PageNumber" Width="65px">
                    </dx:ReportToolbarComboBox>
                    <dx:ReportToolbarLabel ItemKind="OfLabel" />
                    <dx:ReportToolbarTextBox IsReadOnly="True" ItemKind="PageCount" />
                    <dx:ReportToolbarButton ItemKind="NextPage" />
                    <dx:ReportToolbarButton ItemKind="LastPage" />
                    <dx:ReportToolbarSeparator />
                    <dx:ReportToolbarButton ItemKind="SaveToDisk" />
                    <dx:ReportToolbarButton ItemKind="SaveToWindow" />
                    <dx:ReportToolbarComboBox ItemKind="SaveFormat" Width="70px">
                        <Elements>
                            <dx:ListElement Value="pdf" />
                            <dx:ListElement Value="xls" />
                            <dx:ListElement Value="xlsx" />
                            <dx:ListElement Value="rtf" />
                            <dx:ListElement Value="mht" />
                            <dx:ListElement Value="html" />
                            <dx:ListElement Value="txt" />
                            <dx:ListElement Value="csv" />
                            <dx:ListElement Value="png" />
                        </Elements>
                    </dx:ReportToolbarComboBox>
                </Items>
                <Styles>
                    <LabelStyle>
                        <Margins MarginLeft="3px" MarginRight="3px" />
                    </LabelStyle>
                </Styles>
            </dx:ReportToolbar>
            <dx:ReportViewer ID="ReportViewer1" runat="server">
            </dx:ReportViewer>
        </div>
    </form>
</body>
</html>

