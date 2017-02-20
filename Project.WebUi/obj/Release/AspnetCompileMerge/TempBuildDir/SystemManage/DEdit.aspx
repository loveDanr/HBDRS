<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DEdit.aspx.cs" Inherits="Project.WebUi.SystemManage.DEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>部门编辑</title>
   <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">


        function checkNull(form) {
            for (i = 0; i < form.length; i++) {
                if (form.elements[i].value == "") { //form属性的elements的首字母e要小写
                    alert("很抱歉," + form.elements[i].value + "不能为空^-^");
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
    <form id="Myfrom" runat="server" onsubmit="return check(this)">

        <table width="100%" class="msgtable">
            <tr>
                <td align="right">科室编号:</td>
                <td align="left">
                    <asp:TextBox ID="txtKSBH" runat="server" Width="130px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">上级科室:</td>
                <td align="left">
                    <asp:DropDownList ID="txtBMBH" runat="server" Width="134px">

                        <asp:ListItem Value="0" Text="中心医院">中心医院</asp:ListItem>

                        <asp:ListItem Value="1" Text="防治科">防治科</asp:ListItem>

                        <asp:ListItem Value="2" Text="统计室">统计室</asp:ListItem>

                        <asp:ListItem Value="3" Text="医务处">医务处</asp:ListItem>

                    </asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td align="right">科室名称:</td>
                <td align="left">

                    <asp:TextBox ID="txtKSMC" runat="server" Width="130px"></asp:TextBox></td>

            </tr>
            <tr>
                <td align="right">科室拼音码:</td>
                <td align="left">
                    <asp:TextBox ID="txtKSPYM" runat="server" Width="130px"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">科室顺序:</td>
                <td align="left">
                    <asp:TextBox ID="txtKSSX" runat="server" Width="130px"></asp:TextBox></td>
            </tr>
            <tr style="display: none;">
                <td align="right">归属片区:</td>
                <td align="left">
                    <asp:DropDownList ID="txtGSPQ" runat="server" Width="134px">

                        <asp:ListItem Value="2" Text="内科楼片区">内科楼片区</asp:ListItem>

                        <asp:ListItem Value="3" Text="综合楼片区">综合楼片区</asp:ListItem>

                        <asp:ListItem Value="4" Text="外科片区">外科片区</asp:ListItem>

                        <asp:ListItem Value="5" Text="门诊手术部片区">门诊手术部片区</asp:ListItem>

                    </asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td align="right">科室描述:</td>
                <td align="left">
                    <asp:TextBox ID="txtKSGS" runat="server" Width="130px"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td  align="center" colspan="2">
                    <asp:Button ID="btnAdd" CssClass="button blue small" Text="保存" runat="server" Width="50px" OnClientClick="return checkNull(Myfrom)" OnClick="btnSave_Click" />
                </td>
                <%--<td align="left">
                        <asp:Button ID="btnFH" Text="返回" runat="server" Width="50px" OnClick="btnFH_Click" />

                    </td>--%>
            </tr>






        </table>
    </form>
</body>
</html>
