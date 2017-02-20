<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YWRYZYBL.aspx.cs" Inherits="Project.WebUi.AdverseEvent.YWRYZYBL"
     %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>职业暴露</title>
    <meta id="IE8CompatibilityMeta" http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <script type="text/javascript">
        function OnSubmit(s, e) {
            if (ASPxClientEdit.ValidateGroup("pageVG")) {
                cp.PerformCallback();
            }
        }
        function OngridendCallback(s, e) {
            if (s.cpSaveFlag != undefined) {
                    alert(s.cpSaveFlag)
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
        function OnaClick(s) {
            var menuUL = document.getElementById('ulmenu');
            for (var i = 0; i < menuUL.children.length; i++) {
                menuUL.children[i].style.backgroundColor = "FFF";
                menuUL.children[i].style.color = "#4d4d4d";
                //menuUL.children[i].children[0].style.backgroundColor = "FFF";
                menuUL.children[i].children[0].style.color = "#4d4d4d";
            }
            s.style.backgroundColor = "#b63b4d";
            s.style.color = "FFF";
            //s.children[0].style.backgroundColor = "#2FA4E7";
            s.children[0].style.color = "FFF";
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
    </script>
    <style type="text/css">
        *
        {
            margin: 0px;
            padding: 0px;
            border: 0px;
            color: #3E3E3E;
        }
        .container
        {
            margin-left: auto;
            margin-right: auto;
        }
        .sidebar
        {
            float: left;
            width: 100px;
            margin-top: 50px;
            margin-left: 30px;
        }
        .reportContent
        {
            float: left;
            margin-left: 50px;
        }
        .page-header
        {
            border-bottom-color: #c0c0c0;
            border-bottom-style: solid;
            border-bottom-width: 1px;
            margin-left:250px;
            margin-top:20px;
            color: #4D4D4D;
            line-height: 40px;
            font-size: 24.5px;
            font-weight: bold;
            width: 600px;
        }
        a:focus
        {
            outline: none;
        }
        ul.sidenav
        {
            text-align: center;
            line-height: 35px;
            font-size: 9pt;
            float: left;
            width: 100px;
            list-style: none;
            position: fixed;
        }
        ul.sidenav li a
        {
            display: block;
            color: #000000;
            text-decoration: none;
            width: 98px;
            border: 1px solid #C9CBCB;
        }
        ul.sidenav li a:hover
        {
            color: White;
            background: #b63b4d;

        }
        
        .custom
        {
            border-spacing: 10px;
            text-align: right;
            margin-left:190px;
            margin-top:10px;
        }
        .custom > tbody > tr > td:first-child
        {
            width: 240px;
        }
         #cp_ASPxTreeView1 .lm
        {
            white-space: normal;
            width: 500px;
        }
    </style>
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
                <div class="container" id="main">
                    <div class="row">
                        <div class="sidebar">
                            <ul id="ulmenu" class="sidenav">
                                <li onclick="OnaClick(this);"><a href="#section1">基本情况</a></li>
                                <li onclick="OnaClick(this);"><a href="#section2">暴露方式</a></li>
                                <li onclick="OnaClick(this);"><a href="#section3">暴露源严重程度</a></li>
                                <li onclick="OnaClick(this);"><a href="#section4">暴露后处理情况</a></li>
                                <li onclick="OnaClick(this);"><a href="#section5">事件其他情况</a></li>
                                <li onclick="OnaClick(this);"><a href="#section6">报告人基本情况</a></li>
                            </ul>
                            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="提交" AutoPostBack="false" Width="100px"
                                Style="position: fixed; margin-top: 222px;">
                                <ClientSideEvents Click="OnSubmit" />
                            </dx:ASPxButton>
                        </div>
                        <div class="reportContent">
                            <div id="section1" class="page-header">
                                基本情况
                            </div>
                            <div style="margin-left: 60px;">
                                <table class="custom" cellspacing="10px">
                                    <tr>
                                        <td>
                                            姓名
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtJB_Name" runat="server" Width="170px" Height="25px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            性别
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_Sex" runat="server" Height="25px" NullText="--请选择--">
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
                                    </tr>
                                    <tr>
                                        <td>
                                            年龄
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtJB_Age" runat="server" Width="170px" Height="25px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            联系方式
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtJB_LXFS" runat="server" Width="170px" Height="25px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            所在科室
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_KS" runat="server" ClientInstanceName="bgrks" Height="25px"
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
                                    </tr>
                                    <tr>
                                        <td>
                                            岗位类别
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_GWLB" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="医疗" Value="医疗" />
                                                    <dx:ListEditItem Text="护理" Value="护理" />
                                                    <dx:ListEditItem Text="医技" Value="医技" />
                                                    <dx:ListEditItem Text="工程技术" Value="工程技术" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            人员类别
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_RYLB" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="本院" Value="本院" />
                                                    <dx:ListEditItem Text="学生" Value="学生" />
                                                    <dx:ListEditItem Text="物业" Value="物业" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            技术类别
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_JSLB" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
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
                                        <td>
                                            工作年限
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtJB_GZNX" runat="server" Width="170px" Height="25px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                    <RegularExpression ValidationExpression="^([1-9]\d*)$" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="ASPxComboBoxGZNX" runat="server" ValueType="System.String" 
                                                DropDownStyle="DropDown" Width="50px" Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="年" Value="年" Selected="true" />
                                                    <dx:ListEditItem Text="月" Value="月" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            暴露时间
                                        </td>
                                        <td>
                                            <dx:ASPxTimeEdit ID="teJB_BLSJ" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                                                EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss" Height="25px">
                                            </dx:ASPxTimeEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            暴露地点
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_BLDD" runat="server" Height="25px" NullText="--请选择或输入--" DropDownStyle="DropDown">
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
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            暴露时从事何种医疗活动
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_CSHD" runat="server" Height="25px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="医疗操作" Value="医疗操作" />
                                                    <dx:ListEditItem Text="护理操作" Value="护理操作" />
                                                    <dx:ListEditItem Text="医技操作" Value="医技操作" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            接受职业卫生安全及职业暴露培训
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_JSPX" runat="server" Height="25px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            暴露前是否接种疫苗
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_JZYM" runat="server" Height="25px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            疫苗名称
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_YMMC" runat="server" Height="25px" NullText="--请选择或输入--"
                                                DropDownStyle="DropDown">
                                                <Items>
                                                    <dx:ListEditItem Text="乙肝疫苗" Value="乙肝疫苗" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            接种时间
                                        </td>
                                        <td>
                                            <dx:ASPxTimeEdit ID="teJB_JZSJ" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                                                EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss" Height="25px">
                                            </dx:ASPxTimeEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            抗体产生
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_KTCS" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            隐性感染
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_XXGR" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            接受治疗
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_JSZL" runat="server" Height="25px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="HBIg" Value="HBIg" />
                                                    <dx:ListEditItem Text="乙肝疫苗" Value="乙肝疫苗" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            处理办法
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_CLBF" runat="server" Height="25px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="复诊" Value="复诊" />
                                                    <dx:ListEditItem Text="观察" Value="观察" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            保护措施
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_BHCS" runat="server" Height="25px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="护目镜" Value="护目镜" />
                                                    <dx:ListEditItem Text="面罩" Value="面罩" />
                                                    <dx:ListEditItem Text="防护衣" Value="防护衣" />
                                                    <dx:ListEditItem Text="手套（乳胶、薄膜、其他）" Value="手套（乳胶、薄膜、其他）" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            手套
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboJB_ST" runat="server" Height="25px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="乳胶" Value="乳胶" />
                                                    <dx:ListEditItem Text="薄膜" Value="薄膜" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="section2" class="page-header">
                                暴露方式
                            </div>
                            <div style="margin-left: 60px;">
                                <table class="custom" cellspacing="10px">
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            （一）接触暴露
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            皮肤
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_JC_PF" runat="server" ValueType="System.String" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="破损" Value="破损" />
                                                    <dx:ListEditItem Text="未破损" Value="未破损" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            部位
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLFS_JC_BW" runat="server" Width="170px" Height="25px" NullText="左手食指">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            接触面积
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLFS_JC_JCMJ" runat="server" Width="170px" Height="25px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            暴露量与暴露时间
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_JC_BLSJ" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="量小时间短" Value="量小时间短" />
                                                    <dx:ListEditItem Text="量大时间长" Value="量大时间长" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            污染物来源
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_JC_WRWLY" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="血液" Value="血液" />
                                                    <dx:ListEditItem Text="何种体液" Value="何种体液" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            （二）针刺伤或锐器刺伤
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            器械类型
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_QX_LX" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="空心针" Value="空心针" />
                                                    <dx:ListEditItem Text="实心针" Value="实心针" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            损伤程度
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_QX_SSCD" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="表皮擦伤" Value="表皮擦伤" />
                                                    <dx:ListEditItem Text="针刺" Value="针刺" />
                                                    <dx:ListEditItem Text="切割伤" Value="切割伤" />
                                                    <dx:ListEditItem Text="伤口较深，器械可见血液" Value="伤口较深，器械可见血液" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            污染物来源
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_QX_WRWLY" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="血液" Value="血液" />
                                                    <dx:ListEditItem Text="何种体液" Value="何种体液" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            （三）其他方式
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            破损出血
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_QT_PSCX" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            （四）关联操作
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            关联操作
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLFS_GLCZ" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="复帽" Value="复帽" />
                                                    <dx:ListEditItem Text="采血" Value="采血" />
                                                    <dx:ListEditItem Text="注射" Value="注射" />
                                                    <dx:ListEditItem Text="收集废物" Value="收集废物" />
                                                    <dx:ListEditItem Text="缝合" Value="缝合" />
                                                    <dx:ListEditItem Text="拔导管" Value="拔导管" />
                                                    <dx:ListEditItem Text="换药" Value="换药" />
                                                    <dx:ListEditItem Text="实验操作" Value="实验操作" />
                                                    <dx:ListEditItem Text="处理针头" Value="处理针头" />
                                                    <dx:ListEditItem Text="打开安瓿" Value="打开安瓿" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="section3" class="page-header">
                                暴露源严重程度
                            </div>
                            <div style="margin-left: 60px;">
                                <table class="custom" cellspacing="10px">
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            来源患者资料
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            患者姓名
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLY_HZXM" runat="server" Width="170px" Height="25px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            住院号
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLY_HZZYH" runat="server" Width="170px" Height="25px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            科室
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLY_HZKS" runat="server" ClientInstanceName="bgrks" Height="25px"
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
                                    </tr>
                                    <tr>
                                        <td>
                                            无症状感染者
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLY_WZZGRZ" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="HIV" Value="HIV" />
                                                    <dx:ListEditItem Text="HBsAGg" Value="HBsAGg" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            患者
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLY_HZBQ" runat="server" ValueType="System.String" NullText="--请选择或输入--"
                                                Height="25px" DropDownStyle="DropDown">
                                                <Items>
                                                    <dx:ListEditItem Text="乙肝" Value="乙肝" />
                                                    <dx:ListEditItem Text="梅毒" Value="梅毒" />
						                            <dx:ListEditItem Text="乙肝 梅毒" Value="乙肝 梅毒" />
                                                    <dx:ListEditItem Text="艾滋病" Value="艾滋病" />
                                                    <dx:ListEditItem Text="丙肝" Value="丙肝" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            病毒载量
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLY_BDZL" runat="server" Width="170px" Height="25px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            CD4细胞计数
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLY_CD4" runat="server" Width="170px" Height="25px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            实验室标本
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            患者姓名
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLY_BB_HZXM" runat="server" Width="170px" Height="25px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            住院号
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLY_BB_HZZYH" runat="server" Width="170px" Height="25px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            体液
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLY_BB_TY" runat="server" ValueType="System.String" DropDownStyle="DropDown"
                                                Height="25px" NullText="--请选择或输入--">
                                                <Items>
                                                    <dx:ListEditItem Text="血液" Value="血液" />
                                                    <dx:ListEditItem Text="其他体液" Value="其他体液" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            病毒载量
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLY_BB_BDZL" runat="server" Width="170px" Height="25px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            备注
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            HBV
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboHBV" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="阴性" Value="阴性" />
                                                    <dx:ListEditItem Text="阳性" Value="阳性" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            HCV
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboHCV" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="阴性" Value="阴性" />
                                                    <dx:ListEditItem Text="阳性" Value="阳性" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            HIV
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboHIV" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="阴性" Value="阴性" />
                                                    <dx:ListEditItem Text="阳性" Value="阳性" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="section4" class="page-header">
                                暴露后处理情况
                            </div>
                            <div style="margin-left: 60px;">
                                <table class="custom">
                                    <tr>
                                        <td colspan="2" style="font-size: 14px; font-weight: bold; color: #4D4D4D; text-align: left;">
                                            皮肤
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            清水冲洗
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLH_PF_QSCX" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            是否用肥皂
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLH_PF_FZ" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            挤出伤口血液
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLH_PF_XY" runat="server" ValueType="System.String" Height="25px"
                                                NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="是" Value="是" />
                                                    <dx:ListEditItem Text="否" Value="否" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            应用消毒剂名称
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtBLH_PF_XDJMC" runat="server" Width="170px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            冲洗时间
                                        </td>
                                        <td>
                                            <dx:ASPxTimeEdit ID="teBLH_PF_CXSJ" runat="server" EditFormat="Custom" EditFormatString="HH:mm:ss" DisplayFormatString="HH:mm:ss">
                                            </dx:ASPxTimeEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            冲洗溶液
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cboBLH_PF_CXRY" runat="server" ValueType="System.String" DropDownStyle="DropDown"
                                                NullText="--请选择或输入--">
                                                <Items>
                                                    <dx:ListEditItem Text="0.9%氯化钠" Value="0.9%氯化钠" />
                                                    <dx:ListEditItem Text="清水" Value="清水" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            备注
                                        </td>
                                        <td>
                                            <dx:ASPxMemo ID="ASPxMemoBLH_BZ" runat="server" Height="71px" Width="280px">
                                            </dx:ASPxMemo>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="section5" class="page-header">
                                事件其他情况
                            </div>
                            <div style="margin-left: 60px;">
                                <table class="custom">
                                    <tr>
                                        <td>
                                            报告时间
                                        </td>
                                        <td>
                                            <dx:ASPxTimeEdit ID="ASPxTimeEditReport" runat="server" DisplayFormatString="yyyy-MM-dd HH:mm:ss"
                                                Width="280px" EditFormat="Custom" EditFormatString="yyyy-MM-dd HH:mm:ss">
                                            </dx:ASPxTimeEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            事件类型
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="ASPxComboBoxEType" runat="server" Height="25px" DropDownStyle="DropDown"
                                                Width="280px" NullText="--请选择--">
                                                <Items>
                                                    <dx:ListEditItem Text="血液" Value="血液" />
                                                    <dx:ListEditItem Text="体液" Value="体液" />
                                                    <dx:ListEditItem Text="感染性职业暴露" Value="感染性职业暴露" />
                                                    <dx:ListEditItem Text="放射性职业暴露" Value="放射性职业暴露" />
                                                    <dx:ListEditItem Text="化学性（消毒剂、某些化学药品）职业暴露" Value="化学性（消毒剂、某些化学药品）职业暴露" />
                                                    <dx:ListEditItem Text="锐器伤" Value="锐器伤" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            事件描述
                                        </td>
                                        <td>
                                            <dx:ASPxMemo ID="ASPxMemoDetails" runat="server" Height="71px" Width="280px">
                                            </dx:ASPxMemo>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            事件等级
                                        </td>
                                        <td style="text-align: left;">
                                            <%--<dx:ASPxRadioButtonList ID="ASPxRadioButtonList1" runat="server" Height="25px" Width="500px">
                                                <Items>
                                                    <dx:ListEditItem Text="Ⅰ级事件（警训事件）—非预期的死亡，或是非疾病自然进展过程中造成永久性功能丧失，手术错误等。" Value="Ⅰ级事件（警训事件）—非预期的死亡，或是非疾病自然进展过程中造成永久性功能丧失，手术错误等。" />
                                                    <dx:ListEditItem Text="Ⅱ级事件（不良后果事件）—在疾病医疗过程中是因诊疗活动而非疾病本身造成的病人机体与功能损害，及造成同等后果的其他同级事件。"
                                                        Value="Ⅱ级事件（不良后果事件）—在疾病医疗过程中是因诊疗活动而非疾病本身造成的病人机体与功能损害，及造成同等后果的其他同级事件。" />
                                                    <dx:ListEditItem Text="Ⅲ级事件（未造成后果事件）—虽然发生了错误事实，但未给病人机体与功能造成任何损害，或有轻微后果而不需要任何处理可完全康复，及其他同级事件。"
                                                        Value="Ⅲ级事件（未造成后果事件）—虽然发生了错误事实，但未给病人机体与功能造成任何损害，或有轻微后果而不需要任何处理可完全康复，及其他同级事件。" />
                                                    <dx:ListEditItem Text="Ⅳ级事件（临界错误事件）—由于及时发现，错误在对患者实施之前被发现并得到纠正，患者最终没有得到错误的医疗护理服务，及其他同级事件"
                                                        Value="Ⅳ级事件（临界错误事件）—由于及时发现，错误在对患者实施之前被发现并得到纠正，患者最终没有得到错误的医疗护理服务，及其他同级事件" />
                                                </Items>
                                            </dx:ASPxRadioButtonList>--%>
                                            <dx:ASPxTreeView ID="ASPxTreeView1" runat="server"  Width="500px" AllowCheckNodes="True"
                                                CheckNodesRecursive="True" ShowExpandButtons="False" ShowTreeLines="False" AllowSelectNode="True"
                                                ClientInstanceName="trvEGrade">
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
                                                    <dx:TreeViewNode Text="Ⅰ级事件（警训事件）-此项不涉及" AllowCheck="False">
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="Ⅱ级事件（不良后果事件）" AllowCheck="False">
                                                        <Nodes>
                                                            <dx:TreeViewNode Text="3级暴露:(1)暴露源为体液、血液或者含有体液、血液的医疗器械、物品;(2)暴露类型为暴露源刺伤或者割伤皮肤,但损伤程度较重,为深部伤口或者割伤物有明显可见的血液">
                                                            </dx:TreeViewNode>
                                                        </Nodes>
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="Ⅲ级事件（未造成后果事件）" AllowCheck="False">
                                                        <Nodes>
                                                            <dx:TreeViewNode Text="2级暴露:(1)暴露源为体液、血液或者含有体液、血液的医疗器械、物品;(2)暴露类型为暴露源沾染了有损伤的皮肤或者黏膜,暴露量大且暴露时间较长;或者暴露类型为暴露源刺伤或者割伤皮肤,但损伤程度较轻,为表皮擦伤或者针刺伤">
                                                            </dx:TreeViewNode>
                                                        </Nodes>
                                                    </dx:TreeViewNode>
                                                    <dx:TreeViewNode Text="Ⅳ级事件（临界错误事件）" AllowCheck="False">
                                                        <Nodes>
                                                            <dx:TreeViewNode Text="1级暴露:(1)暴露源为体液、血液或者含有体液、血液的医疗器械、物品;(2)暴露类型暴露源沾染了有损伤的皮肤或者黏膜,暴露量小且暴露时间较短">
                                                            </dx:TreeViewNode>
                                                        </Nodes>
                                                    </dx:TreeViewNode>
                                                </Nodes>
                                                <Border BorderColor="#a1a7ab" BorderStyle="Solid" BorderWidth="1px" />
                                            </dx:ASPxTreeView>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="section6" class="page-header">
                                报告人基本情况
                            </div>
                            <div style="margin-left: 60px;">
                                <table class="custom">
                                    <tr>
                                        <td>
                                            所在科室
                                        </td>
                                        <td colspan="2">
                                            <dx:ASPxComboBox ID="cborClinicalDept" runat="server" ClientInstanceName="bgrks"
                                                DataSourceID="SqlDataSourceKS" Height="25px" TextFormatString="{0}" DisplayFormatString="{1}" CallbackPageSize="10"
                                                EnableCallbackMode="True" AllowMouseWheel="False" IncrementalFilteringMode="StartsWith"
                                                FilterMinLength="2" TextField="DeptName" ValueField="DeptId" ValueType="System.String"
                                                NullText="--拼音检索--">
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
                                    </tr>
                                    <tr>
                                        <td>
                                            岗位类别
                                        </td>
                                        <td colspan="2">
                                            <dx:ASPxComboBox ID="cborPostCategory" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
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
                                        <td>
                                            人员类别
                                        </td>
                                        <td colspan="2">
                                            <dx:ASPxComboBox ID="cborPersonCategory" runat="server" ValueType="System.String"
                                                NullText="--请选择--" Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="本院" Value="本院" />
                                                    <dx:ListEditItem Text="学生" Value="学生" />
                                                    <dx:ListEditItem Text="物业" Value="物业" />
                                                    <dx:ListEditItem Text="其他" Value="其他" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            技术类别
                                        </td>
                                        <td colspan="2">
                                            <dx:ASPxComboBox ID="cborTechCategory" runat="server" ValueType="System.String" NullText="--请选择--"
                                                Height="25px">
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
                                        <td>
                                            工作年限
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtrWorkYears" runat="server" Width="110px" Height="25px"  >
                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ValidationGroup="pageVG"
                                                    SetFocusOnError="true">
                                                    <RequiredField IsRequired="true" />
                                                    <RegularExpression ValidationExpression="^([1-9]\d*)$" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                            </td>
                                            <td>
                                            <dx:ASPxComboBox ID="ASPxComboBoxDW" runat="server" ValueType="System.String" 
                                                DropDownStyle="DropDown" Width="50px" Height="25px">
                                                <Items>
                                                    <dx:ListEditItem Text="年" Value="年" Selected="true" />
                                                    <dx:ListEditItem Text="月" Value="月" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    </form>
</body>
</html>
