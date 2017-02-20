<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HLQTBLSJ.aspx.cs" Inherits="Project.WebUi.AdverseEvent.HLQTBLSJ"
     %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>护理不良事件-其他</title>
    <link href="../css/AEstyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function OnSubmit(s, e) {
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
                    //s.SetValue(s.GetSelectedItem().GetColumnText("DeptName"));
                    //s.SetText(s.GetSelectedItem().GetColumnText("DeptName"));
                    //s.SetText(s.GetValue());
                    var d = gridParty;
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
                ddEtpe.HideDropDown();
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
                <div style="margin: auto; width: 655px; text-align: center;">
                    <h2 style="color: #4D4D4D;margin-top: 50px;margin-bottom: 20px;font-size: 24px;">
                        其他护理不良事件</h2>
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
                                临床诊断
                            </td>
                            <td class="td_right">
                                <dx:ASPxTextBox ID="ASPxTextBoxCDia" runat="server" Width="100%">
                                </dx:ASPxTextBox>
                            </td>
                            <td class="td_leftcol2">
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
                                        <dx:ListEditItem Text="无" Value="无" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                    </table>
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
                                    TextField="DeptName" ValueField="DeptID" ValueType="System.String" NullText="--拼音检索--">
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
                                        <dx:ListEditItem Text="门诊" Value="门诊" />
                                        <dx:ListEditItem Text="急诊" Value="急诊" />
                                        <dx:ListEditItem Text="住院" Value="住院" />
                                        <dx:ListEditItem Text="ICU" Value="ICU" />
                                        <dx:ListEditItem Text="医技科室" Value="医技科室" />
                                        <dx:ListEditItem Text="手术麻醉" Value="手术麻醉" />
                                        <dx:ListEditItem Text="产房" Value="产房" />
                                        <dx:ListEditItem Text="公共活动区" Value="公共活动区" />
                                        <dx:ListEditItem Text="其他场所" Value="其他场所" />
                                        <dx:ListEditItem Text="场所不明" Value="场所不明" />
                                        <dx:ListEditItem Text="户外" Value="户外" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_leftcol1">
                                事件类型
                            </td>
                            <td colspan="3" style="border: 2px solid #a1a7ab;">
                                <dx:ASPxDropDownEdit ID="ASPxDropDownEditEtype" runat="server" Width="100%" ClientInstanceName="ddEtpe">
                                    <DropDownWindowTemplate>
                                        <dx:ASPxTreeView ID="ASPxTreeViewEType" runat="server" AllowSelectNode="True">
                                            <ClientSideEvents NodeClick="OnETypeNodeClick" />
                                            <Nodes>
                                                <dx:TreeViewNode Text="饮食">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="饮食错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="病人错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="时间错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="禁食的病人进食">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="管饲">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="管鼻量错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="病人错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="管饲液错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="注入速度错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="时间错误">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="静脉给药">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="药物外渗">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="药品过期">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="静脉输液位置">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="外周静脉">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="动脉">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="中心静脉">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="PICC">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="CVC">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="静脉输液错误">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="未按规定更换输液装置">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="速度错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="液体错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="皮管扭曲或脱开">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="时间错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="输液器内大量气泡">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="病人错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="针头脱出">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="堵管">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="断管-体外">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="断管-离断">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="断管-破损">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="感染">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="导管移位">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="拔管困难">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="血栓形成">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="外渗">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="输血">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="未按规定更换输血装置">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="速度错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="病人错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="血型错误">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="标本采集">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="标本容器错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="采血量错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="病人错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="血液种类错误">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="漏执行医嘱">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="贴错标本条码">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="抽血项目缺失">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="延迟抽血">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                </dx:TreeViewNode>
                                                <dx:TreeViewNode Text="其他">
                                                    <Nodes>
                                                        <dx:TreeViewNode Text="血糖测错">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="紫外线照射不良反应">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="延误治疗">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="烧伤">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="误吸">
                                                        </dx:TreeViewNode>
                                                        <dx:TreeViewNode Text="约束意外">
                                                        </dx:TreeViewNode>
                                                    </Nodes>
                                                    </dx:TreeViewNode>
                                            </Nodes>
                                        </dx:ASPxTreeView>
                                    </DropDownWindowTemplate>
                                </dx:ASPxDropDownEdit>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="border: 2px solid #a1a7ab; text-align: right">
                                事件对患者住院天数的影响
                            </td>
                            <td colspan="2" style="border: 2px solid #a1a7ab;">
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
                                        CheckNodesRecursive="True" ShowExpandButtons="False" ShowTreeLines="False" AllowSelectNode="True"  ClientInstanceName="trvEGrade">
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
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridParty"
                        DataSourceID="SqlDataSourceParty" KeyFieldName="partyID;baseEventID" Width="100%">
                        <ClientSideEvents BatchEditConfirmShowing="gridBatchEditConfirmShowing" />
                        <Columns>
                            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowInCustomizationForm="True"
                                ShowNewButtonInHeader="True" VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataComboBoxColumn Caption="所在科室" FieldName="dClinicalDept" ShowInCustomizationForm="True"
                                VisibleIndex="3">
                                <PropertiesComboBox TextField="DeptName" ValueField="DeptID" ValueType="System.String"
                                     CallbackPageSize="10" EnableCallbackMode="True" AllowMouseWheel="false"
                                    DataSourceID="SqlDataSourceKS" Width="120px" IncrementalFilteringMode="StartsWith"
                                    FilterMinLength="2" NullText="--请选择--">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="DeptPYM" />
                                        <dx:ListBoxColumn FieldName="DeptName" />
                                    </Columns>
                                    <ClientSideEvents   KeyUp="ddKeyUp" /><%----%>
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
                    <asp:SqlDataSource ID="SqlDataSourceParty" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
                        SelectCommand="SELECT * FROM [AE_PartyInfo] WHERE baseEventID = -1 " DeleteCommand="DELETE FROM AE_PartyInfo WHERE (partyID = @partyID)"
                        InsertCommand="INSERT INTO AE_PartyInfo(baseEventID, dClinicalDept, dPostCategory,dPostLevel, dPersonCategory, dTechCategory,dWorkYears,dDutyNum) VALUES (@baseEventID,@dClinicalDept ,@dPostCategory,@dPostLevel, @dPersonCategory,@dTechCategory,@dWorkYears,@dDutyNum)"
                        UpdateCommand="UPDATE AE_PartyInfo SET dClinicalDept =@dClinicalDept, dPostCategory =@dPostCategory ,dPostLevel=@dPostLevel, dPersonCategory =@dPersonCategory , dTechCategory =@dTechCategory , dWorkYears =@dWorkYears,dDutyNum=@dDutyNum  WHERE (partyID = @partyID) "
                        OnInserting="SqlDataSourceParty_Inserting">
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
                                    TextField="DeptName" ValueField="DeptID" ValueType="System.String" NullText="--拼音检索--">
                                    <ClientSideEvents KeyUp="ddKeyUp" />
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
