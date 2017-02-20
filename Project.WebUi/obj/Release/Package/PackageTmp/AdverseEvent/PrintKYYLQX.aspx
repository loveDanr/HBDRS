<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintKYYLQX.aspx.cs" Inherits="Project.WebUi.AdverseEvent.PrintKYYLQX" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  <script type="text/javascript">
        function InitHiddenScrollBar(s, e) {s.GetInputElement().style.overflowY = 'hidden'; }
  </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:620px;">
        <h2 style="text-align:center;">可疑医疗器械不良事件报告表</h2>
        <table style="width: 620px;font-size:13px; margin-left:60px;">
            <tbody>
                <tr>
                    <td style="width:60px;">
                        编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:
                    </td>
                    <td style="width:250px">
                    </td>
                    <td style="width:60px;">
                        报告来源:
                    </td>
                    <td>
                        使用单位
                    </td>
                </tr>
                <tr>
                    <td>
                        单位名称:
                    </td>
                    <td>
                        新乡市中心医院
                    </td>
                    <td>
                        联系地址:
                    </td>
                    <td>
                        新乡市金穗大道56号
                    </td>
                </tr>
                <tr>
                    <td>
                        联系电话:
                    </td>
                    <td>
                        2048948
                    </td>
                    <td>
                        邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编:
                    </td>
                    <td>
                        453000
                    </td>
                </tr>
            </tbody>
        </table>
        <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ClientInstanceName="formLayout"
            DataSourceID="SqlDataSource1" ColCount="2" EncodeHtml="False" Width="620px" >
            <Items>
                <dx:LayoutGroup Caption="患者资料" RowSpan="1" Width="300px" GroupBoxDecoration="HeadingLine">
                    <Items>
                        <dx:LayoutItem Caption="姓名" FieldName="pName">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtPName" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="年龄" FieldName="pAge">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtAge" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="性别" FieldName="pSex">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSex" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="&nbsp;预期治疗疾病<br/>或作用" FieldName="pYQZY">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoYQZL" runat="server" Width="200px" Height="50px">
                                    <ClientSideEvents Init="InitHiddenScrollBar" />
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="医疗器械情况" RowSpan="2" Width="300px" GroupBoxDecoration="HeadingLine">
                    <Items>
                        <dx:LayoutItem Caption="注册账号" FieldName="qZCZH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqZCZH" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="产品名称" FieldName="qCPMC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqCPMC" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="商品名称" FieldName="qSPMC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqSPMC" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="生产企业名称" FieldName="qSCQYMC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqSCQYMC" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="生产企业地址" FieldName="qSCQYDZ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqSCQYDZ" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="企业联系电话" FieldName="qQYLXDH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqQYLXDH" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="型号规格" FieldName="qcXHGG">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqcXHGG" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="产品编号" FieldName="qcCPBH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqcCPBH" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="产品批号" FieldName="qcCPPH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqcCPPH" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="操作人" FieldName="CZR">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtCZR" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="有效期至" FieldName="qcYXQZ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtYXQZ" runat="server" Width="200px" >
                                        <MaskSettings Mask="yyyy-MM-dd" />
                                        <ValidationSettings Display="None">
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="生产日期" FieldName="qcSCRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSCRQ" runat="server" Width="200px">
                                        <MaskSettings Mask="yyyy-MM-dd" />
                                        <ValidationSettings  Display="None">
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="停用日期" FieldName="qcTYRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtTYRQ" runat="server" Width="200px">
                                        <MaskSettings Mask="yyyy-MM-dd" />
                                        <ValidationSettings Display="None">
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="植入日期" FieldName="qcZRRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtZRRQ" runat="server" Width="200px">
                                        <MaskSettings Mask="yyyy-MM-dd" />
                                        <ValidationSettings Display="None">
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件发生初步<br/>原因分析" FieldName="eCBYYFX">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoYYFX" runat="server" Width="200px" Height="50px">
                                    <ClientSideEvents Init="InitHiddenScrollBar" />
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件初步处理<br/>情况" FieldName="eCBCLQK">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoCLQK" runat="server" Width="200px" Height="50px">
                                    <ClientSideEvents Init="InitHiddenScrollBar" />
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件报告状态" FieldName="eBGZT">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSJBGZT" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="不良事件情况" RowSpan="2" Width="300px" GroupBoxDecoration="HeadingLine">
                    <Items>
                        <dx:LayoutItem Caption="事件主要表现" FieldName="eZYBX">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoSJZYBX" runat="server" Width="200px" Height="50px">
                                    <ClientSideEvents Init="InitHiddenScrollBar" />
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件发生日期" FieldName="eFSRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtFSRQ" runat="server" Width="200px" >
                                        <MaskSettings Mask="yyyy-MM-dd" />
                                        <ValidationSettings Display="None">
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="发现或者知悉<br/>时间" FieldName="eFXHZXRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtFXHZXRQ" runat="server" Width="200px" Height="38px" >
                                        <MaskSettings Mask="yyyy-MM-dd" />
                                        <ValidationSettings Display="None">
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="医疗器械实际<br/>使用场所" FieldName="CS">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtYLQXSYCS" runat="server" Width="200px" Height="38px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件后果" FieldName="SJHG">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSJHG" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件陈述" FieldName="eSJCS">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoSJCS" runat="server" Width="200px" Height="233px">
                                    <ClientSideEvents Init="InitHiddenScrollBar" />
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="关联性评价" RowSpan="2" Width="300px" GroupBoxDecoration="HeadingLine">
                    <Items>
                        <dx:LayoutItem Caption="1、使用医疗器械与已发生/可能发生的伤害事件之<br/>间是否具有合理的先后时间顺序？" FieldName="vGLXPJ1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="270px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                            <CaptionSettings Location="Top" HorizontalAlign="Left" VerticalAlign="Middle"></CaptionSettings>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="2、已发生/可能发生的伤害事件是否属于所使用医<br/>疗器械可能导致的伤害类型？" FieldName="vGLXPJ2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="270px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                            <CaptionSettings Location="Top" HorizontalAlign="Left" VerticalAlign="Middle"></CaptionSettings>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="3、已发生/可能发生的伤害事件是否可用合并用药<br/>和/或械的作用、患者病情或其他非医疗器械因素来<br/>解释？"
                            FieldName="vGLXPJ3">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="ASPxTextBox3" runat="server" Width="270px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                            <CaptionSettings Location="Top" HorizontalAlign="Left" VerticalAlign="Middle"></CaptionSettings>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="关联性评价结果" FieldName="vGLXPJJG">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="ASPxTextBox4" runat="server" Width="270px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                            <CaptionSettings Location="Top" HorizontalAlign="Left" VerticalAlign="Middle"></CaptionSettings>
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="报告人类别" Width="300px" GroupBoxDecoration="HeadingLine">
                    <Items>
                        <dx:LayoutItem Caption="&nbsp;&nbsp;&nbsp;报告人类别" FieldName="rBGRLB" Width="76px">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="ASPxTextBox5" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="报告人" FieldName="rBGRQM">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtBGRQM" runat="server" Width="200px" ReadOnly="true">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="报告日期" FieldName="rBGRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtBGRQ" runat="server" Width="200px">
                                        <MaskSettings Mask="yyyy-MM-dd" />
                                        <ValidationSettings Display="None">
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
            </Items>
        </dx:ASPxFormLayout>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
        SelectCommand="SELECT [ID],[pName],[pAge],[pSex],[pYQZY],[eZYBX],[eFSRQ],[eFXHZXRQ],[eYLQXSYCS]+ISNULL([eQTCS],'') CS,[eSJHG]+ ISNULL(CONVERT(nvarchar(10),pDeadDate,120),'') SJHG,[eSJCS],[qCPMC],[qSPMC],[qZCZH],[qSCQYMC],[qSCQYDZ],[qQYLXDH],[qcXHGG],[qcCPBH],[qcCPPH],[qcCZR]+ISNULL([qcQTCZR],'') CZR,[qcYXQZ],[qcSCRQ],[qcTYRQ],[qcZRRQ],[eCBYYFX],[eCBCLQK],[eBGZT],[vGLXPJ1],[vGLXPJ2],[vGLXPJ3],[vGLXPJJG],[rBGRLB],[rBGRQM],[rBGRQ],[rBGKS] FROM [AE_KYYLQX] WHERE ID=@ID"
        OnSelecting="SqlDataSource1_Selecting">
        <SelectParameters>
            <asp:Parameter Name="ID" Type="Int32" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
