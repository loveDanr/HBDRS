<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SXBLFY.aspx.cs" Inherits="Project.WebUi.AdverseEvent.SXBLFY"
     %>
<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>输血不良反应</title>
    <link href="../css/AEstyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function OnSubmit(s, e) {
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
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceKS" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
        SelectCommand=" DECLARE @rootDeptID int ; SELECT  @rootDeptID = DeptId FROM Department WHERE ParentDeptID='-1'; SELECT * FROM Department WHERE ParentDeptID=@rootDeptID;">
    </asp:SqlDataSource>
    <div  style="text-align: center;">
        <h2 style="color: #4D4D4D;margin-top: 50px;margin-bottom: 20px;font-size: 24px;">
            输血不良反应事件</h2>
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
                    民族
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxN" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
                <td class="td_leftcol2">
                    婚否
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxM" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="是" Value="是" />
                            <dx:ListEditItem Text="否" Value="否" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    孕(次)
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxPre" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
                <td class="td_leftcol2">
                    产(次)
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxBir" runat="server" Width="170px">
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
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss" Enabled="False">
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
            <tr>
                <td class="td_leftcol1">
                    患者ABO血型
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxPABO" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="A型" Value="A型" />
                            <dx:ListEditItem Text="B型" Value="B型" />
                            <dx:ListEditItem Text="O型" Value="O型" />
                            <dx:ListEditItem Text="AB型" Value="AB型" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    患者Rh(D)血型
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxPRHD" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="阳性 " Value="阳性 " />
                            <dx:ListEditItem Text="阴性" Value="阴性" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    不规则抗体筛查
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBox5" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="阳性" Value="阳性" />
                            <dx:ListEditItem Text="阴性" Value="阴性" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    既往输血史
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBox6" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="有" Value="有" />
                            <dx:ListEditItem Text="无" Value="无" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    血液制剂名称
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBox7" runat="server" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="去白细胞悬浮红细胞" Value="去白细胞悬浮红细胞" />
                            <dx:ListEditItem Text="病毒灭活冰冻血浆" Value="病毒灭活冰冻血浆" />
                            <dx:ListEditItem Text="冷沉淀凝血因子" Value="冷沉淀凝血因子" />
                            <dx:ListEditItem Text="单采血小板" Value="单采血小板" />
                            <dx:ListEditItem Text="洗涤红细胞" Value="洗涤红细胞" />
                            <dx:ListEditItem Text="去白细胞全血" Value="去白细胞全血" />
                            <dx:ListEditItem Text="冰冻血浆" Value="冰冻血浆" />
                            <dx:ListEditItem Text="悬浮红细胞" Value="悬浮红细胞" />
                            <dx:ListEditItem Text="冰冻解冻去甘油红细胞" Value="冰冻解冻去甘油红细胞" />
                            <dx:ListEditItem Text="新鲜冰冻血浆" Value="新鲜冰冻血浆" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    供血者ABO血型
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxSABO" runat="server" ValueType="System.String" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="A型" Value="A型" />
                            <dx:ListEditItem Text="B型" Value="B型" />
                            <dx:ListEditItem Text="O型" Value="O型" />
                            <dx:ListEditItem Text="AB型" Value="AB型" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    供血者Rh(D)血型
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxSRHD" runat="server" ValueType="System.String" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="阳性 " Value="阳性 " />
                            <dx:ListEditItem Text="阴性" Value="阴性" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
                <td class="td_leftcol2">
                    本次输血反应症状与体征
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBox10" runat="server" DropDownStyle="DropDown" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="发热" Value="发热" />
                            <dx:ListEditItem Text="发绀" Value="发绀" />
                            <dx:ListEditItem Text="呼吸困难" Value="呼吸困难" />
                            <dx:ListEditItem Text="两肺布满湿性啰音" Value="两肺布满湿性啰音" />
                            <dx:ListEditItem Text="黄疸" Value="黄疸" />
                            <dx:ListEditItem Text="腰背痛" Value="腰背痛" />
                            <dx:ListEditItem Text="酱油色尿" Value="酱油色尿" />
                            <dx:ListEditItem Text="寒战" Value="寒战" />
                            <dx:ListEditItem Text="荨麻疹" Value="荨麻疹" />
                            <dx:ListEditItem Text="休克" Value="休克" />
                            <dx:ListEditItem Text="伤口" Value="伤口" />
                            <dx:ListEditItem Text="渗血不止" Value="渗血不止" />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    反应出现时间
                </td>
                <td class="td_right">
                    <dx:ASPxTimeEdit ID="ASPxTimeEditFeed" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss">
                    </dx:ASPxTimeEdit>
                </td>
                <td class="td_leftcol2">
                    输血反应类型
                </td>
                <td class="td_right">
                    <dx:ASPxComboBox ID="ASPxComboBoxFeed" runat="server" DropDownStyle="DropDown" NullText="--请选择--">
                        <Items>
                            <dx:ListEditItem Text="发热反应 " Value="发热反应 " />
                            <dx:ListEditItem Text="过敏反应 " Value="过敏反应 " />
                            <dx:ListEditItem Text="急性溶血反应   " Value="急性溶血反应   " />
                        </Items>
                    </dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    临床诊断
                </td>
                <td colspan="3" style="border: 2px solid #a1a7ab;">
                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="100%">
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
                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG" SetFocusOnError="true">
                            <RequiredField IsRequired="true" />
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
        <dx:ASPxCallbackPanel ID="cp" ClientInstanceName="cp" runat="server" OnCallback="cp_Callback">
            <ClientSideEvents EndCallback="OngridendCallback" />
            <PanelCollection>
                <dx:PanelContent runat="server">
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
                <td colspan="2" style="border: 2px solid #a1a7ab;">
		        </td>
            </tr>
        </table>
    </div>
    <div class="header-section" style="text-align: center;">
        <dx:ASPxButton ID="ASPxButtonSubmit" runat="server" ClientInstanceName="ASPxButtonSubmit"
            AutoPostBack="false" Text="提交">
            <ClientSideEvents Click="OnSubmit" />
            <Border BorderWidth="0px" />
        </dx:ASPxButton>
    </div>
    </form>
</body>
</html>
