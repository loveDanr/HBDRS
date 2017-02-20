<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DList.aspx.cs" Inherits="Project.WebUi.SystemManage.DList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>菜单列表</title>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/lhgdialog.min.js?skin=discuz" type="text/javascript"></script>
    <script type="text/javascript">
        function opdg(url) {
            $.dialog({
                skin: "discuz", title: '部门修改', width: '500px',
                height: 380, content: 'url:' + url, max: false, mix: false,
            });

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
        <div class="navigation"><span class="add"><a id="aAdd__DEdit" class="button blue small" runat="server"  href="#" onclick='opdg("SystemManage/DEdit.aspx")'>新增部门</a> </span><b></b></div>
        <div style="margin:1px 5px 1px 5px; border:4px Solid #d3d3d3;">
        <table width="100%"  class="msgtable">
            <tr>
                <th>科室编号</th>
                <th>上级科室</th>
                <th>科室名称</th>
                <th>科室顺序</th>
                <th>科室描述</th>
                <th>操作</th>



            </tr>
            <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
                <ItemTemplate>
                    <tr>
                        <td align="center"><%# Eval("DeptID")%></td>
                        <td align="center"><%# GetDeptName(Eval("PartntDeptID").ToString())%></td>
                        <td align="center"><%# Eval("DeptName")%></td>
                        <td align="center"><%# Eval("DeptOrderNum")%></td>
                        <td align="center"><%# Eval("DeptFunc")%></td>
                        <td align="center"><a id="aUpdate__DEdit" class="button blue small" runat="server" href="#" onclick='<%# "opdg(\"SystemManage/DEdit.aspx?DeptID="+ Eval("DeptID")+"\")" %>'>修改</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="lkBtnDelete__DList_Delete" CssClass="button blue small" runat="server" CommandName="del" CommandArgument='<%# Eval("DeptID") %>' OnClientClick="return confirm('确定要删除吗？')">删除</asp:LinkButton>
                        </td>
                        <%--  
            <td><%#Eval("ParentDeptID").ToString() == "0" ? "<strong>"+Eval("DeptName").ToString()+"</strong>" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + Eval("DeptName").ToString()%></td>
            <td><%#Eval("MenuAddress")%></td>
            <td align="center"><%# Eval("MenuOrder")%></td>
            <td align="center"><%# Eval("IsNavigation").ToString().Trim()=="0"?"否":"是"%></td>**/
            <td><a id="aUpdate__MenuEdit" runat="server" href="#" onclick='<%# "opdg(\"SystemManage/MenuEdit.aspx?MenuId="+ Eval("MenuId")+"\")" %>'>修改</a> 
                <asp:LinkButton ID="lkBtnDelete__MenuList_Delete" runat="server" CommandName="del" CommandArgument='<%# Eval("MenuId") %>' OnClientClick="return confirm('确定要删除吗？')">删除</asp:LinkButton>
            </td>--%>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>

        </table>
            </div>
    </form>
</body>
</html>
