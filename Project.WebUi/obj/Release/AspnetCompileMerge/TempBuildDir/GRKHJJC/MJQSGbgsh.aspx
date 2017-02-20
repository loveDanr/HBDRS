﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MJQSGbgsh.aspx.cs" Inherits="Project.WebUi.GRKHJJC.MJQSGbgsh"  %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">
        //使 comboBox中的某列值 赋给 gridView中某列值
        function OnSelectedIndexChanged(s, e) {
            //gvDetails.GetEditor("ItemGrade").SetValue(s.GetSelectedItem().GetColumnText("xmmc"));
//            var lcv = gvDetails.GetEditor("Reference").GetValue();
//            gvDetails.GetEditor("Reference").SetValue(s.GetSelectedItem().GetColumnText("zxbz"));
//            var cob = s.GetSelectedItem();
//            gvDetails.GetEditor("Reference").lastChangedValue = lcv;
//            


        }
        function OnLostFocuszxbz(s, e) {
            var res = e;
        }
        function OnSubmit(s, e) {
            if (ASPxClientEdit.ValidateGroup("pageVG")) {
                cp.PerformCallback();
            }
        }
        function OngridendCallback(s, e) {
            if (s.cpSaveFlag != undefined) {
                if (s.cpSaveFlag) {
                    //ASPxClientEdit.ClearEditorsInContainer(null);
                    //gvDetails.Refresh();
                    alert('保存成功！');
                    window.parent.HidePopupWin();
                    //gridParty.CancelEdit();
                }
                else {
                    alert('保存失败，认真检查所填项后,请重新保存！')
                }
            }
        }

        function gridBatchEditConfirmShowing(s, e) {
            if (e.requestTriggerID == 'cp') {
                e.cancel = true;
            }
        }
    </script>
    <style type="text/css">
        #custom
        {
            border-collapse: collapse;
            margin:auto;
        }
        /*IE6不支持*/
        #custom > tbody > tr > td
        {
            border: 2px solid #999;
        }
    </style>
    <!--[if lte IE 6]>
    <style type="text/css">
        /*IE6的解决方法*/
        #custom td
        {
            border: 2px solid #999;
        }
        #custom td td
        {
            border: none;
        }
    </style>
     <![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SqlDataSource ID="SqlDataSourceGRKdept" runat="server" ConnectionString="<%$ ConnectionStrings:LISConnectionString %>"
            SelectCommand="  SELECT    zddh ,zdmc FROM  com_dict WHERE     ( zdlb = 'DP' )   ">
        </asp:SqlDataSource>
        <dx:ASPxCallbackPanel ID="cp" ClientInstanceName="cp" runat="server" OnCallback="cp_Callback">
            <ClientSideEvents EndCallback="OngridendCallback"></ClientSideEvents>
            <PanelCollection>
                <dx:PanelContent ID="PanelContent1" runat="server">
                    <table id="custom">
                        <tr>
                            <td>
                                科别
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="ASPxComboBoxDept" runat="server" ValueType="System.String" Width="100%" CallbackPageSize="10"
                                    EnableCallbackMode="true" ClientInstanceName="cbDept" TextFormatString="{0}"
                                    DisplayFormatString="{1}" AllowMouseWheel="False" IncrementalFilteringMode="StartsWith"
                                    FilterMinLength="2" TextField="zdmc" ValueField="zddh" DataSourceID="SqlDataSourceGRKdept">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="zddh" />
                                        <dx:ListBoxColumn FieldName="zdmc" />
                                    </Columns>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                灭菌器类型
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="ASPxComboBoxDisSteMis" runat="server" ValueType="System.String" Width="100%" TextField="xmmc"
                                    ValueField="xmmc" TextFormatString="{0}" DisplayFormatString="{0}" DataSourceID="SqlDataSourceJYItem"
                                    NullText="--请选择--">
                                    <ClientSideEvents SelectedIndexChanged="OnSelectedIndexChanged" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="xmmc" />
                                    </Columns>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                灭菌时间
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="ASPxTextBoxKeepTime" runat="server" Width="100%">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                标本
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="ASPxTextBoxLabSample" runat="server" Width="100%">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                送检者
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="ASPxComboBoxT" runat="server" ValueType="System.String" Width="100%" CallbackPageSize="10"
                                    EnableCallbackMode="true" ClientInstanceName="cbUserR" TextFormatString="{0}"
                                    DisplayFormatString="{1}" AllowMouseWheel="False" IncrementalFilteringMode="StartsWith"
                                    FilterMinLength="2" TextField="yhdh" ValueField="yhxm" DataSourceID="SqlDataSourceUser"
                                    DropDownStyle="DropDown">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="yhdh" />
                                        <dx:ListBoxColumn FieldName="yhxm" />
                                    </Columns>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                送检日期
                            </td>
                            <td>
                                <dx:ASPxDateEdit ID="ASPxDateEditT" runat="server" Width="100%">
                                </dx:ASPxDateEdit>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                报告者
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="ASPxComboBoxR" runat="server" ValueType="System.String" Width="100%" CallbackPageSize="10"
                                    EnableCallbackMode="true" ClientInstanceName="cbUserR" TextFormatString="{0}"
                                    DisplayFormatString="{1}" AllowMouseWheel="False" IncrementalFilteringMode="StartsWith"
                                    FilterMinLength="2" TextField="yhdh" ValueField="yhxm" DataSourceID="SqlDataSourceUser"
                                    DropDownStyle="DropDown">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="yhdh" />
                                        <dx:ListBoxColumn FieldName="yhxm" />
                                    </Columns>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                报告日期
                            </td>
                            <td>
                                <dx:ASPxDateEdit ID="ASPxDateEditR" runat="server" Width="100%">
                                </dx:ASPxDateEdit>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                核对者
                            </td>
                            <td colspan="3">
                                <dx:ASPxComboBox ID="ASPxComboBoxC" runat="server" ValueType="System.String" Width="100%" CallbackPageSize="10"
                                    EnableCallbackMode="true" ClientInstanceName="cbUserR" TextFormatString="{0}"
                                    DisplayFormatString="{1}" AllowMouseWheel="False" IncrementalFilteringMode="StartsWith"
                                    FilterMinLength="2" TextField="yhdh" ValueField="yhxm" DataSourceID="SqlDataSourceUser"
                                    DropDownStyle="DropDown">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="yhdh" />
                                        <dx:ListBoxColumn FieldName="yhxm" />
                                    </Columns>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <dx:ASPxGridView ID="ASPxGridViewDetails" runat="server" AutoGenerateColumns="False"
                                    DataSourceID="SqlDataSourceItem" KeyFieldName="ItemID" Width="100%" ClientInstanceName="gvDetails"
                                    OnBeforePerformDataSelect="ASPxGridViewDetails_BeforePerformDataSelect">
                                    <ClientSideEvents BatchEditConfirmShowing="gridBatchEditConfirmShowing" />
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataComboBoxColumn Caption="指示菌株" FieldName="ItemGrade" VisibleIndex="1">
                                            <PropertiesComboBox ValueType="System.String" TextField="xmmc" ValueField="xmmc"
                                                TextFormatString="{0}" DisplayFormatString="{0}" DataSourceID="SqlDataSourceJYItem"
                                                NullText="--请选择--">
                                                <ClientSideEvents SelectedIndexChanged="OnSelectedIndexChanged" />
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="xmmc" />
                                                    <dx:ListBoxColumn FieldName="zxbz" />
                                                </Columns>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataTextColumn Caption="执行标准" FieldName="Reference" 
                                            VisibleIndex="4" Visible="False">
                                            <PropertiesTextEdit>
                                                <ClientSideEvents LostFocus="OnLostFocuszxbz" />
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataComboBoxColumn Caption="监测结果" FieldName="MonitorRes" 
                                            ShowInCustomizationForm="True" VisibleIndex="3">
                                            <PropertiesComboBox>
                                                <Items>
                                                    <dx:ListEditItem Text="阳性" Value="阳性" />
                                                    <dx:ListEditItem Text="阴性" Value="阴性" />
                                                </Items>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                    </Columns>
                                    <SettingsBehavior ConfirmDelete="True" AllowDragDrop="False" AllowSort="False" AllowFocusedRow="True">
                                    </SettingsBehavior>
                                    <SettingsEditing Mode="Batch">
                                        <BatchEditSettings EditMode="Row" />
                                    </SettingsEditing>
                                    <Settings ShowStatusBar="Hidden" />
                                    <SettingsText ConfirmDelete="确定删除吗？" CommandEdit="编辑" CommandNew="新增" CommandDelete="删除"
                                        CommandCancel="取消" CommandUpdate="保存" EmptyDataRow="空" ConfirmOnLosingBatchChanges="监测项目尚未保存">
                                    </SettingsText>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="SqlDataSourceItem" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
                                    SelectCommand="SELECT [ItemID], [ReportID], [ItemGrade], [MonitorRes], [Reference] FROM [GRK_JYBGitem] WHERE ReportID=@ReportID"
                                    InsertCommand="INSERT INTO GRK_JYBGitem(ReportID, ItemGrade, MonitorRes, Reference) VALUES (@ReportID,@ItemGrade,@MonitorRes,@Reference)"
                                    UpdateCommand="UPDATE GRK_JYBGitem SET ItemGrade =@ItemGrade, MonitorRes =@MonitorRes, Reference =@Reference WHERE ItemID=@ItemID"
                                    DeleteCommand="DELETE FROM GRK_JYBGitem WHERE ItemID=@ItemID" OnInserting="SqlDataSourceItem_Inserting"
                                    OnUpdating="SqlDataSourceItem_Updating" OnDeleting="SqlDataSourceItem_Deleting">
                                    <SelectParameters>
                                        <asp:Parameter Name="ReportID" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="ReportID" />
                                        <asp:Parameter Name="ItemGrade" />
                                        <asp:Parameter Name="MonitorRes" />
                                        <asp:Parameter Name="Reference" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align: center;">
                                <dx:ASPxButton ID="ASPxButtonSubmit" runat="server" ClientInstanceName="ASPxButtonSubmit"
                                    AutoPostBack="false" Text="保存">
                                    <ClientSideEvents Click="OnSubmit" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
        <asp:SqlDataSource ID="SqlDataSourceJYItem" runat="server" ConnectionString="<%$ ConnectionStrings:LISConnectionString %>"
            SelectCommand="SELECT xmdh,xmmc,ISNULL(dyckz,'')+ISNULL(dw,'') AS zxbz FROM xm_info WHERE yq ='MJQSG'">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" ConnectionString="<%$ ConnectionStrings:LISConnectionString %>"
            SelectCommand="SELECT yhdh,yhxm FROM com_usr "></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
