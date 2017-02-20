<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermissionSet.aspx.cs" Inherits="Project.WebUi.SystemManage.PermissionSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>分配权限</title>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        function loadCss() {
            var cls = top.document.getElementById("cssfile").href.split("/");
            var css = "../css/" + cls[cls.length-1];
            window.document.getElementById("cssfile").href = css;
        }
        window.onload = loadCss;
    function chkParent(obj,id) {
        var chk = document.getElementById(id).getElementsByTagName("input");
        for (var i = 0; i < chk.length; i++) {
            if (chk[i].type == "checkbox") {
                chk[i].checked = obj.checked;
            }
        }
    }
    function chkChild(obj, id) {
        obj.checked = false;
        var chk = document.getElementById(id).getElementsByTagName("input");
        for (var i = 0; i < chk.length; i++) {
            if (chk[i].type == "checkbox") {
                if (chk[i].checked) {
                    obj.checked = true;
                    break;
                }
            }
        }
    }
    function getCheckedIds(){
        var ids="";
        var objs = document.getElementsByTagName("input");
        for(var i=0;i<objs.length;i++){
            if(objs[i].type=="checkbox" && objs[i].checked){
                ids+=objs[i].value+",";
            }
        }
        return ids;
    }
    function savepermission(roleId) {
        var ids = getCheckedIds();
        if ($.trim(ids) == "") ids = "-1";

        $.ajax({
            type: 'post',
            dataType: 'text',
            url: 'PermissionSet.aspx',
            data: 'ids=' + ids + '&RoleId=' + roleId,
            beforeSend: function () { },
            success: function (data) {
                if (data != null && data == "1") {
                    alert("操作成功");
                    window.location.href = "PermissionSet.aspx?RoleId=" + roleId;
                }
                else
                    alert('操作失败');
            },
            error: function (status) { if (status == 'error') { alert('系统发生错误'); } }
        });
    }
    </script>
    <style type="text/css">
    .ChildSpan{
    width:220px;display:block;float:left;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table class="msgtable">
    <asp:Literal ID="litChild" runat="server"/>
        <tr>
            <td align="center">
                <input id="btnSave" class="button blue small" type="button" value="保存" onclick='<%= "savepermission("+ Request["RoleId"]+")"%>' />
                <input id="btnReturn" class="button blue small" type="button" value="返回" onclick='javascript:location.href="RoleList.aspx"; return false;' />
            </td>
        </tr>
      </table> 
      </form>
      </body>
</html>
