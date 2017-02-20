<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YPBLFYSJ.aspx.cs" Inherits="Project.WebUi.AdverseEvent.YPBLFYSJ"
     %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>药品不良反应事件</title>
    <meta id="IE8CompatibilityMeta" http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <script type="text/javascript">
        function OnSubmit(s, e) {
            if (ASPxClientEdit.ValidateGroup("pageVG")) {
                if (gridMedi.GetVisibleRowsOnPage() > 0) {
                    cp.PerformCallback();
                }
                else {
                    alert('药品基本信息必须填！');
                }
            }
        }
        function OngridendCallback(s, e) {
            if (s.cpSaveFlag != undefined) {
                if (s.cpSaveFlag) {
                    ASPxClientEdit.ClearEditorsInContainer(null);
                    gridParty.Refresh();
                    gridMedi.Refresh();
                    alert('提交成功！');
                    //gridParty.CancelEdit();
                }
                else {
                    alert('提交失败，认真检查所填项后,请重新提交！')
                }
            }
        }
        function toggle(s) {
            var oDiv = document.getElementById(s);
            oDiv.style.display = (oDiv.style.display == "none") ? "block" : "none";
        }
        function gridBatchEditConfirmShowing(s, e) {
            if (e.requestTriggerID == 'cp') {
                //                alert(e.requestTriggerID);
                e.cancel = true;
            }
        }
        function ddColseUp(s, e) {
            if (s.GetText().length < 2) {
            } else {
                if (s.GetSelectedItem() != null) {
                    s.SetValue(s.GetSelectedItem().GetColumnText("DeptName"));
                    //s.SetText(s.GetSelectedItem().GetColumnText("DeptName"));
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

        function OnCheckedChanged(s, e) {
            var se;
            for (var i = 0; i < s.GetNodeCount(); i++) {
                for (var j = 0; j < s.GetNode(i).GetNodeCount(); j++) {
                    if (s.GetNode(i).GetNode(j).GetChecked()) {
                        se = s.GetNode(i).GetNode(j);
                        se.SetChecked(false);
                    }
                }

            }
            e.node.SetChecked(true);
            s.SetSelectedNode(e.node);
        }

        function OnNodeClick(s, e) {
            for (var i = 0; i < s.GetNodeCount(); i++) {
                for (var j = 0; j < s.GetNode(i).GetNodeCount(); j++) {
                    if (s.GetNode(i).GetNode(j).GetChecked()) {
                        se = s.GetNode(i).GetNode(j);
                        se.SetChecked(false);
                    }
                }
                e.node.SetChecked(true);
                s.SetSelectedNode(e.node);
            }
        }

        function OnETypeNodeClick(s, e) {
            if (e.node.parent == null) {
                e.node.SetExpanded(true);
            }
            else {
                ddEtpe.SetText(e.node.parent.GetText() + "-" + e.node.GetText());
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceKS" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
        SelectCommand=" DECLARE @rootDeptID int ; SELECT  @rootDeptID = DeptId FROM Department WHERE ParentDeptID='-1'; SELECT * FROM Department WHERE ParentDeptID=@rootDeptID;">
    </asp:SqlDataSource>
    <dx:ASPxCallbackPanel ID="cp" ClientInstanceName="cp" runat="server" OnCallback="cp_Callback">
        <ClientSideEvents EndCallback="OngridendCallback" />
        <PanelCollection>
            <dx:PanelContent ID="PanelContent1" runat="server">
                <div  style="text-align: center;">
                    <h2 style="color: #4D4D4D;margin-top: 50px;margin-bottom: 20px;font-size: 24px;">
                        药品不良反应事件</h2>
                </div>
                <div id="header1" class="page-header" onclick="toggle('sectionDIV1')">
                    患者基本情况(若不涉及患者，此项不填)
                </div>
                <div id="sectionDIV1" class="header-section">
                    <table class="custom">
                        <tr>
                            <td class="td_leftcol1">
                                住院号
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxHID" runat="server" Width="170px" NullText="必须为8位数字">
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RegularExpression ValidationExpression="\d{8}" />
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                患者姓名
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxPName" runat="server" Width="170px">
                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                性别
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxSex" runat="server" ValueType="System.String" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="男" Value="男" />
                                        <dx:ListEditItem Text="女" Value="女" />
                                    </Items>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                年龄
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxAge" runat="server" Width="170px">
                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                职别
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxJob" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                体重
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxPWeight" runat="server" Width="170px">
                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                民族
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxNa" runat="server" Width="170px">
                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                临床诊断
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxCDia" runat="server" Width="100%">
                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                联系方式
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxPContact" runat="server" Width="170px">
                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                相关重要信息
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxReInfo" runat="server" ValueType="System.String"
                                    DropDownStyle="DropDown" NullText="--请选择或输入--">
                                    <Items>
                                        <dx:ListEditItem Text="吸烟史" Value="吸烟史" />
                                        <dx:ListEditItem Text="饮酒史" Value="饮酒史" />
                                        <dx:ListEditItem Text="妊娠史" Value="妊娠史" />
                                        <dx:ListEditItem Text="肝病史" Value="肝病史" />
                                        <dx:ListEditItem Text="肾病史" Value="肾病史" />
                                        <dx:ListEditItem Text="过敏史" Value="过敏史" />
                                    </Items>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                家族药品不良反应
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxJZYPBLFY" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="有" Value="有" />
                                        <dx:ListEditItem Text="无" Value="无" />
                                        <dx:ListEditItem Text="不详" Value="不详" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                既往药品不良反应情况
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxJWYPBLFY" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="有" Value="有" />
                                        <dx:ListEditItem Text="无" Value="无" />
                                        <dx:ListEditItem Text="不详" Value="不详" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="header6" class="page-header" onclick="toggle('sectionDIV6')">
                    药品基本情况
                </div>
                <div id="sectionDIV6" class="header-section">
                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridMedi"
                        KeyFieldName="MedicineID" Width="100%" DataSourceID="SqlDataSourceMedi">
                        <ClientSideEvents BatchEditConfirmShowing="gridBatchEditConfirmShowing" />
                        <Columns>
                            <dx:GridViewCommandColumn ShowInCustomizationForm="True" ShowNewButtonInHeader="True"
                                VisibleIndex="0" ShowDeleteButton="True">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn Caption="通用名称" ShowInCustomizationForm="True" VisibleIndex="1"
                                FieldName="MediCommonName">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="用药原因" ShowInCustomizationForm="True" VisibleIndex="8"
                                FieldName="Reason">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="用药剂量" ShowInCustomizationForm="True" VisibleIndex="9"
                                FieldName="Dosage">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="用药频次" ShowInCustomizationForm="True" VisibleIndex="10"
                                FieldName="Frequency">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="给药途径" ShowInCustomizationForm="True" VisibleIndex="11"
                                FieldName="Route">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="生产厂家" ShowInCustomizationForm="True" VisibleIndex="5"
                                FieldName="Company">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="生产批号" ShowInCustomizationForm="True" VisibleIndex="6"
                                FieldName="ProuductBatch">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataComboBoxColumn Caption="怀疑并用" FieldName="WithSuspected" ShowInCustomizationForm="True"
                                VisibleIndex="16">
                                <PropertiesComboBox>
                                    <Items>
                                        <dx:ListEditItem Text="怀疑用药" Value="1" />
                                        <dx:ListEditItem Text="并用用药" Value="2" />
                                    </Items>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="True"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTimeEditColumn Caption="起始时间" FieldName="StartTime" ShowInCustomizationForm="True"
                                Width="139px" VisibleIndex="13">
                                <PropertiesTimeEdit DisplayFormatInEditMode="True" EditFormat="DateTime" DisplayFormatString="G"
                                    EditFormatString="G">
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="True"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTimeEditColumn Caption="终止时间" FieldName="EndTime" ShowInCustomizationForm="True"
                                Width="139px" VisibleIndex="15">
                                <PropertiesTimeEdit DisplayFormatInEditMode="True" EditFormat="DateTime" DisplayFormatString="G"
                                    EditFormatString="G">
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="True"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTextColumn Caption="批准文号" FieldName="ApprovalNumber" 
                                ShowInCustomizationForm="True" VisibleIndex="7">
                                <PropertiesTextEdit>
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                        SetFocusOnError="true">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsBehavior ColumnResizeMode="Control" AllowDragDrop="False" AllowSort="False" />
                        <SettingsEditing Mode="Batch">
                        </SettingsEditing>
                        <Settings ShowStatusBar="Hidden" ColumnMinWidth="70" />
                        <SettingsText CommandNew="新增" CommandBatchEditUpdate="保存" CommandDelete="删除" ConfirmOnLosingBatchChanges="药品基本情况尚未保存"
                            EmptyDataRow="空" />
                        <SettingsDataSecurity AllowEdit="False" />
                        <Styles>
                            <Header HorizontalAlign="Center">
                            </Header>
                        </Styles>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSourceMedi" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
                        OnInserting="SqlDataSourceMedi_Inserting" SelectCommand="SELECT * FROM [AE_MedicationInfo] WHERE baseEventID = -1"
                        InsertCommand="INSERT INTO AE_MedicationInfo(MediCommonName, MediProductName, Company, ProuductBatch,ApprovalNumber,Reason,Dosage, Frequency, Route, StartTime, EndTime,WithSuspected, baseEventID) VALUES (@MediCommonName, @MediProductName, @Company,@ProuductBatch,@ApprovalNumber,@Reason, @Dosage, @Frequency, @Route, @StartTime, @EndTime,@WithSuspected,@baseEventID)">
                        <InsertParameters>
                            <asp:Parameter Name="MediCommonName" />
                            <asp:Parameter Name="MediProductName" />
                            <asp:Parameter Name="Company" />
                            <asp:Parameter Name="ProuductBatch" />
                            <asp:Parameter Name="ApprovalNumber" />
                            <asp:Parameter Name="Reason" />
                            <asp:Parameter Name="Dosage" />
                            <asp:Parameter Name="Frequency" />
                            <asp:Parameter Name="Route" />
                            <asp:Parameter Name="StartTime" />
                            <asp:Parameter Name="EndTime" />
                            <asp:Parameter Name="WithSuspected" />
                            <asp:Parameter Name="baseEventID" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </div>
                <div id="header2" class="page-header" onclick="toggle('sectionDIV2')">
                   事件基本情况
                </div>
                <div id="sectionDIV2" class="header-section">
                    <table class="custom">
                        <tr>
                            <td class="td_leftcol1">
                                报告时间
                            </td>
                            <td style="width: 170px" class="td_right">
                                <dx:ASPxTimeEdit ID="ASPxTimeEditReport" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss" Enabled="False">
                                </dx:ASPxTimeEdit>
                            </td>
                            <td class="td_leftcol2">
                                事件发生时间
                            </td>
                            <td class="td_right">
                                <dx:ASPxTimeEdit ID="ASPxTimeEditOccur" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTimeEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件类型
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxEType" runat="server" Width="100%" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="新的" Value="新的" />
                                        <dx:ListEditItem Text="严重" Value="严重" />
                                        <dx:ListEditItem Text="一般" Value="一般" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                不良反应/事件结果
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxEResult" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="痊愈" Value="痊愈" />
                                        <dx:ListEditItem Text="好转" Value="好转" />
                                        <dx:ListEditItem Text="未好转" Value="未好转" />
                                        <dx:ListEditItem Text="死亡" Value="死亡" />
                                        <dx:ListEditItem Text="有后遗症" Value="有后遗症" />
                                        <dx:ListEditItem Text="不详" Value="不详" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                停药或减量后反应/事件是否消失或减轻
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxTYJLFY" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="是" Value="是" />
                                        <dx:ListEditItem Text="否" Value="否" />
                                        <dx:ListEditItem Text="不明" Value="不明" />
                                        <dx:ListEditItem Text="未停药或未减量" Value="未停药或未减量" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                再次使用可疑药是否再次出现同样反应
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxZCSYFY" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="是" Value="是" />
                                        <dx:ListEditItem Text="否" Value="否" />
                                        <dx:ListEditItem Text="不明" Value="不明" />
                                        <dx:ListEditItem Text="未再使用" Value="未再使用" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                对原患疾病的影响
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxDYHJBYX" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="不明显" Value="不明显" />
                                        <dx:ListEditItem Text="病程延长" Value="病程延长" />
                                        <dx:ListEditItem Text="病情加重" Value="病情加重" />
                                        <dx:ListEditItem Text="导致后遗症" Value="导致后遗症" />
                                        <dx:ListEditItem Text="导致死亡" Value="导致死亡" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                关联性评价
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxGLXPJ" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="肯定" Value="肯定" />
                                        <dx:ListEditItem Text="很可能" Value="很可能" />
                                        <dx:ListEditItem Text="可能" Value="可能" />
                                        <dx:ListEditItem Text="可能无关" Value="可能无关" />
                                        <dx:ListEditItem Text="待评价" Value="待评价" />
                                        <dx:ListEditItem Text="无法评价" Value="无法评价" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件发生科室
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxPDept" runat="server" ClientInstanceName="brks"
                                    DataSourceID="SqlDataSourceKS" TextFormatString="{0}" DisplayFormatString="{1}" CallbackPageSize="10" EnableCallbackMode="True"
                                    AllowMouseWheel="False" IncrementalFilteringMode="StartsWith" FilterMinLength="2"
                                    TextField="DeptName" ValueField="DeptId" ValueType="System.String" NullText="--拼音检索--">
                                    <ClientSideEvents  KeyUp="ddKeyUp" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="DeptPYM" />
                                        <dx:ListBoxColumn FieldName="DeptName" />
                                    </Columns>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                事件发生场所
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxSite" runat="server" ValueType="System.String" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="门诊" Value="门诊" />
                                        <dx:ListEditItem Text="急诊" Value="急诊" />
                                        <dx:ListEditItem Text="住院" Value="住院" />
                                        <dx:ListEditItem Text="医技科室" Value="医技科室" />
                                        <dx:ListEditItem Text="手术麻醉" Value="手术麻醉" />
                                        <dx:ListEditItem Text="产房" Value="产房" />
                                        <dx:ListEditItem Text="公共活动区" Value="公共活动区" />
                                        <dx:ListEditItem Text="其他场所" Value="其他场所" />
                                        <dx:ListEditItem Text="场所不明" Value="场所不明" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件描述
                            </td>
                            <td colspan="3" style="border: 2px solid #a1a7ab;">
                                <dx:ASPxMemo ID="ASPxMemoDetails" runat="server" Height="71px" Width="100%">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxMemo>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                处理措施
                            </td>
                            <td colspan="3" style="border: 2px solid #a1a7ab;">
                                <dx:ASPxMemo ID="ASPxMemoMeasures" runat="server" Height="71px" Width="100%">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxMemo>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件等级
                            </td>
                            <td colspan="3" style="border: 2px solid #a1a7ab;">
                                <div style="width: 522px;">
                                    <dx:ASPxRadioButtonList ID="ASPxRadioButtonList1" runat="server" Width="100%">
                                        <Items>
                                            <dx:ListEditItem Text="Ⅰ级事件（警训事件）—非预期的死亡，或是非疾病自然进展过程中造成永久性功能丧失，手术错误等。" Value="Ⅰ级事件（警训事件）—非预期的死亡，或是非疾病自然进展过程中造成永久性功能丧失，手术错误等。" />
                                            <dx:ListEditItem Text="Ⅱ级事件（不良后果事件）—在疾病医疗过程中是因诊疗活动而非疾病本身造成的病人机体与功能损害，及造成同等后果的其他同级事件。"
                                                Value="Ⅱ级事件（不良后果事件）—在疾病医疗过程中是因诊疗活动而非疾病本身造成的病人机体与功能损害，及造成同等后果的其他同级事件。" />
                                            <dx:ListEditItem Text="Ⅲ级事件（未造成后果事件）—虽然发生了错误事实，但未给病人机体与功能造成任何损害，或有轻微后果而不需要任何处理可完全康复，及其他同级事件。"
                                                Value="Ⅲ级事件（未造成后果事件）—虽然发生了错误事实，但未给病人机体与功能造成任何损害，或有轻微后果而不需要任何处理可完全康复，及其他同级事件。" />
                                            <dx:ListEditItem Text="Ⅳ级事件（临界错误事件）—由于及时发现，错误在对患者实施之前被发现并得到纠正，患者最终没有得到错误的医疗护理服务，及其他同级事件"
                                                Value="Ⅳ级事件（临界错误事件）—由于及时发现，错误在对患者实施之前被发现并得到纠正，患者最终没有得到错误的医疗护理服务，及其他同级事件" />
                                        </Items>
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ValidationGroup="pageVG">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        <Border BorderWidth="0px" />
                                    </dx:ASPxRadioButtonList>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="header3" class="page-header" onclick="toggle('sectionDIV3')">
                    当事人基本情况（有明确当事人请填写；无明确当事人此项不填）
                </div>
                <div id="sectionDIV3" class="header-section">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridParty"
                        DataSourceID="SqlDataSourceParty" KeyFieldName="partyID;baseEventID" Width="100%">
                        <ClientSideEvents BatchEditConfirmShowing="gridBatchEditConfirmShowing" />
                        <Columns>
                            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowInCustomizationForm="True"
                                ShowNewButtonInHeader="True" VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataComboBoxColumn Caption="所在科室" FieldName="dClinicalDept" ShowInCustomizationForm="True"
                                VisibleIndex="3">
                                <PropertiesComboBox TextField="DeptName" ValueField="DeptId" ValueType="System.String"
                                     CallbackPageSize="10" EnableCallbackMode="True" AllowMouseWheel="false"
                                    DataSourceID="SqlDataSourceKS" Width="120px" IncrementalFilteringMode="StartsWith"
                                    FilterMinLength="2" NullText="--请选择--">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="DeptPYM" />
                                        <dx:ListBoxColumn FieldName="DeptName" />
                                    </Columns>
                                    <ClientSideEvents  KeyUp="ddKeyUp" />
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataComboBoxColumn Caption="岗位类别" FieldName="dPostCategory" ShowInCustomizationForm="True"
                                VisibleIndex="5">
                                <PropertiesComboBox NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="医疗" Value="医疗" />
                                        <dx:ListEditItem Text="护理" Value="护理" />
                                        <dx:ListEditItem Text="医技" Value="医技" />
                                        <dx:ListEditItem Text="工程技术" Value="工程技术" />
                                        <dx:ListEditItem Text="其他" Value="其他" />
                                    </Items>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataComboBoxColumn Caption="人员类别" FieldName="dPersonCategory" ShowInCustomizationForm="True"
                                VisibleIndex="7">
                                <PropertiesComboBox NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="本院" Value="本院" />
                                        <dx:ListEditItem Text="学生" Value="学生" />
                                        <dx:ListEditItem Text="物业" Value="物业" />
                                        <dx:ListEditItem Text="其他" Value="其他" />
                                    </Items>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataComboBoxColumn Caption="技术类别" FieldName="dTechCategory" ShowInCustomizationForm="True"
                                VisibleIndex="9">
                                <PropertiesComboBox NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="高级" Value="高级" />
                                        <dx:ListEditItem Text="中级" Value="中级" />
                                        <dx:ListEditItem Text="初级" Value="初级" />
                                        <dx:ListEditItem Text="士级" Value="士级" />
                                        <dx:ListEditItem Text="实习生" Value="实习生" />
                                        <dx:ListEditItem Text="见习生" Value="见习生" />
                                        <dx:ListEditItem Text="进修生" Value="进修生" />
                                        <dx:ListEditItem Text="研究生" Value="研究生" />
                                    </Items>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn Caption="工作年限" FieldName="dWorkYears" ShowInCustomizationForm="True"
                                VisibleIndex="11">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsBehavior AllowDragDrop="False" AllowSort="False" />
                        <SettingsEditing Mode="Batch">
                        </SettingsEditing>
                        <Settings ShowStatusBar="Hidden" />
                        <SettingsText CommandBatchEditCancel="取消" CommandBatchEditUpdate="保存" CommandDelete="删除"
                            CommandNew="新增" ConfirmOnLosingBatchChanges="当事人基本情况尚未保存" EmptyDataRow="空" />
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSourceParty" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
                        SelectCommand="SELECT * FROM [AE_PartyInfo] WHERE baseEventID = -1 " DeleteCommand="DELETE FROM AE_PartyInfo WHERE (partyID = @partyID)"
                        InsertCommand="INSERT INTO AE_PartyInfo(baseEventID, dClinicalDept, dPostCategory, dPersonCategory, dTechCategory,dWorkYears) VALUES (@baseEventID,@dClinicalDept ,@dPostCategory, @dPersonCategory,@dTechCategory,@dWorkYears)"
                        UpdateCommand="UPDATE AE_PartyInfo SET dClinicalDept =@dClinicalDept, dPostCategory =@dPostCategory , dPersonCategory =@dPersonCategory , dTechCategory =@dTechCategory , dWorkYears =@dWorkYears  WHERE (partyID = @partyID) "
                        OnInserting="SqlDataSourceParty_Inserting">
                        <InsertParameters>
                            <asp:Parameter Name="baseEventID" DbType="Int32" />
                            <asp:Parameter Name="dClinicalDept" />
                            <asp:Parameter Name="dPostCategory" />
                            <asp:Parameter Name="dPersonCategory" />
                            <asp:Parameter Name="dTechCategory" />
                            <asp:Parameter Name="dWorkYears" />
                        </InsertParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="partyID" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="partyID" />
                            <asp:Parameter Name="dClinicalDept" />
                            <asp:Parameter Name="dPostCategory" />
                            <asp:Parameter Name="dPersonCategory" />
                            <asp:Parameter Name="dTechCategory" />
                            <asp:Parameter Name="dWorkYears" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <div id="header5" class="page-header" >
                    报告人基本情况
                </div>
                <div id="sectionDIV5" class="header-section">
                    <table class="custom">
                        <tr>
                            <td class="td_leftcol1">
                                所在科室
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxRDept" runat="server" ClientInstanceName="bgrks"
                                    DataSourceID="SqlDataSourceKS" TextFormatString="{0}" DisplayFormatString="{1}" CallbackPageSize="10" EnableCallbackMode="True"
                                    AllowMouseWheel="False" IncrementalFilteringMode="StartsWith" FilterMinLength="2"
                                    TextField="DeptName" ValueField="DeptId" ValueType="System.String" NullText="--拼音检索--">
                                    <ClientSideEvents  KeyUp="ddKeyUp" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="DeptPYM" />
                                        <dx:ListBoxColumn FieldName="DeptName" />
                                    </Columns>
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG" SetFocusOnError="true">
                                        <RequiredField IsRequired="true" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                岗位类别
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxPost" runat="server" ValueType="System.String" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="医疗" Value="医疗" />
                                        <dx:ListEditItem Text="护理" Value="护理" />
                                        <dx:ListEditItem Text="医技" Value="医技" />
                                        <dx:ListEditItem Text="工程技术" Value="工程技术" />
                                        <dx:ListEditItem Text="其他" Value="其他" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                人员类别
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxPer" runat="server" ValueType="System.String" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="本院" Value="本院" />
                                        <dx:ListEditItem Text="学生" Value="学生" />
                                        <dx:ListEditItem Text="物业" Value="物业" />
                                        <dx:ListEditItem Text="其他" Value="其他" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                技术类别
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxTech" runat="server" ValueType="System.String" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="高级" Value="高级" />
                                        <dx:ListEditItem Text="中级" Value="中级" />
                                        <dx:ListEditItem Text="初级" Value="初级" />
                                        <dx:ListEditItem Text="士级" Value="士级" />
                                        <dx:ListEditItem Text="实习生" Value="实习生" />
                                        <dx:ListEditItem Text="见习生" Value="见习生" />
                                        <dx:ListEditItem Text="进修生" Value="进修生" />
                                        <dx:ListEditItem Text="研究生" Value="研究生" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                工作年限
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxWorkY" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                联系方式
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxrContact" runat="server" Width="170px">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="header-section" style="border-top: 0; text-align: center;">
                    <dx:ASPxButton ID="ASPxButtonSubmit" runat="server" ClientInstanceName="ASPxButtonSubmit"
                        AutoPostBack="false" Text="提交">
                        <ClientSideEvents Click="OnSubmit" />
                    </dx:ASPxButton>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    </form>
</body>
</html>
