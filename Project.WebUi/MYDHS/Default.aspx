<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Project.WebUi.MYDHS.Default" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/style-myd.css" rel="stylesheet" type="text/css" />




</head>
<body bgcolor="#eeffff">
    <form id="form1" runat="server">
       


            <p class="head">
                <b>新乡市中心医院护士对护理工作满意度调查表</b> 
            </p>
            <div class="hd_text">
                尊敬的各位护理同仁：
            </div>
            <div class="main_text">
                为了推动医院优质护理服务的深入开展，征求、了解您对医院护理工作的意见和建议，不断改进医院护理管理工作，从而为护理人员提供一个满意的工作环境，我们设计了此调查表，在选择相应的项目，调查问卷不超过
                    10分钟，感谢您的配合！
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
                    <td width="10%" align="center">满意(5分)
                    </td>
                    <td width="15%" align="center">基本满意(4分)
                    </td>
                    <td width="15%" align="center">不满意(1分)
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>1、工作稳定感
                    </td>
                    <td align="center" >
                        <asp:RadioButton ID="R11" runat="server" Text="满意" GroupName="G1" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R12" runat="server" Text="基本满意" GroupName="G1" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R13" runat="server" Text="不满意" GroupName="G1" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>2、医院有标准化的管理流程和护理工作流程
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
                <tr bgcolor="#eeffff">
                    <td>3、职业保护设施与设备配备完善
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
                <tr bgcolor="#eeffff">
                    <td>4、人身安全保障制度与护理制度保障体系完善
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
                <tr bgcolor="#eeffff">
                    <td>5、病房配套设施使病人方便舒适且利于护理操作
                    </td>
                    <td align="center" >
                        <asp:RadioButton ID="R51" runat="server" Text="满意" GroupName="G5" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R52" runat="server" Text="基本满意" GroupName="G5" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R53" runat="server" Text="不满意" GroupName="G5" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>6、报酬与工作付出成正比
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
                <tr bgcolor="#eeffff">
                    <td>7、夜班及节假日的值班、加班补贴满足您的期望
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
                <tr bgcolor="#eeffff">
                    <td>8、工作中能得到晋升、评优的机会
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
                <tr bgcolor="#eeffff">
                    <td>9、工作中有进修、交流、学习的机会
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
                <tr bgcolor="#eeffff">
                    <td>10、您对目前科室的排班模式
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R101" runat="server" Text="满意" GroupName="G10" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R102" runat="server" Text="基本满意" GroupName="G10" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R103" runat="server" Text="不满意" GroupName="G10" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>11、科室实行弹性排班，您有足够的时间安排私人事务
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R111" runat="server" Text="满意" GroupName="G11" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R112" runat="server" Text="基本满意" GroupName="G11" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R113" runat="server" Text="不满意" GroupName="G11" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>12、您对科室护理人员配置与护理患者数量的比例
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R121" runat="server" Text="满意" GroupName="G12" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R122" runat="server" Text="基本满意" GroupName="G12" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R123" runat="server" Text="不满意" GroupName="G12" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>13、后勤保障系统能使您有更多的时间服务于病人
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R131" runat="server" Text="满意" GroupName="G13" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R132" runat="server" Text="基本满意" GroupName="G13" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R133" runat="server" Text="不满意" GroupName="G13" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>14、护理管理者能倾听和反馈您在工作中关心的问题
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R141" runat="server" Text="满意" GroupName="G14" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R142" runat="server" Text="基本满意" GroupName="G14" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R143" runat="server" Text="不满意" GroupName="G14" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>15、在工作中被误解时，能得到管理者的帮助并协作处理问题
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R151" runat="server" Text="满意" GroupName="G15" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R152" runat="server" Text="基本满意" GroupName="G15" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R153" runat="server" Text="不满意" GroupName="G15" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>16、您与同事相处和谐
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R161" runat="server" Text="满意" GroupName="G16" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R162" runat="server" Text="基本满意" GroupName="G16" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R163" runat="server" Text="不满意" GroupName="G16" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>17、您的工作得到医疗、医技、后勤人员的理解及尊重
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R171" runat="server" Text="满意" GroupName="G17" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R172" runat="server" Text="基本满意" GroupName="G17" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R173" runat="server" Text="不满意" GroupName="G17" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>18、您认为在现在的管理体制下能体现出自己的价值
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R181" runat="server" Text="满意" GroupName="G18" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R182" runat="server" Text="基本满意" GroupName="G18" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R183" runat="server" Text="不满意" GroupName="G18" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>19、您对科室间配合、同事合作的程度评价
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R191" runat="server" Text="满意" GroupName="G19" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R192" runat="server" Text="基本满意" GroupName="G19" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R193" runat="server" Text="不满意" GroupName="G19" />&nbsp;
                    </td>
                </tr>
                <tr bgcolor="#eeffff">
                    <td>20、您对医院及时为临床护理工作解决实际困难
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R201" runat="server" Text="满意" GroupName="G20" />
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R202" runat="server" Text="基本满意" GroupName="G20" />&nbsp;
                    </td>
                    <td align="center">
                        <asp:RadioButton ID="R203" runat="server" Text="不满意" GroupName="G20" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4">您对我院开展“优质护理服务”工作的意见和建议:<br />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Height="200px" Width="100%" Style="resize: none;" BorderStyle="None" Font-Size="Large"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <div class="submit">
                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="提  交" OnClick="ASPxButton1_Click">
                </dx:ASPxButton>
            </div>
       
        
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
                ProviderName="<%$ ConnectionStrings:SQLConnString.ProviderName %>"></asp:SqlDataSource>
        <br />

    </form>
</body>
</html>
