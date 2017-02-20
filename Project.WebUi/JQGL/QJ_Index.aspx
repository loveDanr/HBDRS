<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QJ_Index.aspx.cs" Inherits="Project.WebUi.JQGL.QJ_Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>假期管理主页面</title>
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/lhgdialog.min.js?skin=discuz"" type="text/javascript"></script>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function OpenDetails(url) {
            $.dialog({
                lock:true,skin: "discuz", title: '', width: '800px',
                height: 380, content: 'url:' + url, max: false, mix: false, close: function () {window.location.reload(); }
            });
        }
        function OpenQJ(url) {
            $.dialog({
                lock: true, skin: "discuz", title: '', width: '500px',
                height: 400, content: 'url:' + url, max: false, mix: false, close: function () { window.location.reload(); }
            });
        }
        function OpenZJ(url) {
            $.dialog({
                lock: true, skin: "discuz", title: '', width: '400px',
                height: 200, content: 'url:' + url, max: false, mix: false, close: function () { window.location.reload(); }
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
          <div class="navigation"><p style="text-align: center; font-size: 20px; font-weight: bold;"><asp:Label ID="Name" runat="server" Text="XXX"></asp:Label>假期一览表</p></div>
    <div class="search">
    用户名：<asp:TextBox ID="txtUserName" runat="server" Width="100"/>
    &nbsp;&nbsp;<asp:Button ID="btnSearch" runat="server" Text="查询" onclick="btnSearch_Click" CssClass="button blue small" />
    </div>
    <div style="margin:1px 5px 1px 5px; border:4px Solid #d3d3d3;">
    <table width="100%"  class="msgtable">
          <tr align="center">
            <th>用户编号</th>
            <th>用户名称</th>
            <th>共有假期</th>
            <th>已休假期</th>
            <th>剩余假期</th>
            <th>查看</th>
             <th>操作</th>
          </tr>
       <asp:Repeater ID="rptList" runat="server"  OnItemDataBound="rptList_ItemDataBound" >
            <ItemTemplate>
              <tr  align="center">
               <td><%#Eval("UserId")%></td>
                <td><%#GetUserName(Eval("UserId").ToString())%></td>
                <td><%#Eval("TotalDays")%></td>
                <td><%#Eval("RestDays")%></td>
                  <td><asp:Label ID="lbStatus" runat="server" Text='<%#Eval("LastDays")%>'></asp:Label></td>
                <td><a id="a1" class="button blue small" runat="server" href="#" onclick='<%# "OpenDetails(\"JQGL/QJ_detailsPage.aspx?UserId="+ Eval("UserId")+"\")" %>'>查看详情</a></td>  
                    <td><a id="aUpdate__UserEdit" class="button blue small" runat="server" href="#" onclick='<%# "OpenQJ(\"JQGL/QJ_leavePage.aspx?UserId="+ Eval("UserId")+"\")" %>'>请假</a> 
                    <a id="a2" class="button blue small" runat="server" href="#" onclick='<%# "OpenZJ(\"JQGL/QJ_addDaysPage.aspx?UserId="+ Eval("UserId")+"\")" %>'>增假</a> 
                </td>
              </tr>
            </ItemTemplate>
        </asp:Repeater>
      </table>
    </div>
    </form>
</body>
</html>
