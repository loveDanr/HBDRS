<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryDCNYJ.aspx.cs" Inherits="Project.WebUi.DCNYJREPORT.QueryDCNYJ" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>多重耐药菌医院感染核心防控措施执行率统计查询</title>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
       
        var flag=false; 
        function displayDiv() 
        { 
            var div=document.getElementById("2"); 
            if(flag) 
                div.style.display="block"; 
            else 
                div.style.display="none"; 
            flag=!flag; 
        }
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
                        <td colspan="8" align="center" style="font-weight: bold; font-size: 28px; text-align: center;">多重耐药菌医院感染核心防控措施执行率统计查询
                    </td>
                </tr>
                    <tr style="margin-top: 10px;">
                        <td align="left">
                            <label id="sb_ksName" style="font-weight: bold; font-size: 15px;">
                                上报科室</label></td>
                        <td align="left">
                            <dx:ASPxDropDownEdit ID="ASPxDropDownEditDept" runat="server" ReadOnly="true" ClientInstanceName="dde"
                                AutoPostBack="false">
                                <DropDownWindowTemplate>
                                    <dx:ASPxTreeView ID="ASPxTreeViewDept" runat="server" AllowSelectNode="True" NameField="AreaID" 
                                        AutoPostBack="False" EnableCallBacks="true" TextField="AreaName" OnVirtualModeCreateChildren="ASPxTreeViewDept_VirtualModeCreateChildren">
                                        <ClientSideEvents NodeClick="function(s, e) {dde.SetKeyValue(e.node.name) ;dde.SetText(e.node.GetText());dde.HideDropDown(); e.processOnServer = false;}" />
                                    </dx:ASPxTreeView>
                                </DropDownWindowTemplate>
                            </dx:ASPxDropDownEdit>
                        </td>
                        <td align="right">
                            <asp:Label ID="sbsj" runat="server" Style="font-weight: bold">上报时间：</asp:Label></td>
                        <td align="left" class="auto-style1">
                            <dx:ASPxTimeEdit ID="YearTimeEditStart" runat="server" DisplayFormatString="yyyy-MM" EditFormat="Date" EditFormatString="yyyy-MM" Width="100px" HorizontalAlign="Left"></dx:ASPxTimeEdit>
                        </td>
                        <td align="left" style="width: 60px;">
                            <asp:Label ID="year" runat="server" Style="font-weight: bold" Text="至"></asp:Label></td>
                        <td align="left" style="width: 10px;">
                            <dx:ASPxTimeEdit ID="YearTimeEditEnd" runat="server" DisplayFormatString="yyyy-MM" EditFormat="Date" EditFormatString="yyyy-MM" Width="100px" HorizontalAlign="Left"></dx:ASPxTimeEdit>
                                </td>
                        <td align="left" style="width: 40px;">
                            &nbsp;</td>
                        <td>
                            <asp:Button ID="querysubmit" runat="server" Text="查询" CssClass="button blue medium" OnClick="submit_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        <%--<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>
         <table id="tfhover" style="width:850px;margin-top:30px"" class="msgtable">
<tr align="left">
                        <td style="text-align:center"><asp:Label ID="JCorDD" runat="server" Text="Label"></asp:Label></td>
                        <td style="text-align:center">多重耐药菌医院感染核心防控措施的例次数</td>
			            <td style="text-align:center">比率</td>
                         <td style="text-align:center">执行不到位原因</td>
                        </tr>
                        <tr align="left">
                        <td style="text-align:center"><asp:Label ID="hzjcls_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        <td style="text-align:center"><asp:Label ID="yxzxls_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
<td style="text-align:center"><asp:Label ID="per_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                            <td style="text-align:center"><a id="a1" class="button blue small" style="text-align:center" runat="server" href="#" onclick="displayDiv()">查看详情</a></td>
                            
                        </tr>
</table>
        <div id="2" style="display:none;border:none;width:850px" class="bottom" >
           
                <table id="tfhover" style="border:none;width:850px" class="msgtable" >
                  
                    <tr align="left"><td style="font-size:15px;font-weight:bold;border:none">核心防控措施执行不到位原因：</td></tr>
                        <tr align="center">
                            <th style="width: 100%">不合格项目</th>
                            <th>例次数</th>
                        </tr>
                        <tr>
                            <td>未隔离</td>
                            <td>
                                <asp:Label ID="wgl_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>床边未备快速手消毒剂</td>
                            <td>
                                <asp:Label ID="xdj_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>工作人员手卫生执行不到位</td>
                            <td>
                                <asp:Label ID="sws_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>医务人员无菌技术操作执行不规范</td>
                            <td>
                                <asp:Label ID="wjcz_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>听诊器、体温表、血压计等诊疗用品未做到专人专用</td>
                            <td>
                                <asp:Label ID="tzq_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>患者周围物表及地面清洁消毒不到位</td>
                            <td>
                                <asp:Label ID="xdbdw_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>医疗废物分类不规范</td>
                            <td>
                                <asp:Label ID="ylfw_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="5" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>医务人员采取的防护措施不到位</td>
                            <td>
                                <asp:Label ID="fhcs_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>科室医务人员不知晓隔离患者情况</td>
                            <td>
                                <asp:Label ID="bzx_txt" runat="server" BorderStyle="None" Width="92px" MaxLength="6" Font-Size="15px"></asp:Label></td>
                        </tr>
                    <tr>
                            <td>其他</td>
                            <td>
                                <asp:Label ID="other_txt" runat="server" BorderStyle="None" Width="192px" MaxLength="6" Font-Size="10px" TextMode="MultiLine"></asp:Label></td>
                        </tr>
</table>       
            <div style="float:left;margin-top:10px"><asp:GridView ID="GridViewOther" runat="server" CssClass="msgtable"  AutoGenerateColumns="False" EmptyDataText="空" ShowFooter="True" ShowHeaderWhenEmpty="True" Font-Size="15px" OnDataBinding="GridViewOther_DataBinding" OnRowDataBound="GridViewOther_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="序号" />
                                <asp:BoundField DataField="report_dept" HeaderText="上报科室" />
                                <asp:BoundField DataField="report_date" DataFormatString="{0:yyyy年MM月}" HtmlEncode="false" HeaderText="上报月份" />
                                <asp:BoundField DataField="other" HeaderText="已上报信息中的“其他”内容" />
                            </Columns>
                        </asp:GridView>
            </div>
            </div>
        
    </div>
    </form>
</body>
</html>
