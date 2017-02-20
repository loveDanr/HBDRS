<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HLZLSB.aspx.cs" Inherits="Project.WebUi.HLZLREPORT.HLZLSB" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>国家护理质量数据科室上报统计表</title>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
        function checkNull(form) {
            for (i = 0; i < form.length; i++) {
                if (form.elements[i].type == "text")
                    if (form.elements[i].value == "") { //form属性的elements的首字母e要小写
                        alert("很抱歉," + form.elements[i].value + "不能为空^-^");
                        form.elements[i].focus(); //当前元素获取焦点

                        return false;
                    }
                    else {
                        var pattern = /^(([0-9]\d*(\.\d?[0-9])?)|(0\.[1-9][0-9])|(0\.[0][1-9]))$/;
                        if (!pattern.test(form.elements[i].value)) {
                            alert("很抱歉," + form.elements[i].value + "必须为数字！");
                            form.elements[i].focus();
                            return false;
                        }

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
<form id="form1" runat="server" onsubmit="return checkNull(this)">
    <div class="Main" align="center">
        <div class="top">
                <table border="0" class="tftableTop">
                <tr>
                        <td colspan="4" align="center" style="font-weight: bold; font-size: 28px;">国家护理质量数据科室上报统计表
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <label style="font-weight: bold">
                            上报科室:</label>
                        <asp:Label ID="sbks" runat="server"></asp:Label>
                    </td>
                    <td align="right">
                     <label style="font-weight: bold">
                            上报年份:</label>
                    </td>
                        <td>
                            <dx:ASPxTimeEdit ID="ASPxRYear" runat="server" DisplayFormatString="yyyy" EditFormat="Date" EditFormatString="yyyy" Width="70px"></dx:ASPxTimeEdit>
                    </td>
                        <td>
                        <label style="font-weight: bold">
                            上报季度:</label>
                        <asp:DropDownList ID="sbReason" runat="server" Font-Size="15px">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;
                        <label style="font-weight: bold">
                            上报日期:</label>
                        <asp:Label ID="sbsj" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div class="bottom">
                <table id="tfhover" class="msgtable">
                        <tr align="center">
                            <th style="width: 100%">项目</th>
                            <th>数量</th>
                        </tr>
                        <tr>
                            <td>白班责任护士数</td>
                            <td>
                                <asp:TextBox ID="TextBox10" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>夜班责任护士数</td>
                            <td>
                                <asp:TextBox ID="TextBox11" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>白班收治患者数</td>
                            <td>
                                <asp:TextBox ID="TextBox12" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>夜班收治患者数</td>
                            <td>
                                <asp:TextBox ID="TextBox13" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>在岗执业护士实际上班小时数</td>
                            <td>
                                <asp:TextBox ID="TextBox14" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>胃肠管（经口鼻）留置总日数</td>
                            <td>
                                <asp:TextBox ID="TextBox15" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>住院患者身体约束日数</td>
                            <td>
                                <asp:TextBox ID="TextBox16" runat="server" BorderStyle="None" Width="92px" MaxLength="5" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>压疮高危患者例数</td>
                            <td>
                                <asp:TextBox ID="TextBox17" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>坠床/跌倒高危患者例数</td>
                            <td>
                                <asp:TextBox ID="TextBox18" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
</table>
            </div>
            <div class="HLZLsubmit">
                    <table border="0">
                    <tr>
                            <td align="center" style="padding: 10px;">
                                <asp:Button ID="btnSubmit" runat="server" Text="保存" OnClick="submit_Click" CssClass="button blue medium" />

                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
