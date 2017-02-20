<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditHLYC.aspx.cs" Inherits="Project.WebUi.AdverseEvent.EditHLYC" %>


<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>护理不良事件-压疮</title>
    <link href="../css/AEstyle.css" rel="stylesheet" type="text/css" />
    <meta id="IE8CompatibilityMeta" http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
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
                    //ASPxClientEdit.ClearEditorsInContainer(null);
                    //gridParty.Refresh();
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
                ddEtpe.HideDropDown();
            }
        }
        function OnLostFocusWidth() {
            var ars = txtLength.GetText() * txtWidth.GetText();
            txtArea.SetText(ars);
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
            护理压疮事件</h2>
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
                    体重
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxPWeight" runat="server" Width="170px">
                    </dx:ASPxTextBox>
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
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <%--<tr>
                <td class="td_leftcol1">
                    事件类型
                </td>
                <td colspan="3" style="border: 2px solid #a1a7ab;">
                    <dx:ASPxComboBox ID="ASPxComboBoxEType" runat="server" Width="100%" DropDownStyle="DropDown"
                        NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="防火器材（灭火器、消防栓）丢失或损坏" Value="防火器材（灭火器、消防栓）丢失或损坏" />
                            <dx:ListEditItem Text="监控设备损坏" Value="监控设备损坏" />
                            <dx:ListEditItem Text="其他" Value="其他" />
                            <dx:ListEditItem Text="放射源过渡照射或放射性物质沾染" Value="放射源过渡照射或放射性物质沾染" />
                            <dx:ListEditItem Text="化学品及清洁/消杀易燃品等泄露" Value="化学品及清洁/消杀易燃品等泄露" />
                            <dx:ListEditItem Text="关键岗位脱岗、漏岗" Value="关键岗位脱岗、漏岗" />
                            <dx:ListEditItem Text="危险废弃物违规放置" Value="危险废弃物违规放置" />
                            <dx:ListEditItem Text="食品安全事件" Value="食品安全事件" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>--%>
            <tr>
                <td class="td_leftcol1">
                    压疮部位
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxPressureArea" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="枕骨粗隆" Value="枕骨粗隆" />
                            <dx:ListEditItem Text="肩胛部" Value="肩胛部" />
                            <dx:ListEditItem Text="肘部" Value="肘部" />
                            <dx:ListEditItem Text="脊椎体隆突处" Value="脊椎体隆突处" />
                            <dx:ListEditItem Text="骶尾部" Value="骶尾部" />
                            <dx:ListEditItem Text="足跟部" Value="足跟部" />
                            <dx:ListEditItem Text="耳廓" Value="耳廓" />
                            <dx:ListEditItem Text="肩峰" Value="肩峰" />
                            <dx:ListEditItem Text="肋骨" Value="肋骨" />
                            <dx:ListEditItem Text="胯部" Value="胯部" />
                            <dx:ListEditItem Text="膝关节内外侧" Value="膝关节内外侧" />
                            <dx:ListEditItem Text="内外踝处" Value="内外踝处" />
                            <dx:ListEditItem Text="面颊部" Value="面颊部" />
                            <dx:ListEditItem Text="肩部" Value="肩部" />
                            <dx:ListEditItem Text="女性乳房" Value="女性乳房" />
                            <dx:ListEditItem Text="男性生殖器" Value="男性生殖器" />
                            <dx:ListEditItem Text="髂嵴" Value="髂嵴" />
                            <dx:ListEditItem Text="足尖处" Value="足尖处" />
                            <dx:ListEditItem Text="坐骨结节处" Value="坐骨结节处" />
                            <dx:ListEditItem Text="其他部位" Value="其他部位" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    长度(cm)
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxAreaLength" ClientInstanceName="txtLength" runat="server"
                        Width="170px">
                        <ClientSideEvents LostFocus="OnLostFocusWidth" />
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="border: 2px solid #a1a7ab;">
                    <table class="custom">
                        <tr>
                            <td>
                                宽度(cm)
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="ASPxTextBoxAreaWidth" ClientInstanceName="txtWidth" runat="server"
                                    Width="130px">
                                    <ClientSideEvents LostFocus="OnLostFocusWidth" />
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                深度(cm)
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="ASPxTextBoxAreaDepth" runat="server" Width="131px">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                压疮面积(cm2)
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="ASPxTextBoxcm2" ClientInstanceName="txtArea" runat="server" Enabled="false" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    压疮发生时期
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxPOccurPeriod" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="住院前" Value="住院前" />
                            <dx:ListEditItem Text="住院期间" Value="住院期间" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    院前压疮患者来源
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxBeforeSource" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="自家庭入住时有压疮的患者" Value="自家庭入住时有压疮的患者" />
                            <dx:ListEditItem Text="自养老院入住时有压疮的患者" Value="自养老院入住时有压疮的患者" />
                            <dx:ListEditItem Text="自其他医院转入时有压疮的患者" Value="自其他医院转入时有压疮的患者" />
                            <dx:ListEditItem Text="自其他来源入住时有压疮的患者" Value="自其他来源入住时有压疮的患者" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    压疮级别
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxPressureLevel" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="有一级压疮" Value="有一级压疮" />
                            <dx:ListEditItem Text="有二级压疮" Value="有二级压疮" />
                            <dx:ListEditItem Text="有三级压疮" Value="有三级压疮" />
                            <dx:ListEditItem Text="有四级压疮" Value="有四级压疮" />
                            <dx:ListEditItem Text="可疑深部组织损伤期压疮" Value="可疑深部组织损伤期压疮" />
                            <dx:ListEditItem Text="不可分期压疮" Value="不可分期压疮" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    住院期间压疮是否难免
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxPNoAvoid" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="否" Value="否" />
                            <dx:ListEditItem Text="是" Value="是" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    压疮发生原因
                </td>
                <td colspan="3">
                    <dx:ASPxDropDownEdit ID="ASPxDropDownEditPressReason" runat="server" Width="100%"
                        ClientInstanceName="ddEtpe">
                        <DropDownWindowTemplate>
                            <dx:ASPxTreeView ID="ASPxTreeViewEType" runat="server" AllowSelectNode="True">
                                <ClientSideEvents NodeClick="OnETypeNodeClick" />
                                <Nodes>
                                    <dx:TreeViewNode Text="患者因素">
                                        <Nodes>
                                            <dx:TreeViewNode Text="卧床  ">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="制动">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="强迫体位">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="昏迷">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="肥胖">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="大小便失禁">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="浮肿">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="低蛋白">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="恶液质">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="其他">
                                            </dx:TreeViewNode>
                                        </Nodes>
                                    </dx:TreeViewNode>
                                    <dx:TreeViewNode Text="医疗因素">
                                        <Nodes>
                                            <dx:TreeViewNode Text="给未能及时纠正低蛋白血症，改善营养状况药频次">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="滥用抗生素、造成菌群失调性腹泻">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="其他">
                                            </dx:TreeViewNode>
                                        </Nodes>
                                    </dx:TreeViewNode>
                                    <dx:TreeViewNode Text="护理人员因素">
                                        <Nodes>
                                            <dx:TreeViewNode Text="未按时翻身">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="未及时清洁、擦洗皮肤">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="床单位潮湿、不洁、褶皱">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="管路较长时间受压而未有损坏，造成皮肤擦伤">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="其他">
                                            </dx:TreeViewNode>
                                        </Nodes>
                                    </dx:TreeViewNode>
                                    <dx:TreeViewNode Text="其他因素">
                                        <Nodes>
                                            <dx:TreeViewNode Text="护理人员配备不足">
                                            </dx:TreeViewNode>
                                            <dx:TreeViewNode Text="其他">
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
                <td class="td_leftcol1">
                    排除病例
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxExcludeCases" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="否" Value="否" />
                            <dx:ListEditItem Text="是" Value="是" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    有无风险评估
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxRiskAssessFlag" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="否" Value="否" />
                            <dx:ListEditItem Text="是" Value="是" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    告知家属
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxInfromFamily" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="无" Value="无" />
                            <dx:ListEditItem Text="有" Value="有" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    告知家属时间
                </td>
                <td class="td_right">
                    <dx:ASPxTimeEdit ID="ASPxTimeEditInfromFamilyTime" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss">
                    </dx:ASPxTimeEdit>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    渗出液状态
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxExudationStatus" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="没有" Value="没有" />
                            <dx:ListEditItem Text="少量" Value="少量" />
                            <dx:ListEditItem Text="中等量" Value="中等量" />
                            <dx:ListEditItem Text="大量" Value="大量" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    渗出液颜色
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxExudationColor" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    渗出液气味
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxExudationSmell" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
                <td class="td_leftcol2">
                    渗出液量
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxExudationAmount" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    有无伤口感染
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxInfectionFlag" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="无" Value="无" />
                            <dx:ListEditItem Text="有" Value="有" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    有无组织换死
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxTissueNecrosis" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="无" Value="无" />
                            <dx:ListEditItem Text="有" Value="有" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    周围皮肤情况
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxSurroundingState" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="红" Value="红" />
                            <dx:ListEditItem Text="肿" Value="肿" />
                            <dx:ListEditItem Text="热" Value="热" />
                            <dx:ListEditItem Text="痛" Value="痛" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    护理预防措施
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxNursingPrecautions" runat="server" DropDownStyle="DropDown"
                        NullText="--选择或输入--">
                        <Items>
                            <dx:ListEditItem Text="增加翻身频次" Value="增加翻身频次" />
                            <dx:ListEditItem Text="保持皮肤清洁、干燥" Value="保持皮肤清洁、干燥" />
                            <dx:ListEditItem Text="保持床单位清洁干燥平整" Value="保持床单位清洁干燥平整" />
                            <dx:ListEditItem Text="按摩受压部位皮肤" Value="按摩受压部位皮肤" />
                            <dx:ListEditItem Text="使用防压疮气垫" Value="使用防压疮气垫" />
                            <dx:ListEditItem Text="使用软垫垫于骨隆突部位" Value="使用软垫垫于骨隆突部位" />
                            <dx:ListEditItem Text="应用频谱仪照射创面治疗" Value="应用频谱仪照射创面治疗" />
                            <dx:ListEditItem Text="贴膜保护受压部位皮肤" Value="贴膜保护受压部位皮肤" />
                            <dx:ListEditItem Text="伤口换药" Value="伤口换药" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    通知上报
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxSubmitReport" runat="server" NullText="--请选择--">
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
                </td>
                <td class="td_right">
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
                                VisibleIndex="9">
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
                                VisibleIndex="11">
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
                                VisibleIndex="13">
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
            SelectCommand="SELECT * FROM [AE_PartyInfo] WHERE baseEventID = @baseEventID; " DeleteCommand="DELETE FROM AE_PartyInfo WHERE (partyID = @partyID)"
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

