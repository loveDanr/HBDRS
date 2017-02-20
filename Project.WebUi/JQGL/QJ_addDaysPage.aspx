<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QJ_addDaysPage.aspx.cs" Inherits="Project.WebUi.JQGL.QJ_addDaysPage" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>假期修改</title>
</head>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        void Page_Load()
        {
            txt_totalDays.Focus();
        }
        function checkNull(form) {
            for (i = 0; i < form.length; i++) {
                if (form.elements[i].id != "txtDesc" && form.elements[i].value == "") { //form属性的elements的首字母e要小写
                    alert("很抱歉," + form.elements[i].title + "不能为空^-^，没有数据请填0");
                    form.elements[i].focus(); //当前元素获取焦点
                    return false;
                }
            }
        }

        function isnum()
        {
            if (event.keyCode < 48 || event.keyCode >57) event.returnValue = false;
        } 
        function loadCss() {
            var cls = top.document.getElementById("cssfile").href.split("/");
            var css = "../css/" + cls[cls.length-1];
            window.document.getElementById("cssfile").href = css;
        }
        window.onload = loadCss;
    </script>
<body>
    <form id="form1" runat="server">
   <div class="navigation"><p style="text-align: center; font-size: 20px; font-weight: bold;"><asp:Label ID="Name" runat="server" Text="XXX"></asp:Label>的假期天数录入/修改</p></div>
   <table width="100%"  class="msgtable">
        <tr>
            <td align="right">用户编码：</td>
            <td align="left"><asp:Label ID="txt_userid" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td align="right">用户姓名：</td>
            <td align="left"><asp:Label ID="txt_username" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td align="right">共有假期：</td>
            <td align="left">  <asp:TextBox onkeypress="isnum()" ID="txt_totalDays" runat="server" Width="50" MaxLength="4"></asp:TextBox><asp:Label ID="Label1" runat="server" Text="天"></asp:Label></td>
        </tr>
        <tr>
            <td align="right">已请假期：</td>
            <td align="left"><asp:TextBox onkeypress="isnum()" ID="txt_restDays" runat="server"  Width="50" MaxLength="4"/><asp:Label ID="Label2" runat="server" Text="天"></asp:Label></td>
        </tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnSave" CssClass="button blue small" runat="server"  Text="保存" OnClientClick="return checkNull(form1)" OnClick="btnSave_Click"/>
               <%-- <input id="btnBack" type="button" value="返回" onclick="javascript:window.location.href='UserList.aspx'" />--%>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
