<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Project.WebUi.MYDYS.index" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/style-myd.css" rel="stylesheet" type="text/css" />
   
</head>
<body>
    <form id="form1" runat="server">
        

        <p class="head">
            <b>新乡市中心医院医师对护理工作满意度调查表</b>
        </p>

        <div class="hd_text">
            尊敬的各位医生：
        </div>

        <div class="main_text">
            您好！为了促进医护良好协作，了解医生对护理工作意见建议，特制定此调查问卷，请您根据实际情况，真实回答以下问题。在选择相应的项目，调查问卷不超过10分钟，感谢您的配合！
           
        </div>
        <div class="text">
           &nbsp;&nbsp;性别：
                <asp:RadioButton ID="sex1" runat="server" Text="男" GroupName="sex" />
            <asp:RadioButton ID="sex2" runat="server" Text="女" GroupName="sex" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作年限：
                <asp:TextBox ID="age" runat="server" Width="25px" BorderStyle="None" Font-Size="Large"></asp:TextBox>年
        </div>

        <table align="center">
            <tr>
                <td>项目名称
                </td>
                <td width="10%" align="center">满意(10分)
                </td>
                <td width="15%" align="center">基本满意(8分) 
                </td>
                <td width="15%" align="center">不满意(2分)
                </td>
            </tr>
            <tr>
                <td>1.您对科室护理工作总体情况评价
                </td>
                <td align="center">
                    <asp:RadioButton ID="R11" runat="server" Text="满意" GroupName="G1" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R12" runat="server" Text="基本满意" GroupName="G1" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R13" runat="server" Text="不满意" GroupName="G1" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>2. 您对护士的病情观察和评判能力
                </td>
                <td align="center">
                    <asp:RadioButton ID="R21" runat="server" Text="满意" GroupName="G2" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R22" runat="server" Text="基本满意" GroupName="G2" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R23" runat="server" Text="不满意" GroupName="G2" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>3. 您对护士及时、准确执行医嘱
                </td>
                <td align="center">
                    <asp:RadioButton ID="R31" runat="server" Text="满意" GroupName="G3" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R32" runat="server" Text="基本满意" GroupName="G3" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R33" runat="server" Text="不满意" GroupName="G3" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>4. 您对护士的沟通能力及服务态度
                </td>
                <td align="center">
                    <asp:RadioButton ID="R41" runat="server" Text="满意" GroupName="G4" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R42" runat="server" Text="基本满意" GroupName="G4" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R43" runat="server" Text="不满意" GroupName="G4" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>5. 您对护士能主动及时向患者进行有效的健康宣教
                </td>
                <td align="center">
                    <asp:RadioButton ID="R51" runat="server" Text="满意" GroupName="G5" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R52" runat="server" Text="基本满意" GroupName="G5" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R53" runat="server" Text="不满意" GroupName="G5" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>6. 您对科室护理人员技术操作水平
                </td>
                <td align="center">
                    <asp:RadioButton ID="R61" runat="server" Text="满意" GroupName="G6" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R62" runat="server" Text="基本满意" GroupName="G6" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R63" runat="server" Text="不满意" GroupName="G6" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>7. 您对科室护理人员专科护理能力
                </td>
                <td align="center">
                    <asp:RadioButton ID="R71" runat="server" Text="满意" GroupName="G7" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R72" runat="server" Text="基本满意" GroupName="G7" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R73" runat="server" Text="不满意" GroupName="G7" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>8. 您对科室护理人员应急能力
                </td>
                <td align="center">
                    <asp:RadioButton ID="R81" runat="server" Text="满意" GroupName="G8" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R82" runat="server" Text="基本满意" GroupName="G8" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R83" runat="server" Text="不满意" GroupName="G8" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>9. 您对科室目前护士长对护理人力安排
                </td>
                <td align="center">
                    <asp:RadioButton ID="R91" runat="server" Text="满意" GroupName="G9" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R92" runat="server" Text="基本满意" GroupName="G9" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R93" runat="server" Text="不满意" GroupName="G9" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>10. 您对本科室医护之间配合度
                </td>
                <td align="center">
                    <asp:RadioButton ID="R101" runat="server" Text="满意" GroupName="G10" />
                </td>
                <td align="center">
                    <asp:RadioButton ID="R102" runat="server" Text="基本满意" GroupName="G10" />&nbsp;
                </td>
                <td align="center">
                    <asp:RadioButton ID="R103" runat="server" Text="不满意" GroupName="G10"  />&nbsp;
                </td>
            </tr>

            <tr>
                <td colspan="4">请写下您满意的护士:<asp:TextBox ID="TextBox1" runat="server" BorderStyle="None" Font-Size="Large"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4">请留下您宝贵的意见和建议:&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Height="200px" width="100%" style="resize:none;"  BorderStyle="None" Font-Size="Large"></asp:TextBox>
                </td>
            </tr>
             
                </table>
                <div class="submit">
                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="提  交"
                        OnClick="ASPxButton1_Click" BackgroundImage-HorizontalPosition="center" BorderBottom-BorderStyle="None" HorizontalAlign="Center">
                    </dx:ASPxButton>
                </div>
       
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
            ProviderName="<%$ ConnectionStrings:SQLConnString.ProviderName %>"></asp:SqlDataSource>
    
    </form>
</body>
</html>
