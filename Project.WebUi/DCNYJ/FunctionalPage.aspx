<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClinicalPage.aspx.cs" Inherits="Project.WebUi.DCNYJ.ClinicalPage" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>职能科室填报页面</title>
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
                        <td colspan="4" align="center" style="font-weight: bold; font-size: 28px;">多重耐药菌医院感染核心防控措施执行率
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
                            上报时间:</label>
                    </td>
                        <td>
                           <dx:ASPxTimeEdit ID="ASPxRYear" runat="server" DisplayFormatString="yyyy-MM" EditFormat="Date" EditFormatString="yyyy-MM" Width="100px"></dx:ASPxTimeEdit>
                    </td>
                        <td>
                            &nbsp;</td>
                </tr>
            </table>
            <div class="bottom">
                <table id="tfhover" class="msgtable">
                    <tr align="left">
                        <td>多重耐药菌患者督导例次数</td>
                        <td><asp:TextBox ID="TextBox1" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr align="left">
                        <td>有效执行多重耐药菌医院感染核心防控措施的例次数</td>
                        <td><asp:TextBox ID="TextBox2" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                    <tr align="left"><td style="font-size=15px; font-weight:bold">核心防控措施执行不到位原因：</td></tr>
                        <tr align="center">
                            <th style="width: 100%">不合格项目</th>
                            <th>例次数</th>
                        </tr>
                        <tr>
                            <td>未隔离</td>
                            <td>
                                <asp:TextBox ID="TextBox10" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>床边未备快速手消毒剂</td>
                            <td>
                                <asp:TextBox ID="TextBox11" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>工作人员手卫生执行不到位</td>
                            <td>
                                <asp:TextBox ID="TextBox12" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>医务人员无菌技术操作执行不规范</td>
                            <td>
                                <asp:TextBox ID="TextBox13" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>听诊器、体温表、血压计等诊疗用品未做到专人专用</td>
                            <td>
                                <asp:TextBox ID="TextBox14" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>患者周围物表及地面清洁消毒不到位</td>
                            <td>
                                <asp:TextBox ID="TextBox15" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>医疗废物分类不规范</td>
                            <td>
                                <asp:TextBox ID="TextBox16" runat="server" BorderStyle="None" Width="92px" MaxLength="5" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>医务人员采取的防护措施不到位</td>
                            <td>
                                <asp:TextBox ID="TextBox17" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>科室医务人员不知晓隔离患者情况</td>
                            <td>
                                <asp:TextBox ID="TextBox18" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
                        </tr>
                    <tr>
                            <td>其他（可自填）</td>
                            <td>
                                <asp:TextBox ID="TextBox3" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:TextBox></td>
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
