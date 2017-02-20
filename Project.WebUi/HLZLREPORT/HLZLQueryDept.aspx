<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HLZLQueryDept.aspx.cs" Inherits="Project.WebUi.HLZLREPORT.HLZLQueryDept" %>
<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>国家护理质量数据科室上报统计查询</title>
    <link  id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
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
    <div class="Main" align="center">
            <div class="top" style="width: 100%">
                <table width="100%" border="0" class="tftableTop">
                    <tr>
                        <td colspan="8" align="center" style="font-weight: bold; font-size: 28px; text-align: center;">国家护理质量数据科室信息查询
                    </td>
                </tr>
                    <tr style="margin-top: 10px;">
                        <td align="left">
                            <label id="SBKSNAME" style="font-weight: bold; font-size: 15px;">
                                上报科室</label></td>
                        <td align="left">
                            <dx:ASPxDropDownEdit ID="ASPxDropDownEditDept" runat="server" ReadOnly="true" ClientInstanceName="dde"
                                AutoPostBack="false">
                            </dx:ASPxDropDownEdit>
                        </td>
                        <td align="right">
                            <asp:Label ID="sbsj" runat="server" Style="font-weight: bold">上报时间：</asp:Label></td>
                        <td align="left" class="auto-style1">
                            <dx:ASPxTimeEdit ID="YearTimeEdit" runat="server" DisplayFormatString="yyyy" EditFormat="Date" EditFormatString="yyyy" Width="70px" HorizontalAlign="Left"></dx:ASPxTimeEdit>
                        </td>
                        <td align="left" style="width: 60px;">
                            <asp:Label ID="year" runat="server" Style="font-weight: bold" Text="年，第"></asp:Label></td>
                        <td align="left" style="width: 10px;">
                            <asp:DropDownList ID="sbReason" runat="server" Font-Size="15px">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                        </asp:DropDownList>
                                </td>
                        <td align="left" style="width: 40px;">
                            <asp:Label ID="season" runat="server" Style="font-weight: bold">季度</asp:Label></td>
                        <td>
                            <asp:Button ID="querysubmit" runat="server" Text="查询" CssClass="button blue medium" OnClick="submit_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        <div class="bottom">
             <asp:GridView ID="GridView1" runat="server" CssClass="msgtable"  AutoGenerateColumns="False" EmptyDataText="空" OnDataBinding="GridView1_DataBinding" OnRowCreated="GridView1_RowCreated" OnRowDataBound="GridView1_RowDataBound" ShowFooter="True" ShowHeaderWhenEmpty="True" Font-Size="15px" >
                    <Columns>
<%--                        <asp:TemplateField HeaderText="操作" ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" OnClientClick="if(!confirm('确认要删除吗？')) return false;"
                                    CausesValidation="False" CommandName="Delete" Text="删除" UseSubmitBehavior="False" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:BoundField DataField="id" HeaderText="序号" />
                        <asp:BoundField DataField="report_dept" HeaderText="上报科室" />
                        <asp:BoundField DataField="report_date" DataFormatString="{0:yyyy年MM月dd日}" HtmlEncode="false"
                            HeaderText="上报时间" />
                        <asp:BoundField DataField="bb_zrhs" HeaderText="白班责任护士数" />
                        <asp:BoundField DataField="yb_zrhs" HeaderText="夜班责任护士数" />
                        <asp:BoundField DataField="bb_szhz" HeaderText="白班收治患者数" />
                        <asp:BoundField DataField="yb_szhz" HeaderText="夜班收治患者数" />
                        <asp:BoundField DataField="zg_work_time" HeaderText="在岗执业护士实际上班小时数" />
                        <asp:BoundField DataField="wcg_days" HeaderText="胃肠管（经口鼻）留置总日数" />
                        <asp:BoundField DataField="zy_stys" HeaderText="住院患者身体约束日数" />
                        <asp:BoundField DataField="yc_gwhz" HeaderText="压疮高危患者例数" />
                        <asp:BoundField DataField="zc_ddhz" HeaderText="坠床/跌倒高危患者例数" />
                    </Columns>
                </asp:GridView>
            </div>
        
    </div>
    </form>
</body>
</html>
