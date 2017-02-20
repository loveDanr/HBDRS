<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QTJJCS.aspx.cs" Inherits="Project.WebUi.GRKHJJC.QTJJCS"
     %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>其他洁净场所空气监测</title>
    <script type="text/javascript">
       
        //使 comboBox中的某列值 赋给 gridView中某列值
        function OnSelectedIndexChanged(s, e) {
            gvDetails.GetEditor("ItemGrade").SetValue(s.GetSelectedItem().GetColumnText("xmmc"));
            gvDetails.GetEditor("Reference").SetValue(s.GetSelectedItem().GetColumnText("zxbz"));
            gvDetails.GetEditor("ItemGrade").SetText(s.GetSelectedItem().GetColumnText("xmmc"));

        }

        function ddColseUp(s, e) {
            if (s.GetText().length < 2) {
            } else {
                if (s.GetSelectedItem() != null) {
                    //s.SetValue(s.GetSelectedItem().GetColumnText("DeptName"));
                    s.SetText(s.GetSelectedItem().GetColumnText("zdmc"));
                    //s.SetText(s.GetValue());

                }
            }
        }

        function ddKeyUp(s, e) {
            var keycode = e.htmlEvent.keyCode;
            if (keycode == 8) {
                s.SetSelectedIndex(-1);
                s.SetText();
            }
        }

        function OnGridEndCallback(s, e) {
            if (s.cpEditEnabled != undefined) {
                if (!s.cpEditEnabled) {
                    s.cpEditEnabled = true;
                    alert("已出报告，不能修改！");
                }
            }
        }
        function grid_RowDblClick(s, e) {
            var key = s.GetRowKey(e.visibleIndex);
            var nurl = "./QTJJCSbgsh.aspx?id=" + key;
            popupWin.SetContentUrl(nurl);
            popupWin.Show();
        }
        function HidePopupWin() {
            popupWin.Hide();
        }
        function OnCloseUp(s, e) {
            gridMaster.Refresh();
        }
        function OnPClosing(s, e) {
            //popupWin.GetContentIFrame().contentWindow.window.close();
            //popupWin.GetContentIFrame().contentWindow.gvDetails.CancelEdit();

        }
        function OnCBtnC(s, e) {
            popupWin.GetContentIFrame().contentWindow.gvDetails.CancelEdit();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center">
            <tr>
                <td>
                    开始时间
                </td>
                <td>
                    <dx:ASPxTimeEdit ID="ASPxTimeEditStart" runat="server" DisplayFormatString="yyyy-MM-dd"
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd" Width="90px">
                    </dx:ASPxTimeEdit>
                </td>
                <td>
                    结束时间
                </td>
                <td>
                    <dx:ASPxTimeEdit ID="ASPxTimeEditEnd" runat="server" DisplayFormatString="yyyy-MM-dd"
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd" Width="90px">
                    </dx:ASPxTimeEdit>
                </td>
                <td>
                    <dx:ASPxButton ID="ASPxButtonQuery" runat="server" Text="查询" OnClick="ASPxButtonQuery_Click">
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
        <dx:ASPxGridView ID="ASPxGridViewMaster" runat="server" AutoGenerateColumns="False" Width="100%" 
            ClientInstanceName="gridMaster" KeyFieldName="ReportID" DataSourceID="SqlDataSourceReport"
             OnHeaderFilterFillItems="ASPxGridViewMaster_HeaderFilterFillItems"
            OnStartRowEditing="ASPxGridViewMaster_StartRowEditing" onhtmlrowprepared="ASPxGridViewMaster_HtmlRowPrepared">
            <ClientSideEvents EndCallback="OnGridEndCallback" />
            <Columns>
                <dx:GridViewCommandColumn Caption="操作" VisibleIndex="0" ShowEditButton="true" ShowNewButtonInHeader="True" ShowDeleteButton="true">  
                </dx:GridViewCommandColumn>
                <dx:GridViewDataHyperLinkColumn Caption="打印报告单" VisibleIndex="1" FieldName="ReportID">
                    <PropertiesHyperLinkEdit Text="打印报告单" NavigateUrlFormatString="QTJJCSReport.aspx?id={0}"
                        Target="_blank">
                    </PropertiesHyperLinkEdit>
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataHyperLinkColumn>
                <%-- <dx:GridViewDataTextColumn Caption="科别" FieldName="DeptID" VisibleIndex="1">
                    <EditItemTemplate>
                        <dx:ASPxComboBox runat="server" ID="ASPxComboBoxDept" ValueType="System.String" CallbackPageSize="10"
                            EnableCallbackMode="true" TextFormatString="{0}" DisplayFormatString="{1}" AllowMouseWheel="False"
                            IncrementalFilteringMode="StartsWith" FilterMinLength="2" TextField="zdmc" ValueField="zddh"
                            Value='<%#Bind("DeptID") %>' DataSourceID="SqlDataSourceGRKdept">
                            <ClientSideEvents KeyUp="ddKeyUp" CloseUp="ddColseUp" />
                            <Columns>
                                <dx:ListBoxColumn FieldName="zddh" />
                                <dx:ListBoxColumn FieldName="zdmc" />
                            </Columns>
                        </dx:ASPxComboBox>
                    </EditItemTemplate>
                </dx:GridViewDataTextColumn>--%>
                <dx:GridViewDataComboBoxColumn Caption="科别" FieldName="DeptID" VisibleIndex="2">
                    <PropertiesComboBox ValueType="System.String" CallbackPageSize="10" EnableCallbackMode="true"
                        ClientInstanceName="cbDept" TextFormatString="{1}({0})" 
                        AllowMouseWheel="False" IncrementalFilteringMode="Contains" FilterMinLength="2"
                        TextField="zdmc" ValueField="zddh" DataSourceID="SqlDataSourceGRKdept">
                        <ClientSideEvents KeyUp="ddKeyUp"  />
                        <Columns>
                            <dx:ListBoxColumn FieldName="zddh" />
                            <dx:ListBoxColumn FieldName="zdmc" />
                        </Columns>
                    </PropertiesComboBox>
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataComboBoxColumn Caption="洁净度级别" FieldName="Grade" VisibleIndex="3"
                    Visible="False">
                    <PropertiesComboBox ValueType="System.String">
                        <Items>
                            <dx:ListEditItem Text="I级" Value="I级" />
                            <dx:ListEditItem Text="II级" Value="II级" />
                            <dx:ListEditItem Text="III级" Value="III级" />
                            <dx:ListEditItem Text="IV级" Value="IV级" />
                        </Items>
                    </PropertiesComboBox>
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn Caption="采集位点" FieldName="LabSite" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="标本" FieldName="LabSample" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="检验目的" FieldName="LabObject" VisibleIndex="6">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn Caption="送检者" FieldName="Transportor" VisibleIndex="7">
                    <PropertiesComboBox ValueType="System.String" CallbackPageSize="10" EnableCallbackMode="true"
                        ClientInstanceName="cbUserT" TextFormatString="{0}({1})"
                        AllowMouseWheel="False" IncrementalFilteringMode="StartsWith" FilterMinLength="2"
                        TextField="yhdh" ValueField="yhxm" DataSourceID="SqlDataSourceUser" DropDownStyle="DropDown">
                        <ClientSideEvents KeyUp="ddKeyUp"  />
                        <Columns>
                            <dx:ListBoxColumn FieldName="yhdh" />
                            <dx:ListBoxColumn FieldName="yhxm" />
                        </Columns>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataDateColumn Caption="送检日期" FieldName="TransportDate" VisibleIndex="8">
                    <PropertiesDateEdit DisplayFormatString="d">
                        <CalendarProperties ClearButtonText="清除" TodayButtonText="今天">
                        </CalendarProperties>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataComboBoxColumn Caption="报告者" FieldName="Reportor" VisibleIndex="9">
                    <PropertiesComboBox ValueType="System.String" CallbackPageSize="10" EnableCallbackMode="true"
                        ClientInstanceName="cbUserR" TextFormatString="{0}({1})" 
                        AllowMouseWheel="False" IncrementalFilteringMode="StartsWith" FilterMinLength="2"
                        TextField="yhdh" ValueField="yhxm" DataSourceID="SqlDataSourceUser" DropDownStyle="DropDown">
                        <ClientSideEvents KeyUp="ddKeyUp"  />
                        <Columns>
                            <dx:ListBoxColumn FieldName="yhdh" />
                            <dx:ListBoxColumn FieldName="yhxm" />
                        </Columns>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataDateColumn Caption="报告日期" FieldName="ReportDate" VisibleIndex="10" SortIndex="1" SortOrder="Descending">
                    <PropertiesDateEdit DisplayFormatString="d">
                        <CalendarProperties ClearButtonText="清除" TodayButtonText="今天">
                        </CalendarProperties>
                        <ValidationSettings>
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesDateEdit>
                    <Settings AllowSort="True" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataComboBoxColumn Caption="核对者" FieldName="Checkor" VisibleIndex="11">
                    <PropertiesComboBox ValueType="System.String" CallbackPageSize="10" EnableCallbackMode="true"
                        ClientInstanceName="cbUserC" TextFormatString="{0}({1})" 
                        AllowMouseWheel="False" IncrementalFilteringMode="StartsWith" FilterMinLength="2"
                        TextField="yhdh" ValueField="yhxm" DataSourceID="SqlDataSourceUser" DropDownStyle="DropDown">
                        <ClientSideEvents KeyUp="ddKeyUp"  />
                        <Columns>
                            <dx:ListBoxColumn FieldName="yhdh" />
                            <dx:ListBoxColumn FieldName="yhxm" />
                        </Columns>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
            </Columns>
            <SettingsBehavior ConfirmDelete="True" AllowSort="False" />
            <SettingsPager PageSize="20" AlwaysShowPager="True">
            </SettingsPager>
            <SettingsText CommandDelete="删除" CommandEdit="编辑" CommandNew="新增" CommandCancel="取消"
                CommandUpdate="保存" ConfirmDelete="确定删除吗？" />
           <%-- <SettingsDetail ShowDetailRow="True" />
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="ASPxGridViewDetails" runat="server" AutoGenerateColumns="False" Width="100%" 
                        Width="70%" ClientInstanceName="gvDetails" KeyFieldName="ItemID" DataSourceID="SqlDataSourceItem"
                        OnBeforePerformDataSelect="ASPxGridViewDetails_BeforePerformDataSelect" OnRowInserting="ASPxGridViewDetails_RowInserting"
                        OnHtmlDataCellPrepared="ASPxGridViewDetails_HtmlDataCellPrepared" OnLoad="ASPxGridViewDetails_Load">
                        <Columns>
                            <dx:GridViewCommandColumn Caption="操作" VisibleIndex="0">
                                
                                
                                
                                
                                
                                
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataComboBoxColumn Caption="洁净度级别" FieldName="ItemGrade" VisibleIndex="1">
                                <PropertiesComboBox ValueType="System.String" CallbackPageSize="10" EnableCallbackMode="true"
                                    AllowMouseWheel="False" IncrementalFilteringMode="StartsWith" TextFormatString="{0}"
                                    DisplayFormatString="{1}" FilterMinLength="2" TextField="xmdh" ValueField="xmmc"
                                    DataSourceID="SqlDataSourceJYItem">
                                    <ClientSideEvents KeyUp="ddKeyUp" SelectedIndexChanged="OnSelectedIndexChanged" Init="OnComboItemGrade" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="xmdh" />
                                        <dx:ListBoxColumn FieldName="xmmc" />
                                        <dx:ListBoxColumn FieldName="zxbz" />
                                    </Columns>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn Caption="监测结果" FieldName="MonitorRes" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="参考值" FieldName="Reference" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsBehavior ConfirmDelete="True" />
                        <SettingsText CommandCancel="取消" CommandDelete="删除" CommandEdit="编辑" CommandNew="新增"
                            CommandUpdate="保存" ConfirmDelete="确定删除吗？" />
                    </dx:ASPxGridView>
                </DetailRow>
            </Templates>--%>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSourceGRKdept" runat="server" ConnectionString="<%$ ConnectionStrings:LISConnectionString %>"
            SelectCommand="  SELECT    zddh ,zdmc FROM  com_dict WHERE     ( zdlb = 'DP' )   ">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceReport" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT [ReportID], [DeptID], [LabSite],  [LabSample], [LabObject], [Transportor], [TransportDate], [Reportor], [ReportDate], [Checkor] FROM [GRK_JYBG] WHERE ReportCategory='QTJJCS' AND TransportDate&gt;=@startDate AND TransportDate&lt;=@endDate "
            InsertCommand="INSERT INTO GRK_JYBG(DeptID, LabSite,  LabSample, Transportor, TransportDate, Reportor, ReportDate, Checkor,ReportCategory) VALUES (@DeptID,@LabSite,@LabSample,@Transportor,@TransportDate,@Reportor,@ReportDate,@Checkor,'QTJJCS')"
            UpdateCommand="UPDATE GRK_JYBG SET DeptID =@DeptID, LabSite =@LabSite, LabSample =@LabSample, Transportor =@Transportor, TransportDate =@TransportDate, Reportor =@Reportor, ReportDate =@ReportDate, Checkor =@Checkor WHERE ReportID = @ReportID"
            DeleteCommand="DELETE GRK_JYBG WHERE ReportID=@ReportID">
            <InsertParameters>
                <asp:Parameter Name="DeptID" />
                <asp:Parameter Name="LabSite" />
                <asp:Parameter Name="LabSample" />
                <asp:Parameter Name="Transportor" />
                <asp:Parameter Name="TransportDate" />
                <asp:Parameter Name="Reportor" />
                <asp:Parameter Name="ReportDate" />
                <asp:Parameter Name="Checkor" />
                <asp:Parameter Name="ReportCategory" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="DeptID" />
                <asp:Parameter Name="LabSite" />
                <asp:Parameter Name="LabSample" />
                <asp:Parameter Name="Transportor" />
                <asp:Parameter Name="TransportDate" />
                <asp:Parameter Name="Reportor" />
                <asp:Parameter Name="ReportDate" />
                <asp:Parameter Name="Checkor" />
                <asp:Parameter Name="ReportCategory" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ASPxTimeEditStart" Name="startDate" PropertyName="DateTime" />
                <asp:ControlParameter ControlID="ASPxTimeEditEnd" Name="endDate" PropertyName="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" ConnectionString="<%$ ConnectionStrings:LISConnectionString %>"
            SelectCommand="SELECT yhdh,yhxm FROM com_usr "></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceItem" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT [ItemID], [ReportID], [ItemGrade], [MonitorRes], [Reference],[RefMin],[RefMax],[stateFlag] FROM [GRK_JYBGitem] WHERE ReportID=@ReportID"
            InsertCommand="INSERT INTO GRK_JYBGitem(ReportID, ItemGrade, MonitorRes, Reference) VALUES (@ReportID,@ItemGrade,@MonitorRes,@Reference)"
            UpdateCommand="UPDATE GRK_JYBGitem SET ItemGrade =@ItemGrade, MonitorRes =@MonitorRes, Reference =@Reference WHERE ItemID=@ItemID"
            DeleteCommand="DELETE FROM GRK_JYBGitem WHERE ItemID=@ItemID">
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
        <asp:SqlDataSource ID="SqlDataSourceJYItem" runat="server" ConnectionString="<%$ ConnectionStrings:LISConnectionString %>"
            SelectCommand="SELECT xmdh,xmmc,ISNULL(dyckz,'')+ISNULL(dw,'') AS zxbz FROM xm_info WHERE yq ='QTJJCS'">
        </asp:SqlDataSource>
        <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" Width="550px" Height="500px"
            ClientInstanceName="popupWin" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
            Modal="True" CloseAction="CloseButton" HeaderText="编辑">
            <ClientSideEvents CloseUp="OnCloseUp" Closing="OnPClosing" CloseButtonClick="OnCBtnC" />
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </div>
    </form>
</body>
</html>
