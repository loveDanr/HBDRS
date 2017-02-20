<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QJ_leavePage.aspx.cs" Inherits="Project.WebUi.JQGL.QJ_leavePage" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>请假</title>
</head>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function loadCss() {
            var cls = top.document.getElementById("cssfile").href.split("/");
            var css = "../css/" + cls[cls.length-1];
            window.document.getElementById("cssfile").href = css;
        }
        window.onload = loadCss;
    </script>
<body>
    <form id="form1" runat="server">
        <div class="navigation"><p style="text-align: center; font-size: 20px; font-weight: bold;"><asp:Label ID="DeptName" runat="server" Text="XXX"></asp:Label>请假条</p></div>
   <table width="100%"  class="msgtable">
        <tr>
            <td align="right">请假人：</td>
            <td align="left"><asp:Label ID="txt_Username" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td align="right">请假日期：</td>
            
            <td align="left"><table style="width=350px;"><td><dx:ASPxTimeEdit ID="startDate" runat="server"  DisplayFormatString="yyyy-MM-dd" Width="120px" EditFormat="Custom" EditFormatString="yyyy-MM-dd" OnDateChanged="CountBtn_Click" AutoPostBack="true"></dx:ASPxTimeEdit></td><td><asp:Label ID="Label1" runat="server" Text="至"></asp:Label></td><td><dx:ASPxTimeEdit ID="endDate" runat="server"  DisplayFormatString="yyyy-MM-dd" Width="120px" EditFormat="Custom" EditFormatString="yyyy-MM-dd" OnDateChanged="CountBtn_Click" AutoPostBack="true"></dx:ASPxTimeEdit></td><td><asp:Button ID="CountBtn" runat="server" Text="共计" OnClick="CountBtn_Click"/>&nbsp;&nbsp;<asp:Label ID="Days_label" runat="server" Text="Label"></asp:Label><asp:Label ID="Label3" runat="server" Text="天"></asp:Label></td></table></td>
        </tr>
        <tr>
            <td align="right">请假原因：</td>
            <td align="left"><asp:TextBox ID="txt_Reason" runat="server" TextMode="MultiLine" Height="200px" Width="350px" /></td>
        </tr>
        <tr>
            <td align="right">批准人：</td>
            <td align="left"><asp:Label ID="txt_ApproverId" runat="server" Text="Label"></asp:Label>
            </td>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnSave" CssClass="button blue small" runat="server"  Text="保存" OnClientClick="return checkNull(form1)" OnClick="btnSave_Click"/>
               <%-- <input id="btnBack" type="button" value="返回" onclick="javascript:window.location.href='UserList.aspx'" />--%>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
