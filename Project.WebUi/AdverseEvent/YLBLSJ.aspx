<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YLBLSJ.aspx.cs" Inherits="Project.WebUi.AdverseEvent.YLBLSJ"  %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>医疗医技不良事件</title>
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
                    alert(s.cpSaveFlag);
                    //gridParty.CancelEdit();
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
    <div style="margin:auto;width: 655px;text-align: center;">
        <h2 style="color: #4D4D4D;margin-top: 50px;margin-bottom: 20px;font-size: 24px;">
            医疗医技不良事件</h2>
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
                    <dx:ASPxTextBox ID="ASPxTextBoxHID" runat="server" Width="170px" NullText="必须为8位数字" >
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
                    <dx:ASPxTextBox ID="ASPxTextBoxNa" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
                <td class="td_leftcol2">
                    职别
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxJob" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="td_leftcol1">
                    临床诊断
                </td>
                <td class="td_right">
                    <dx:ASPxTextBox ID="ASPxTextBoxCDia" runat="server" Width="170px">
                    </dx:ASPxTextBox>
                </td>
                <td class="td_leftcol2">
                    入院时间或门诊就诊时间
                </td>
                <td class="td_right">
                    <dx:ASPxTimeEdit ID="ASPxTimeEditClinic" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                        EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss" >
                    </dx:ASPxTimeEdit>
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
                    事件类型
                </td>
                <td colspan="3" style="border: 2px solid #a1a7ab;">
                    <dx:ASPxComboBox ID="ASPxComboBoxEType" runat="server"
                        Width="100%">
                        <Items>
                            <dx:ListEditItem Text="严重的手术前后诊断不符" Value="严重的手术前后诊断不符" />
                            <dx:ListEditItem Text="严重的手术后并发症" Value="严重的手术后并发症" />
                            <dx:ListEditItem Text="非预期重返手术室" Value="非预期重返手术室" />
                            <dx:ListEditItem Text="非预期重返ICU" Value="非预期重返ICU" />
                            <dx:ListEditItem Text="麻醉意外等相关事件" Value="麻醉意外等相关事件" />
                            <dx:ListEditItem Text="手术或有创操作中异物留置体内、部位错误等相关事件" 
                                Value="手术或有创操作中异物留置体内、部位错误等相关事件" />
                            <dx:ListEditItem Text="治疗错误事件：患者、部位、器材、剂量等选择错误" 
                                Value="治疗错误事件：患者、部位、器材、剂量等选择错误" />
                            <dx:ListEditItem Text="方法/技术错误事件：未治疗、延期、延时、过度医疗或程序错误等" 
                                Value="治疗错误事件：患者、部位、器材、剂量等选择错误" />
                            <dx:ListEditItem Text="介入治疗的相关事件" Value="介入治疗的相关事件" />
                            <dx:ListEditItem Text="标本丢失或标本错误" Value="标本丢失或标本错误" />
                            <dx:ListEditItem Text="检查检验结果漏报、错报" Value="检查检验结果漏报、错报" />
                            <dx:ListEditItem Text="仪器、试剂所致安全事件" Value="仪器、试剂所致安全事件" />
                            <dx:ListEditItem Text="临床营养与膳食事件" Value="临床营养与膳食事件" />
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
                        DataSourceID="SqlDataSourceKS" TextFormatString="{0}" DisplayFormatString="{1}"  CallbackPageSize="10" EnableCallbackMode="True"
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
            <BorderTop BorderWidth="0px" />
        </dx:ASPxButton>
    </div>
    </form>
</body>
</html>
