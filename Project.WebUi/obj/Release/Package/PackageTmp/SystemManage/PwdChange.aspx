<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PwdChange.aspx.cs" Inherits="Project.WebUi.SystemManage.PwdChange" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="HeadPwd" runat="server">
    <title>密码修改</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function checkNull(form) {
            for (i = 0; i < form.length; i++) {
                if (form.elements[i].value == "") { //form属性的elements的首字母e要小写
                    alert("很抱歉," + form.elements[i].title + "不能为空^-^");
                    form.elements[i].focus(); //当前元素获取焦点
                    return false;
                }
            }
        }
        function reset(form)
        {
            $("input").each(function () {
                $(this).val('');
            });
        }
        function loadCss() {
            var cls = top.document.getElementById("cssfile").href.split("/");
            var css = "../css/" + cls[cls.length - 1];
            window.document.getElementById("cssfile").href = css;
        }
        window.onload = loadCss;
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return checkNull(this)">
    <table width="100%"  class="msgtable">
        <tr>
            <td align="right">原密码：</td>
            <td align="left"><asp:TextBox ID="oldPwd" runat="server" TextMode="Password"/></td>
        </tr>
		 <tr>
            <td align="right">新密码：</td>
            <td align="left"><asp:TextBox ID="newPwd" runat="server" TextMode="Password"/></td>
        </tr>
		 <tr>
            <td align="right">确认密码：</td>
            <td align="left"><asp:TextBox ID="confirmPwd" runat="server" TextMode="Password"/></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnSave" runat="server"  Text="保存" OnClientClick="return CheckForm()" onclick="btnSave_Click" />    
                <input id="btnBack" type="button" value="重置" onclick="reset()" />
            </td>
        </tr>
</table>

    </form>
</body>
</html>
