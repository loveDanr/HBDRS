<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditHLDDZC.aspx.cs" Inherits="Project.WebUi.AdverseEvent.EditHLDDZC" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>护理不良事件-跌倒/坠床</title>
    <link href="../css/AEstyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function OnSubmit(s, e) {
            //添加了 <meta ......"IE=EmulateIE8" />  trvEGrade.name 是 cp_ASPxTreeView1 否则 是 ASPxTreeView1
            if (trvEGrade.GetSelectedNode() == null) { document.getElementById(trvEGrade.name).style.border = "1px solid #ff0000"; return; }
            else {
                document.getElementById(trvEGrade.name).style.border = "";
            }
            if (ASPxClientEdit.ValidateGroup("pageVG")) {
                cp.PerformCallback();
            }
        }
        function OngridendCallback(s, e) {
            if (s.cpSaveFlag != undefined) {
                if (s.cpSaveFlag) {
                    ASPxClientEdit.ClearEditorsInContainer(null);
                    gridParty.Refresh();
                    alert('保存成功！');
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

        function OnEtypeSelectedInexChanged(s, e) {
            //lbletype.SetText(s.GetText());
            var lbls = document.getElementsByName('lbletype');
            for (i = 0; i < lbls.length; i++) {
                lbls[i].innerText = s.GetText();
            }
            //document.getElementById('lbletype').innerText = s.GetText(); 
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
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceKS" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
        SelectCommand=" DECLARE @rootDeptID int ; SELECT  @rootDeptID = DeptId FROM Department WHERE ParentDeptID='-1'; SELECT * FROM Department WHERE ParentDeptID=@rootDeptID;">
    </asp:SqlDataSource>
    <div style="margin: auto; width: 655px; text-align: center;">
        <h2 style="color: #033E89;">
            护理不良事件-跌倒/坠床</h2>
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
                    护理级别
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxNLevel" runat="server" ValueType="System.String"
                        NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="特级" Value="特级" />
                            <dx:ListEditItem Text="一级" Value="一级" />
                            <dx:ListEditItem Text="二级" Value="二级" />
                            <dx:ListEditItem Text="三级" Value="三级" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    临床诊断
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxCDia" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
            </tr>
        </table>
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
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss" Enabled="True">
                    </dx:ASPxTimeEdit>
                </td>
                <td class="td_leftcol2">
                    事件发生时间
                </td>
                <td class="td_right">
                    <dx:ASPxTimeEdit ID="ASPxTimeEditOccur" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss">
                    </dx:ASPxTimeEdit>
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
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    事件发生地点
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxSite" runat="server" ValueType="System.String" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="病室" Value="病室" />
                            <dx:ListEditItem Text="诊室" Value="诊室" />
                            <dx:ListEditItem Text="护士站" Value="护士站" />
                            <dx:ListEditItem Text="手术室" Value="手术室" />
                            <dx:ListEditItem Text="卫生间" Value="卫生间" />
                            <dx:ListEditItem Text="浴室" Value="浴室" />
                            <dx:ListEditItem Text="走廊" Value="走廊" />
                            <dx:ListEditItem Text="户外" Value="户外" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    事件类型
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxEType" runat="server" Width="100%" NullText="--请选择--">
                        <ClientSideEvents SelectedIndexChanged="OnEtypeSelectedInexChanged" />
                        <Items>
                            <dx:ListEditItem Text="跌倒" Value="跌倒" />
                            <dx:ListEditItem Text="坠床" Value="坠床" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol1">
                    是否再次<span id="lbletype"></span>
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxAgainFlag" runat="server" Width="100%" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="否" Value="否" />
                            <dx:ListEditItem Text="是" Value="是" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    发生前患者意识状态
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxBCS" runat="server" Width="100%" DropDownStyle="DropDown"
                        NullText="--选择或输入--">
                        <Items>
                            <dx:ListEditItem Text="清醒" Value="清醒" />
                            <dx:ListEditItem Text="嗜睡" Value="嗜睡" />
                            <dx:ListEditItem Text="昏睡" Value="昏睡" />
                            <dx:ListEditItem Text="昏迷" Value="昏迷" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    发生后患者意识状态
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxACS" runat="server" Width="100%" DropDownStyle="DropDown"
                        NullText="--选择或输入--">
                        <Items>
                            <dx:ListEditItem Text="清醒" Value="清醒" />
                            <dx:ListEditItem Text="嗜睡" Value="嗜睡" />
                            <dx:ListEditItem Text="昏睡" Value="昏睡" />
                            <dx:ListEditItem Text="昏迷" Value="昏迷" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    <span id="lbletype"></span>时患者状态
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxDSHZZT" runat="server" Width="100%" DropDownStyle="DropDown"
                        NullText="--选择或输入--">
                        <Items>
                            <dx:ListEditItem Text="行走中" Value="行走中" />
                            <dx:ListEditItem Text="站立" Value="站立" />
                            <dx:ListEditItem Text="上下病床" Value="上下病床" />
                            <dx:ListEditItem Text="上下推床" Value="上下推床" />
                            <dx:ListEditItem Text="躺卧病床" Value="躺卧病床" />
                            <dx:ListEditItem Text="坐轮椅" Value="坐轮椅" />
                            <dx:ListEditItem Text="坐床旁椅" Value="坐床旁椅" />
                            <dx:ListEditItem Text="沐浴中" Value="沐浴中" />
                            <dx:ListEditItem Text="翻身时" Value="翻身时" />
                            <dx:ListEditItem Text="如厕中" Value="如厕中" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    事件对患者住院天数的影响
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxTSYX" runat="server" Width="100%" DropDownStyle="DropDown"
                        NullText="--选择或输入--">
                        <Items>
                            <dx:ListEditItem Text="无影响" Value="无影响" />
                            <dx:ListEditItem Text="可能增加" Value="可能增加" />
                            <dx:ListEditItem Text="可能减少" Value="可能减少" />
                            <dx:ListEditItem Text="无法判定影响" Value="无法判定影响" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    立即通知
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxLJTZ" runat="server" Width="100%" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="其他护理人员" Value="其他护理人员" />
                            <dx:ListEditItem Text="病房护士长" Value="病房护士长" />
                            <dx:ListEditItem Text="医生" Value="医生" />
                            <dx:ListEditItem Text="家属" Value="家属" />
                            <dx:ListEditItem Text="其他人员" Value="其他人员" />
                            <dx:ListEditItem Text="科护士长" Value="科护士长" />
                            <dx:ListEditItem Text="护理部" Value="护理部" />
                            <dx:ListEditItem Text="主管院长" Value="主管院长" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    医疗措施
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxYLCS" runat="server" Width="100%" DropDownStyle="DropDown"
                        NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="密切观察生命体征" Value="密切观察生命体征" />
                            <dx:ListEditItem Text="医疗或护理措施" Value="医疗或护理措施" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    原因
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxReason" runat="server" Width="100%" DropDownStyle="DropDown"
                        NullText="--选择或输入--">
                        <Items>
                            <dx:ListEditItem Text="因患者健康状况而造成跌倒" Value="因患者健康状况而造成跌倒" />
                            <dx:ListEditItem Text="因治疗、药物和麻醉反应而造成跌倒" Value="因治疗、药物和麻醉反应而造成跌倒" />
                            <dx:ListEditItem Text="因环境中危险因子而造成跌倒" Value="因环境中危险因子而造成跌倒" />
                            <dx:ListEditItem Text="因其他因素而造成跌倒" Value="因其他因素而造成跌倒" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    <span id="lbletype"></span>造成伤害严重程度
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxSHCD" runat="server" Width="100%" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="无损伤" Value="无损伤" />
                            <dx:ListEditItem Text="一级" Value="一级" />
                            <dx:ListEditItem Text="二级" Value="二级" />
                            <dx:ListEditItem Text="三级" Value="三级" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    既往<span id="lbletype"></span>次数
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxJWCS" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
                <td class="td_leftcol2">
                    有记录的伤害次数
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxJLCS" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    事件描述
                </td>
                <td colspan="3" style="border: 2px solid #a1a7ab;">
                    <dx:ASPxMemo ID="ASPxMemoDetails" runat="server" Height="71px" Width="100%">
                    </dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    处理措施
                </td>
                <td colspan="3" style="border: 2px solid #a1a7ab;">
                    <dx:ASPxMemo ID="ASPxMemoMeasures" runat="server" Height="71px" Width="100%">
                    </dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    事件等级
                </td>
                <td colspan="3" style="border: 2px solid #a1a7ab;">
                    <div style="width: 522px;">
                        <dx:ASPxTreeView ID="ASPxTreeView1" runat="server" Width="522px" AllowCheckNodes="True" 
                            CheckNodesRecursive="True" ShowExpandButtons="False" ShowTreeLines="False" AllowSelectNode="True" ClientInstanceName="trvEGrade">
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
                                        <dx:TreeViewNode Text="5级：给患者造成永久性伤害">
                                        </dx:TreeViewNode>
                                        <dx:TreeViewNode Text="6级：造成患者死亡">
                                        </dx:TreeViewNode>
                                    </Nodes>
                                </dx:TreeViewNode>
                                <dx:TreeViewNode Text="Ⅱ级事件（不良后果事件）" AllowCheck="False">
                                    <Nodes>
                                        <dx:TreeViewNode Text="4级：给患者造成严重伤害，需要提升护理级别和采取紧急抢救措施">
                                        </dx:TreeViewNode>
                                    </Nodes>
                                </dx:TreeViewNode>
                                <dx:TreeViewNode Text="Ⅲ级事件（未造成后果事件）" AllowCheck="False">
                                    <Nodes>
                                        <dx:TreeViewNode Text="1级：错误已发生在患者身上，但未造成不良伤害">
                                        </dx:TreeViewNode>
                                        <dx:TreeViewNode Text="2级：给患者造成轻微痛苦，没有延长治疗时间和增加不必要的经济负担">
                                        </dx:TreeViewNode>
                                        <dx:TreeViewNode Text="3级：给患者造成一定痛苦，延长了治疗时间或（和）增加了不必要的经济负担">
                                        </dx:TreeViewNode>
                                    </Nodes>
                                </dx:TreeViewNode>
                                <dx:TreeViewNode Text="Ⅳ级事件（临界错误事件）" AllowCheck="False">
                                    <Nodes>
                                        <dx:TreeViewNode Text="0级，接近失误，即错误虽发生了，但在到达患者之前被发现并得到纠正">
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
    <div id="header3" class="page-header" onclick="toggle('sectionDIV3')">
        当事人基本情况（有明确当事人请填写；无明确当事人此项不填）
    </div>
    <div id="sectionDIV3" class="header-section">
        <dx:ASPxCallbackPanel ID="cp" ClientInstanceName="cp" runat="server" OnCallback="cp_Callback">
            <ClientSideEvents EndCallback="OngridendCallback" />
            <PanelCollection>
                <dx:PanelContent ID="PanelContent1" runat="server">
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
                            <dx:GridViewDataTextColumn Caption="班次" FieldName="dDutyNum" ShowInCustomizationForm="True"
                                VisibleIndex="14">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataComboBoxColumn Caption="岗位层级" FieldName="dPostLevel" ShowInCustomizationForm="True"
                                VisibleIndex="8">
                                <PropertiesComboBox>
                                    <Items>
                                        <dx:ListEditItem Text="N0" Value="N0" />
                                        <dx:ListEditItem Text="N1" Value="N1" />
                                        <dx:ListEditItem Text="N2" Value="N2" />
                                        <dx:ListEditItem Text="N3" Value="N3" />
                                        <dx:ListEditItem Text="N4" Value="N4" />
                                    </Items>
                                </PropertiesComboBox>
                            </dx:GridViewDataComboBoxColumn>
                        </Columns>
                        <SettingsBehavior AllowDragDrop="False" AllowSort="False" />
                        <SettingsEditing Mode="Batch">
                        </SettingsEditing>
                        <Settings ShowStatusBar="Hidden" />
                        <SettingsText CommandBatchEditCancel="取消" CommandBatchEditUpdate="保存" CommandDelete="删除"
                            CommandNew="新增" ConfirmOnLosingBatchChanges="当事人基本情况尚未保存" EmptyDataRow="空" />
                    </dx:ASPxGridView>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
        <asp:SqlDataSource ID="SqlDataSourceParty" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            SelectCommand="SELECT * FROM [AE_PartyInfo] WHERE baseEventID = @baseEventID " DeleteCommand="DELETE FROM AE_PartyInfo WHERE (partyID = @partyID)"
            InsertCommand="INSERT INTO AE_PartyInfo(baseEventID, dClinicalDept, dPostCategory,dPostLevel, dPersonCategory, dTechCategory,dWorkYears,dDutyNum) VALUES (@baseEventID,@dClinicalDept ,@dPostCategory,@dPostLevel, @dPersonCategory,@dTechCategory,@dWorkYears,@dDutyNum)"
            UpdateCommand="UPDATE AE_PartyInfo SET dClinicalDept =@dClinicalDept, dPostCategory =@dPostCategory ,dPostLevel=@dPostLevel, dPersonCategory =@dPersonCategory , dTechCategory =@dTechCategory , dWorkYears =@dWorkYears,dDutyNum=@dDutyNum  WHERE (partyID = @partyID) "
            OnInserting="SqlDataSourceParty_Inserting">
            <SelectParameters>
                <asp:QueryStringParameter Name="baseEventID" QueryStringField="baseEventID" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="baseEventID" DbType="Int32" />
                <asp:Parameter Name="dClinicalDept" />
                <asp:Parameter Name="dPostCategory" />
                <asp:Parameter Name="dPostLevel" />
                <asp:Parameter Name="dPersonCategory" />
                <asp:Parameter Name="dTechCategory" />
                <asp:Parameter Name="dWorkYears" />
                <asp:Parameter Name="dDutyNum" />
            </InsertParameters>
            <DeleteParameters>
                <asp:Parameter Name="partyID" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="partyID" />
                <asp:Parameter Name="dClinicalDept" />
                <asp:Parameter Name="dPostCategory" />
                <asp:Parameter Name="dPostLevel" />
                <asp:Parameter Name="dPersonCategory" />
                <asp:Parameter Name="dTechCategory" />
                <asp:Parameter Name="dWorkYears" />
                <asp:Parameter Name="dDutyNum" />
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
                    岗位层级
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxPostLevel" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="N0" Value="N0" />
                            <dx:ListEditItem Text="N1" Value="N1" />
                            <dx:ListEditItem Text="N2" Value="N2" />
                            <dx:ListEditItem Text="N3" Value="N3" />
                            <dx:ListEditItem Text="N4" Value="N4" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    工作年限
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxWorkY" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div class="header-section" style="text-align: center;">
        <dx:ASPxButton ID="ASPxButtonSubmit" runat="server" ClientInstanceName="ASPxButtonSubmit"
            AutoPostBack="false" Text="保存">
            <ClientSideEvents Click="OnSubmit" />
            <BorderTop BorderWidth="0px" />
        </dx:ASPxButton>
    </div>
    </form>
</body>
</html>
