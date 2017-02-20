<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BzswbIndex.aspx.cs" Inherits="Project.WebUi.SystemManage.BzswbIndex" %>

<!DOCTYPE html>
<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>一次性洁具申报</title>
    <style type="text/css">
        .style1 {
            font-size: larger;
            text-align: center;
        }

        .style2 {
            text-align: center;
        }
    </style>
    <script  type="text/javascript">
        // <![CDATA[

        function funccc() {
            $dp.$('text10').value = $dp.cal.getP('y') + "年" + $dp.cal.getP('M') + "月" + $dp.cal.getP('W', 'WW') + "周";

        }
        function text10_onclick() {

        }

        // ]]>
    </script>
</head>
<body>
    <form id="form1" runat="server"
        style="width: 310px; text-align: center; margin: auto;">
        <div>
            &nbsp;选择日期：
        <input id="text10" runat="server" class="Wdate" type="Text" onfocus="WdatePicker({dateFmt:'yyyy年MM月'})" onclick="return funccc()" />&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <br />
        <div>
            <asp:Table ID="Table1" align="center" runat="server" GridLines="Both" Width="40px"
                HorizontalAlign="Justify" Style="text-align: center">
                <asp:TableRow runat="server" TableSection="TableBody" HorizontalAlign="Center"
                    ID="TableRow0" BackColor="#CCCCCC">
                    <asp:TableCell ID="TableCell1" runat="server" Width="100">科别</asp:TableCell>
                    <asp:TableCell ID="TableCell2" runat="server" Width="100">计划</asp:TableCell>
                    <asp:TableCell ID="TableCell3" runat="server" Width="100">经领人</asp:TableCell>

                </asp:TableRow>
                <asp:TableRow runat="server" HorizontalAlign="Center" Width="100" ID="TableRow1">
                    <asp:TableCell ID="TableCell5" runat="server" Width="100">
                        <input id="TextKS" readonly="true" runat="server" style="width: 100px; border: 0px" type="text" />
                    </asp:TableCell>
                    <asp:TableCell ID="TableCell6" runat="server" Width="100">
                        <input id="TextSl" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" runat="server" style="width: 100px; border: 0px" type="text" />
                    </asp:TableCell>
                    <asp:TableCell ID="TableCell7" runat="server" Width="100">
                        <input id="TextJLR" readonly="true" runat="server" style="width: 100px; border: 0px" type="text" />
                    </asp:TableCell>

                </asp:TableRow>
            </asp:Table>
        </div>
        <p>
            <asp:Button ID="Button1" runat="server" Text="提交" OnClick="Button1_Click" Style="height: 21px" />
            &nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" Text="查询" OnClick="btnQuery_click" />
        </p>
    </form>
</body>
</html>
