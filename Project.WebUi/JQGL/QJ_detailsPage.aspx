<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QJ_detailsPage.aspx.cs" Inherits="Project.WebUi.JQGL.QJ_detailsPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>请假详细信息</title>
     <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/lhgdialog.min.js?skin=discuz"" type="text/javascript"></script>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
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
         <div class="navigation"><p style="text-align: center; font-size: 20px; font-weight: bold;"><asp:Label ID="TitleName" runat="server" Text="XXX"></asp:Label>请假明细</p></div>
<%--    <div class="search">
    用户编号：<asp:TextBox ID="txtUserID" runat="server" Width="100"/>
    用户名：<asp:TextBox ID="txtUserName" runat="server" Width="100"/>
    &nbsp;&nbsp;<asp:Button ID="btnSearch" runat="server" Text="查询" onclick="btnSearch_Click" CssClass="button blue small" />
    </div>--%>
    <div style="margin:1px 5px 1px 5px; border:4px Solid #d3d3d3;">
    <table width="100%"  class="msgtable">
          <tr align="center">
            <th>用户编号</th>
            <th>用户名称</th>
            <th>请假日期</th>
            <th>请假天数</th>
            <th>请假原因</th>
            <th>批准人</th>
          </tr>
       <asp:Repeater ID="rptList" runat="server">
            <ItemTemplate>
              <tr>
                <td><%#Eval("UserId")%></td>
                <td><%#GetUserName(Eval("UserId").ToString())%></td>
                <td><%#ConvertDateFormat(Eval("QjDate").ToString())%></td>
                  <td><%#Eval("QjDays")%></td>
                <td><%#Eval("Reason")%></td>
                 <td><%#GetApproverName(Eval("ApproverId").ToString())%></td>
              </tr>
            </ItemTemplate>
        </asp:Repeater>
        <tr><td colspan="100" align="right"><%=pagetext %></td></tr>
      </table>
    </div>
    </form>
</body>
</html>
