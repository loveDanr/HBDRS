<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GZLrecord.aspx.cs" Inherits="Project.WebUi.MZSSB.GZLrecord" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <title>日工作量录入</title>
    <style type="text/css">
        table {
            margin-top: 10px;
        }

        tr td:first-child {
            width: 200px;
        }
    </style>
    <script type="text/javascript">
        function loadCss() {
            var cls = top.document.getElementById("cssfile").href.split("/");
            var css = "../css/" + cls[cls.length - 1];
            window.document.getElementById("cssfile").href = css;
        }
        window.onload = loadCss;
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="msgtable">
                <tr>
                    <td>日期</td>
                    <td><%=System.DateTime.Now.ToString("yyyy-MM-dd")%></td>
                </tr>
                <tr>
                    <td>工作量</td>
                    <td>
                        <asp:TextBox ID="txtWorkLoad" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtWorkLoad" ErrorMessage="必填项"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtWorkLoad" ErrorMessage="录入实点数，精确到小数点3位！" ValidationExpression="^[0-9]+\.{0,1}[0-9]{0,3}$"  ></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>姓名</td>
                    <td><%=loginUser.UserName %></td>
                </tr>
                <tr>
                    <td>说明</td>
                    <td>工作量单位：小时<br />
                        分钟、小时换算：5分钟=0.08小时 10分钟=0.16小时 15分钟=0.25小时 20分钟=0.33小时 25分钟=0.41小时 30分钟=0.5小时 35分钟=0.58小时       40分钟=0.66小时 45分钟=0.75小时 50分钟=0.83小时 55分钟=0.91小时（例：5h35分钟=5.58h）
                        <br />
                        <span style="color: red;">每日工作量可录入多次，按最后一次录入为结果统计</span>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="save_Click" CssClass="button blue medium" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
