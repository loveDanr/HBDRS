<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserEdit.aspx.cs" Inherits="Project.WebUi.SystemManage.UserEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>编辑用户</title>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function checkNull(form) {
            for (i = 0; i < form.length; i++) {
                if (form.elements[i].id != "txtDesc" && form.elements[i].value == "") { //form属性的elements的首字母e要小写
                    alert("很抱歉," + form.elements[i].title + "不能为空^-^");
                    form.elements[i].focus(); //当前元素获取焦点
                    return false;
                }
            }
            }
        function loadCss() {
            var cls = top.document.getElementById("cssfile").href.split("/");
            var css = "../css/" + cls[cls.length-1];
            window.document.getElementById("cssfile").href = css;
        }
        window.onload = loadCss;
    </script>
</head>
<body>
    <form id="form1" runat="server">
    
    <table width="100%"  class="msgtable">
        <tr>
            <td align="right">人员编码：</td>
            <td align="left"><asp:TextBox ID="txtUserCode" runat="server" MaxLength="6"/></td>
        </tr>
        <tr>
            <td align="right">用户名称：</td>
            <td align="left"><asp:TextBox ID="txtUserName" runat="server"/></td>
        </tr>
        <tr>
            <td align="right">所在科室：</td>
            <td align="left"><asp:DropDownList ID="userDept" runat="server">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td align="right">用户角色：</td>
            <td align="left">
                <asp:CheckBoxList ID="chkListRole" runat="server" RepeatDirection="Horizontal" RepeatColumns="7">
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr id="trPwd" runat="server">
            <td align="right">初始密码：</td>
            <td align="left"><asp:TextBox ID="txtUserPwd" runat="server" Text="aaaaaa"/>&nbsp;用户登陆后可自己修改</td>
        </tr>
        <tr>
            <td align="right">是否锁定：</td>
            <td align="left">
                <asp:RadioButtonList ID="rdoList" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="启用" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="禁用(注：禁用后他将不能登陆)" Value="1"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right">用户备注：</td>
            <td align="left"><asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"/></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnSave" CssClass="button blue small" runat="server"  Text="保存" OnClientClick="return checkNull(form1)" onclick="btnSave_Click" />
               <%-- <input id="btnBack" type="button" value="返回" onclick="javascript:window.location.href='UserList.aspx'" />--%>
                 <asp:Button ID="btnRestPwd" CssClass="button blue small" runat="server"  Text="初始化密码" OnClick="btnRestPwd_Click" />
            </td>
        </tr>
    </table>
    
    </form>
</body>
</html>