<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoleEdit.aspx.cs" Inherits="Project.WebUi.SystemManage.RoleEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>编辑角色</title>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    function CheckFrom(){
        var txtRoleName=document.getElementById("txtRoleName").value;
        if(txtRoleName==""){alert("请填写角色名称");return false;}
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
    
    <table width="100%"  class="msgtable" style="height:100px">
        <tr>
            <td align="right">角色名称：</td>
            <td align="left"><asp:TextBox ID="txtRoleName" runat="server"/></td>
        </tr>
        <tr>
            <td align="right">角色描述：</td>
            <td align="left"><asp:TextBox ID="txtRoleDesc" runat="server"/></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnSave" runat="server"  Text="保存" CssClass="button blue small"  onclick="btnSave_Click" OnClientClick="CheckFrom()" />

            </td>
        </tr>
    </table>
    
    </form>
</body>
</html>