<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryGZL.aspx.cs" Inherits="Project.WebUi.MZSSB.QueryGZL" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>工作量查询</title>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function loadCss() {
            var cls = top.document.getElementById("cssfile").href.split("/");
            var css = "../css/" + cls[cls.length - 1];
            window.document.getElementById("cssfile").href = css;
        }
        window.onload = loadCss;

        function printpage(myDiv) { //DIV控制打印

            //var newstr = document.all.item(myDiv).innerHTML; 
            var newstr = document.getElementById(myDiv).innerHTML;
            //     alert(newstr);
            var oldstr = document.body.innerHTML;
            document.body.innerHTML = newstr;
            window.print();
            document.body.innerHTML = oldstr;
            return false;
        }
    </script>
    <style>
           table td {
            word-wrap:break-word;
            word-break:break-all;
        }
     
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td style="text-align: center; font-size: 22px; width: 400px;">麻醉手术部工作量统计表</td>
                    <td>
                        <dx:ASPxTimeEdit ID="ASPxTimeEdit1" runat="server" DisplayFormatString="yyyy-MM" Width="100px" EditFormat="Custom" EditFormatString="yyyy-MM"></dx:ASPxTimeEdit>
                    </td>
                    <td>
                        <asp:Button ID="btnQuery" runat="server" Text="查询" OnClick="btnQuery_Click" CssClass="button blue medium" />
                    </td>
                    <td>
                        <input type="button" id="bt" onclick="javascript: printpage('myDiv')" value="打印" class="button blue medium" /></td>
                    <td style="text-align: center; font-size: 22px; width: 300px;"><%=ASPxTimeEdit1.DateTime.ToString("yyyy年MM月") %></td>
                </tr>
            </table>
        </div>
        <div id="myDiv" style="overflow: auto; width: 100%;">
            <table class="msgtable" style="width:1180px;">

                <tr>
                    <td colspan="9">工作量实际得分=个人工作量∕平均工作量*60</td>
                    <td colspan="5">本月总计工作量</td>
                    <td colspan="5">
                        <asp:Label ID="lblSum" runat="server" Text=""></asp:Label></td>
                    <td colspan="5">本月平均工作量</td>
                    <td colspan="5">
                        <asp:Label ID="lblAVE" runat="server" Text=""></asp:Label></td>
                    <td colspan="5"></td>
                </tr>
                <tr align="center">
                    <th style="width: 60px;">姓名</th>
                    <th style="width: 21px;">1号</th>
                    <th style="width: 21px;">2号</th>
                    <th style="width: 21px;">3号</th>
                    <th style="width: 21px;">4号</th>
                    <th style="width: 21px;">5号</th>
                    <th style="width: 21px;">6号</th>
                    <th style="width: 21px;">7号</th>
                    <th style="width: 21px;">8号</th>
                    <th style="width: 21px;">9号</th>
                    <th style="width: 29px;">10号</th>
                    <th style="width: 29px;">11号</th>
                    <th style="width: 29px;">12号</th>
                    <th style="width: 29px;">13号</th>
                    <th style="width: 29px;">14号</th>
                    <th style="width: 29px;">15号</th>
                    <th style="width: 29px;">16号</th>
                    <th style="width: 29px;">17号</th>
                    <th style="width: 29px;">18号</th>
                    <th style="width: 29px;">19号</th>
                    <th style="width: 29px;">20号</th>
                    <th style="width: 29px;">21号</th>
                    <th style="width: 29px;">22号</th>
                    <th style="width: 29px;">23号</th>
                    <th style="width: 29px;">24号</th>
                    <th style="width: 29px;">25号</th>
                    <th style="width: 29px;">26号</th>
                    <th style="width: 29px;">27号</th>
                    <th style="width: 29px;">28号</th>
                    <th style="width: 29px;">29号</th>
                    <th style="width: 29px;">30号</th>
                    <th style="width: 29px;">31号</th>
                    <th style="width: 28px;">合计</th>
                    <th style="width: 28px;">实际得分</th>
                </tr>
                <asp:Repeater ID="rptList" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("operateUser")%></td>
                            <td><%#Eval("1")%></td>
                            <td><%#Eval("2")%></td>
                            <td><%#Eval("3")%></td>
                            <td><%#Eval("4")%></td>
                            <td><%#Eval("5")%></td>
                            <td><%#Eval("6")%></td>
                            <td><%#Eval("7")%></td>
                            <td><%#Eval("8")%></td>
                            <td><%#Eval("9")%></td>
                            <td><%#Eval("10")%></td>
                            <td><%#Eval("11")%></td>
                            <td><%#Eval("12")%></td>
                            <td><%#Eval("13")%></td>
                            <td><%#Eval("14")%></td>
                            <td><%#Eval("15")%></td>
                            <td><%#Eval("16")%></td>
                            <td><%#Eval("17")%></td>
                            <td><%#Eval("18")%></td>
                            <td><%#Eval("19")%></td>
                            <td><%#Eval("20")%></td>
                            <td><%#Eval("21")%></td>
                            <td><%#Eval("22")%></td>
                            <td><%#Eval("23")%></td>
                            <td><%#Eval("24")%></td>
                            <td><%#Eval("25")%></td>
                            <td><%#Eval("26")%></td>
                            <td><%#Eval("27")%></td>
                            <td><%#Eval("28")%></td>
                            <td><%#Eval("29")%></td>
                            <td><%#Eval("30")%></td>
                            <td><%#Eval("31")%></td>
                            <td><%#Eval("hj")%></td>
                            <td><%# GetSJDF(Eval("hj").ToString())%></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <%--                <tr>
                    <td colspan="100" align="right"><%=pagetext %></td>
                </tr>--%>
            </table>
        </div>
    </form>
</body>
</html>
