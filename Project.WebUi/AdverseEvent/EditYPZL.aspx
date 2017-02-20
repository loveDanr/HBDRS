<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditYPZL.aspx.cs" Inherits="Project.WebUi.AdverseEvent.EditYPZL" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>药品质量上报事件</title>
    <link href="../css/AEstyle.css" rel="stylesheet" type="text/css" />
    <meta id="IE8CompatibilityMeta" http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <script type="text/javascript">
        function OnSubmit(s, e) {
            if (trvEGrade.GetSelectedNode() == null) { document.getElementById('cp_ASPxTreeView1').style.border = "1px solid #ff0000"; return; }
            else {
                document.getElementById('cp_ASPxTreeView1').style.border = "";
            }
            if (ASPxClientEdit.ValidateGroup("pageVG")) {
                cp.PerformCallback();
            }
        }
        function OngridendCallback(s, e) {
            if (s.cpSaveFlag != undefined) {
                if (s.cpSaveFlag) {
                    //ASPxClientEdit.ClearEditorsInContainer(null);
                    //gridParty.Refresh();
                    //gridMedi.Refresh();
                    alert('保存成功！');
                    history.back();
                    //gridParty.CancelEdit();
                }
                else {
                    alert('保存失败，认真检查所填项后,请重新保存！')
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
            //只有叶子节点可被选中
            if (e.node.GetNodeCount() > 0) { s.SetSelectedNode(null); return; }
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
        function OnLostFocus() {
            var ars = txtReason.GetText();
            if (ars == null || ars == "") {
                cited.SetEnabled(false);
                cited.SetValue(null);
            }
            else {
                cited.SetEnabled(true);
                cited.SetDate(new Date());
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
                <div class="header-section" style="text-align: center;">
                    <h2 style="color: #033E89;">
                        药品质量上报事件</h2>
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
                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG" SetFocusOnError="true">
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
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                年龄
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxAge" runat="server" Width="170px">
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
                                患者联系方式
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxPContact" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                民族
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxNa" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                临床诊断
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxCDia" runat="server" Width="100%">
                                </dx:ASPxTextBox>
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
                                FieldName="MediCommonName" Width="70px">
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
                            <dx:GridViewDataTextColumn Caption="数量" ShowInCustomizationForm="True" VisibleIndex="3"
                                FieldName="Quantity" Width="80px">
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
                            <dx:GridViewDataTextColumn Caption="批号" ShowInCustomizationForm="True" VisibleIndex="5"
                                FieldName="ProuductBatch" >
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
                            <dx:GridViewDataTextColumn Caption="包装情况" ShowInCustomizationForm="True" VisibleIndex="8"
                                FieldName="PackageType" >
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
                            <dx:GridViewDataTextColumn Caption="质量原因" ShowInCustomizationForm="True" VisibleIndex="9"
                                FieldName="Reason" >
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
                            <dx:GridViewDataTextColumn Caption="备注" ShowInCustomizationForm="True" VisibleIndex="10"
                                FieldName="Memo" Width="60px" >
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
                            <dx:GridViewDataTextColumn Caption="规格" ShowInCustomizationForm="True" VisibleIndex="2"
                                FieldName="MediSpec" >
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
                            <dx:GridViewDataTextColumn Caption="产地" ShowInCustomizationForm="True" VisibleIndex="4"
                                FieldName="Company" >
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
                            <dx:GridViewDataDateColumn Caption="有效期" FieldName="ExpDate" 
                                ShowInCustomizationForm="True" VisibleIndex="7">
                                <PropertiesDateEdit DisplayFormatString="">
                                    <InvalidStyle>
                                        <Border BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" />
                                    </InvalidStyle>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" 
                                        SetFocusOnError="True" ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                        </Columns>
                        <SettingsBehavior ColumnResizeMode="Control" AllowDragDrop="False" AllowSort="False" />
                        <SettingsEditing Mode="Batch">
                        </SettingsEditing>
                        <Settings ShowStatusBar="Hidden" ColumnMinWidth="30" />
                        <SettingsText CommandNew="新增" CommandBatchEditUpdate="保存" CommandDelete="删除" ConfirmOnLosingBatchChanges="药品基本情况尚未保存"
                            EmptyDataRow="空" />
                        <SettingsDataSecurity AllowEdit="False" />
                        <Styles>
                            <Header HorizontalAlign="Center">
                            </Header>
                        </Styles>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSourceMedi" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
                        OnInserting="SqlDataSourceMedi_Inserting" SelectCommand="SELECT * FROM [AE_MedicationInfo] WHERE baseEventID = @baseEventID"
                        InsertCommand="INSERT INTO AE_MedicationInfo(MediCommonName, Quantity, ProuductBatch, ExpDate, PackageType, Reason, Memo,  Company,  baseEventID, MediSpec) VALUES (@MediCommonName, @Quantity, @ProuductBatch, @ExpDate, @PackageType, @Reason, @Memo,  @Company,  @baseEventID, @MediSpec)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="baseEventID" QueryStringField="baseEventID" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="MediCommonName" />
                            <asp:Parameter Name="Quantity" />
                            <asp:Parameter Name="ProuductBatch" />
                            <asp:Parameter Name="ExpDate" />
                            <asp:Parameter Name="PackageType" />
                            <asp:Parameter Name="Reason" />
                            <asp:Parameter Name="Memo" />
                            <asp:Parameter Name="Company" />
                            <asp:Parameter Name="baseEventID" />
                            <asp:Parameter Name="MediSpec" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </div>
                <div id="header2" class="page-header" onclick="toggle('sectionDIV2')">
                     事件基本情况
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
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTimeEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                药品是否发给患者
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxYPSF" runat="server" ValueType="System.String" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="是" Value="是" />
                                        <dx:ListEditItem Text="否" Value="否" />
                                        <dx:ListEditItem Text="不详" Value="不详" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                患者是否使用药品
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxHZSF" runat="server" ValueType="System.String" NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="是" Value="是" />
                                        <dx:ListEditItem Text="否" Value="否" />
                                        <dx:ListEditItem Text="不详" Value="不详" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                提供药品标签、处方复印件等资料
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxYPCFZL" runat="server" ValueType="System.String"
                                    NullText="--请选择--">
                                    <Items>
                                        <dx:ListEditItem Text="是" Value="是" />
                                        <dx:ListEditItem Text="否" Value="否" />
                                        <dx:ListEditItem Text="其他" Value="其他" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="td_leftcol2">
                                事件发现时间
                            </td>
                            <td class="td_right">
                                <dx:ASPxTimeEdit ID="ASPxTimeEditDiscover" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTimeEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件发生科室
                            </td>
                            <td class="td_right">
                                <dx:ASPxComboBox ID="ASPxComboBoxPDept" runat="server" ClientInstanceName="brks"
                                    DataSourceID="SqlDataSourceKS" TextFormatString="{0}"  DisplayFormatString="{1}" CallbackPageSize="10" EnableCallbackMode="True"
                                    AllowMouseWheel="False" IncrementalFilteringMode="StartsWith" FilterMinLength="2"
                                    TextField="DeptName" ValueField="DeptId" ValueType="System.String" NullText="--拼音检索--">
                                    <ClientSideEvents  KeyUp="ddKeyUp" />
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="DeptPYM" />
                                        <dx:ListBoxColumn FieldName="DeptName" />
                                    </Columns>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
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
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件类型
                            </td>
                            <td colspan="3" style="border: 2px solid #a1a7ab;">
                                <dx:ASPxComboBox ID="ASPxComboBoxEType" runat="server" Width="100%" DropDownStyle="DropDown">
                                    <Items>
                                        <dx:ListEditItem Text="生产过程" Value="生产过程" />
                                        <dx:ListEditItem Text="运输过程" Value="运输过程" />
                                        <dx:ListEditItem Text="储存条件" Value="储存条件" />
                                        <dx:ListEditItem Text="操作环节" Value="操作环节" />
                                        <dx:ListEditItem Text="其他" Value="其他" />
                                    </Items>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxComboBox>
                                <%--<dx:ASPxDropDownEdit ID="ASPxDropDownEditEtype" runat="server" Width="100%" ClientInstanceName="ddEtpe">
                                    <DropDownWindowTemplate>
                                        <dx:ASPxTreeView ID="ASPxTreeViewEType" runat="server" AllowSelectNode="True">
                                            <ClientSideEvents NodeClick="OnETypeNodeClick" />
                                            <Nodes>
                                                <dx:TreeViewNode Text="药品">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="适应症  ">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="药名相似">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="外观相似">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="剂型">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="规格">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="分装">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="标签">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="数量">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="溶媒">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="货位相邻">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="禁忌症">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="品种">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="操作">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="给药频次">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="给药途径">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="给药技术">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="给药时间">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="给药顺序">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="医护">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="抄方">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="疲劳">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="知识欠缺">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="培训不足">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="口头遗嘱">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="其他">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="设备故障">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="疗程">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="多科室就诊">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="环境">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="患者身份">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                            </Nodes>
                                        </dx:ASPxTreeView>
                                    </DropDownWindowTemplate>
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
                                        ValidationGroup="pageVG">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxDropDownEdit>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件描述
                            </td>
                            <td colspan="3" style="border: 2px solid #a1a7ab;">
                                <dx:ASPxMemo ID="ASPxMemoDetails" runat="server" Height="71px" Width="100%">
                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
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
                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None"  SetFocusOnError="true"
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
                                    <dx:ASPxTreeView ID="ASPxTreeView1" runat="server"  Width="522px" AllowCheckNodes="True"
                                        CheckNodesRecursive="True" ShowExpandButtons="False" ShowTreeLines="False" 
                                        AllowSelectNode="True" ClientInstanceName="trvEGrade">
                                        <ClientSideEvents CheckedChanged="OnCheckedChanged" NodeClick="OnNodeClick" />
                                        <Styles>
                                            <NodeText CssClass="lm">
                                            </NodeText>
                                            <Node>
                                                <Paddings Padding="0px" />
                                                <Border BorderStyle="None" BorderWidth="0px" />
                                            </Node>
                                        </Styles>
                                        <Nodes>
                                            <dx:TreeViewNode Text="Ⅰ级事件（警训事件）" AllowCheck="False">
                                                <Nodes>
                                                    <dx:TreeViewNode Text="G类：错误导致患者永久性伤害">
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="H类：错误导致患者生命垂危">
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="I 类：错误导致患者死亡">
                                                    </dx:TreeViewNode>
                                                </Nodes>
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="Ⅱ级事件（不良后果事件）" AllowCheck="False">
                                                <Nodes>
                                                    <dx:TreeViewNode Text="E类：错误造成患者暂时性伤害，需要采取预防措施">
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="F类：错误对患者的伤害可导致住院或延长住院时间">
                                                    </dx:TreeViewNode>
                                                </Nodes>
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="Ⅲ级事件（未造成后果事件）" AllowCheck="False">
                                                <Nodes>
                                                    <dx:TreeViewNode Text="C类：患者已使用，但未造成伤害">
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="D类：患者已使用，需要监测错误对患者的后果，并根据后果判断是否需要采取措施预防和减少伤害">
                                                    </dx:TreeViewNode>
                                                </Nodes>
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="Ⅳ级事件（临界错误事件）" AllowCheck="False">
                                                <Nodes>
                                                    <dx:TreeViewNode Text="A类:：客观环境或条件可能引发错误（错误隐患）">
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="B类：发生错误但未发给患者，或者发给患者但患者未使用">
                                                    </dx:TreeViewNode>
                                                </Nodes>
                                            </dx:TreeViewNode>
                                        </Nodes>
                                        <Border BorderStyle="None" BorderWidth="0px" />
                                    </dx:ASPxTreeView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="header7" class="page-header" onclick="toggle('sectionDIV7')">
                    患者伤害情况
                </div>
                <div id="sectionDIV7" class="header-section">
                    <table class="custom">
                        <tr>
                            <td class="td_leftcol1">
                                死亡(直接原因)
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxCauseD" runat="server" ClientInstanceName="txtReason" Width="170px">
                                <ClientSideEvents LostFocus="OnLostFocus" />
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                死亡时间
                            </td>
                            <td class="td_right">
                                <dx:ASPxTimeEdit ID="ASPxTimeEditDeath" runat="server" ClientInstanceName="cited" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                                    EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss">
                                </dx:ASPxTimeEdit>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                抢救（措施）
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxResMea" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                残疾(部位\程度)
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxCJBW" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                （恢复过程）
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxRecov" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
                                暂时伤害(部位\程度)
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxZSSH" runat="server" Width="170px">
                                </dx:ASPxTextBox>
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
                        SelectCommand="SELECT * FROM [AE_PartyInfo] WHERE baseEventID = @baseEventID " DeleteCommand="DELETE FROM AE_PartyInfo WHERE (partyID = @partyID)"
                        InsertCommand="INSERT INTO AE_PartyInfo(baseEventID, dClinicalDept, dPostCategory, dPersonCategory, dTechCategory,dWorkYears) VALUES (@baseEventID,@dClinicalDept ,@dPostCategory, @dPersonCategory,@dTechCategory,@dWorkYears)"
                        UpdateCommand="UPDATE AE_PartyInfo SET dClinicalDept =@dClinicalDept, dPostCategory =@dPostCategory , dPersonCategory =@dPersonCategory , dTechCategory =@dTechCategory , dWorkYears =@dWorkYears  WHERE (partyID = @partyID) "
                        OnInserting="SqlDataSourceParty_Inserting">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="baseEventID" QueryStringField="baseEventID" />
                        </SelectParameters>
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
                <div class="header-section" style="text-align: center;">
                    <dx:ASPxButton ID="ASPxButtonSubmit" runat="server" ClientInstanceName="ASPxButtonSubmit"
                        AutoPostBack="false" Text="保存">
                        <ClientSideEvents Click="OnSubmit" />
                    </dx:ASPxButton>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    </form>
    <script type="text/javascript">
            cited.SetEnabled(false);
            cited.SetValue(null);
    </script>
</body>
</html>
