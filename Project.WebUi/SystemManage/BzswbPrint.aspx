<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BzswbPrint.aspx.cs" Inherits="Project.WebUi.SystemManage.BzswbPrint" %>

<!DOCTYPE html>
<script  type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>一次性洁具申报查询打印</title>
</head>
<body>
   <br />
    <script  type="text/javascript">


        function funccc() {
            $dp.$('text10').value = $dp.cal.getP('y') + "年" + $dp.cal.getP('M') + "月" + $dp.cal.getP('W', 'WW') + "周";
        }
        function funccc1() {
            $dp.$('text1').value = $dp.cal.getP('y') + "年" + $dp.cal.getP('M') + "月" + $dp.cal.getP('W', 'WW') + "周";
        }

    </script>
    <br />
    <br />
    <form id="form1" runat="server">
    <div style="width: 800px; margin: auto;">
        <div style="width: 400px; margin: auto;">
            选择日期：<input id="text10" runat="server" class="Wdate" type="Text" onfocus="WdatePicker({dateFmt:'yyyy年MM月'})" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="查询" />
        </div>
        <br />
        <br />
         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
            ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ShowHeaderWhenEmpty="True"
            Width="603px" DataKeyNames="ks,rq" onrowdeleting="GridView1_RowDeleting" 
             >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="ksName" HeaderText="科 别" />
                <asp:BoundField DataField="sl" HeaderText="计 划" />
                <asp:BoundField DataField="sbr" HeaderText="经领人" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" VerticalAlign="Middle" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>
    </form>
</body>
</html>
