<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KYYLQX.aspx.cs" Inherits="Project.WebUi.AdverseEvent.KYYLQX"
     %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>可疑医疗器械不良事件报告</title>
    <script type="text/javascript">
        function OnrblSJHGInit(s, e) {
            if (s.GetSelectedIndex() == 0) {
                formLayout.GetItemByName("DeadDate").SetVisible(true)

            }
            else {
                formLayout.GetItemByName("DeadDate").SetVisible(false)
                ciDateDead.SetValue(null);
                ciDateDead.SetIsValid(true)
            }
        }
        function rblSJHG_SelectedIndexChanged(s, e) {
            if (s.GetSelectedIndex() == 0) {
                formLayout.GetItemByName("DeadDate").SetVisible(true)

            }
            else {
                formLayout.GetItemByName("DeadDate").SetVisible(false)
                ciDateDead.SetValue(null);
                ciDateDead.SetIsValid(true)
            }
        }
        function OnrblCZRInit(s, e) {
            if (s.GetSelectedIndex() == 3) {
                formLayout.GetItemByName("QTCZR").SetVisible(true)

            }
            else {
                formLayout.GetItemByName("QTCZR").SetVisible(false)
            }
        }
        function rblCZR_SelectedIndexChanged(s, e) {
            if (s.GetSelectedIndex() == 3) {
                formLayout.GetItemByName("QTCZR").SetVisible(true)

            }
            else {
                formLayout.GetItemByName("QTCZR").SetVisible(false)
            }
        }
        function OnrblCSInit(s, e) {
            if (s.GetSelectedIndex() == 2) {
                formLayout.GetItemByName("QTCS").SetVisible(true)

            }
            else {
                formLayout.GetItemByName("QTCS").SetVisible(false)
            }
        }
        function rblCS_SelectedIndexChanged(s, e) {
            if (s.GetSelectedIndex() == 2) {
                formLayout.GetItemByName("QTCS").SetVisible(true)

            }
            else {
                formLayout.GetItemByName("QTCS").SetVisible(false)
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ClientInstanceName="formLayout"
            DataSourceID="SqlDataSource1" ColCount="2" EncodeHtml="False" OnLayoutItemDataBound="ASPxFormLayout1_LayoutItemDataBound">
            <Items>
                <dx:LayoutGroup Caption="患者资料" RowSpan="1" Width="400px">
                    <Items>
                        <dx:LayoutItem Caption="姓名" FieldName="pName">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtPName" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="年龄" FieldName="pAge">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtAge" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="性别" FieldName="pSex">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblSex" runat="server" Width="170px" ValueType="System.String"
                                        RepeatDirection="Horizontal">
                                        <Items>
                                            <dx:ListEditItem Text="男" Value="男" />
                                            <dx:ListEditItem Text="女" Value="女" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="预期治疗疾<br/>病或作用" FieldName="pYQZY">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoYQZL" runat="server" Width="170px" Height="50px">
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="医疗器械情况" RowSpan="2" Width="400px">
                    <Items>
                        <dx:LayoutItem Caption="注册账号" FieldName="qZCZH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqZCZH" runat="server" Width="170px">
                                        <ValidationSettings>
                                            <RequiredField ErrorText="注册账号 必填" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="产品名称" FieldName="qCPMC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqCPMC" runat="server" Width="170px">
                                        <ValidationSettings>
                                            <RequiredField ErrorText="产品名称 必填" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="商品名称" FieldName="pName">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqSPMC" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="生产企业名称" FieldName="qSCQYMC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqSCQYMC" runat="server" Width="170px">
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="生产企业名称 必填" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="生产企业地址" FieldName="qSCQYDZ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqSCQYDZ" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="企业联系电话" FieldName="qQYLXDH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqQYLXDH" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="型号规格" FieldName="qcXHGG">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqcXHGG" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="产品编号" FieldName="qcCPBH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqcCPBH" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="产品批号" FieldName="qcCPPH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtqcCPPH" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="操作人" FieldName="qcCZR">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblCZR" runat="server" Width="300px" ValueType="System.String"
                                        RepeatDirection="Horizontal">
                                        <ClientSideEvents SelectedIndexChanged="rblCZR_SelectedIndexChanged" Init="OnrblCZRInit" />
                                        <Items>
                                            <dx:ListEditItem Text="专业人员" Value="专业人员 " />
                                            <dx:ListEditItem Text="非专业人员" Value="非专业人员" />
                                            <dx:ListEditItem Text="患者" Value="患者" />
                                            <dx:ListEditItem Text="其他" Value="其他" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="操作人-其他" Name="QTCZR" FieldName="qcQTCZR" ClientVisible="false">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtQTCZR" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="有效期至" FieldName="qcYXQZ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="dateYXQZ" runat="server" Width="170px">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="生产日期" FieldName="qcSCRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="dateSCRQ" runat="server" Width="170px">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="停用日期" FieldName="qcTYRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="dateTYRQ" runat="server" Width="170px">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="植入日期" FieldName="qcZRRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="dateZRRQ" runat="server" Width="170px">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件发生初步原因分析" FieldName="eCBYYFX">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoYYFX" runat="server" Width="170px" Height="50px">
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件初步处理情况" FieldName="eCBCLQK">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoCLQK" runat="server" Width="170px" Height="50px">
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="事件初步处理情况 必填" />
                                        </ValidationSettings>
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件报告状态" FieldName="eBGZT">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxCheckBoxList ID="rblSJBGZT" runat="server" Width="250px" RepeatColumns="2"
                                        RepeatDirection="Horizontal">
                                        <Items>
                                            <dx:ListEditItem Text="已通知使用单位" Value="已通知使用单位" />
                                            <dx:ListEditItem Text="已通知生产企业" Value="已通知生产企业" />
                                            <dx:ListEditItem Text="已通知经营企业" Value="已通知经营企业" />
                                            <dx:ListEditItem Text="已通知药监部门" Value="已通知药监部门" />
                                        </Items>
                                    </dx:ASPxCheckBoxList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="不良事件情况" RowSpan="2" Width="400px">
                    <Items>
                        <dx:LayoutItem Caption="事件主要表现" FieldName="eZYBX">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoSJZYBX" runat="server" Width="220px" Height="50px">
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="事件主要表现 必填" />
                                        </ValidationSettings>
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件发生日期" FieldName="eFSRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="dateSJFSRQ" runat="server" Width="220px">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="发现或者知悉时间" FieldName="eFXHZXRQ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="dateFSZXRQ" runat="server" Width="220px">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="医疗器械实际使用场所" FieldName="eYLQXSYCS">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblYLQXSYCS" runat="server" Width="220px" ValueType="System.String"
                                        RepeatDirection="Horizontal">
                                        <ClientSideEvents SelectedIndexChanged="rblCS_SelectedIndexChanged" Init="OnrblCSInit" />
                                        <Items>
                                            <dx:ListEditItem Text="医疗机构" Value="医疗机构 " />
                                            <dx:ListEditItem Text="家庭" Value="家庭" />
                                            <dx:ListEditItem Text="其他" Value="其他" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="其他场所" Name="QTCS" FieldName="eQTCS" ClientVisible="false">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtQTCS" runat="server" Width="200px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件后果" FieldName="eSJHG">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblSJHG" runat="server" Width="250px" ValueType="System.String">
                                        <ClientSideEvents SelectedIndexChanged="rblSJHG_SelectedIndexChanged" Init="OnrblSJHGInit" />
                                        <Items>
                                            <dx:ListEditItem Text="死亡" Value="死亡 " />
                                            <dx:ListEditItem Text="危及生命" Value="危及生命" />
                                            <dx:ListEditItem Text="机体功能结构永久性损伤" Value="机体功能结构永久性损伤" />
                                            <dx:ListEditItem Text="可能导致机体功能结构永久性损伤" Value="可能导致机体功能结构永久性损伤" />
                                            <dx:ListEditItem Text="需要内、外科治疗避免上述永久损伤" Value="需要内、外科治疗避免上述永久损伤" />
                                            <dx:ListEditItem Text="其他（在事件陈述中说明）" Value="其他" />
                                        </Items>
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="事件后果 必选" />
                                        </ValidationSettings>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件后果-死亡时间" Name="DeadDate" FieldName="pDeadDate" HorizontalAlign="Right"
                            ClientVisible="false">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="dateDead" runat="server" Width="220px" ClientInstanceName="ciDateDead">
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="死亡时间 必填" />
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="事件陈述" FieldName="eSJCS">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="memoSJCS" runat="server" Width="220px" Height="233px">
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="事件陈述 必填" />
                                        </ValidationSettings>
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="关联性评价" RowSpan="2" Width="400px">
                    <Items>
                        <dx:LayoutItem Caption="1、使用医疗器械与已发生/可能发生的伤害事件之间是否具有合理的<br/>先后时间顺序？" FieldName="vGLXPJ1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblvGLXPJ1" runat="server" Width="372px" ValueType="System.String"
                                        RepeatDirection="Horizontal" RepeatLayout="UnorderedList">
                                        <Items>
                                            <dx:ListEditItem Text="是" Value="是" />
                                            <dx:ListEditItem Text="否" Value="否" />
                                        </Items>
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="关联评价 必选" />
                                        </ValidationSettings>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="2、已发生/可能发生的伤害事件是否属于所使用医疗器械可能导致的<br/>伤害类型？" FieldName="vGLXPJ2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblvGLXPJ2" runat="server" Width="372px" ValueType="System.String"
                                        RepeatDirection="Horizontal" RepeatLayout="UnorderedList">
                                        <Items>
                                            <dx:ListEditItem Text="是" Value="是" />
                                            <dx:ListEditItem Text="否" Value="否" />
                                            <dx:ListEditItem Text="无法确定" Value="无法确定" />
                                        </Items>
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="关联评价 必选" />
                                        </ValidationSettings>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="3、已发生/可能发生的伤害事件是否可用合并用药和/或械的作用、患<br/>者病情或其他非医疗器械因素来解释？" FieldName="vGLXPJ3">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblvGLXPJ3" runat="server" Width="372px" ValueType="System.String"
                                        RepeatDirection="Horizontal" RepeatLayout="UnorderedList">
                                        <Items>
                                            <dx:ListEditItem Text="是" Value="是" />
                                            <dx:ListEditItem Text="否" Value="否" />
                                            <dx:ListEditItem Text="无法确定" Value="无法确定" />
                                        </Items>
                                        <ValidationSettings>
                                            <RequiredField IsRequired="True" ErrorText="关联评价 必选" />
                                        </ValidationSettings>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="关联性评价结果" FieldName="vGLXPJJG" Visible="false">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblvGLXPJJG" runat="server" Width="372px" ValueType="System.String"
                                        RepeatDirection="Horizontal" RepeatLayout="UnorderedList">
                                        <Items>
                                            <dx:ListEditItem Text="很可能" Value="很可能" />
                                            <dx:ListEditItem Text="可能有关" Value="可能有关" />
                                            <dx:ListEditItem Text="可能无关" Value="可能无关" />
                                            <dx:ListEditItem Text="无法确定" Value="无法确定" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Left" VerticalAlign="Middle" Location="Top" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="报告人类别" Width="400px">
                    <Items>
                        <dx:LayoutItem Caption="报告人类别" FieldName="rBGRLB">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxRadioButtonList ID="rblBGRLB" runat="server" Width="250px" ValueType="System.String"
                                        RepeatDirection="Horizontal">
                                        <Items>
                                            <dx:ListEditItem Text="医师" Value="医师 " />
                                            <dx:ListEditItem Text="技师" Value="技师" />
                                            <dx:ListEditItem Text="护士" Value="护士" />
                                            <dx:ListEditItem Text="其他" Value="其他" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
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
                                    <dx:ASPxDateEdit ID="dateBGRQ" runat="server" Width="220px" Enabled="false">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings HorizontalAlign="Right" VerticalAlign="Middle" />
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
            </Items>
            <Styles>
                <LayoutGroupBox>
                    <Caption BackColor="Gainsboro" ForeColor="Black">
                    </Caption>
                </LayoutGroupBox>
            </Styles>
        </dx:ASPxFormLayout>
        <dx:ASPxButton ID="btnSave" runat="server" Text="保  存" Width="200px" Style="position: relative;
            left: 300px;" OnClick="btnSave_Click">
        </dx:ASPxButton>
    </div>
    <div style="float: right; position: fixed; bottom: 0; right: 0;">
        <dx:ASPxLabel runat="server" ID="resMessage" ForeColor="Red" Font-Size="Larger">
        </dx:ASPxLabel>
        <dx:ASPxValidationSummary ID="ASPxValidationSummary1" runat="server">
        </dx:ASPxValidationSummary>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnString %>"
        SelectCommand="SELECT *  FROM [AE_KYYLQX] WHERE ID=@ID" InsertCommand="INSERT INTO AE_KYYLQX(pName, pAge, pSex, pYQZY, eZYBX, eFSRQ, eFXHZXRQ, eYLQXSYCS, eQTCS, eSJHG, pDeadDate, eSJCS, qCPMC, qSPMC, qZCZH, qSCQYMC, qSCQYDZ, qQYLXDH, qcXHGG, qcCPBH, qcCPPH, qcCZR, qcQTCZR, qcYXQZ, qcSCRQ, qcTYRQ, qcZRRQ, eCBYYFX, eCBCLQK, eBGZT, vGLXPJ1, vGLXPJ2, vGLXPJ3, vGLXPJJG, rBGRLB, rBGRQM, rBGRQ,rBGKS) VALUES (@pName, @pAge, @pSex, @pYQZY, @eZYBX, @eFSRQ, @eFXHZXRQ, @eYLQXSYCS, @eQTCS, @eSJHG, @pDeadDate, @eSJCS, @qCPMC, @qSPMC, @qZCZH, @qSCQYMC, @qSCQYDZ, @qQYLXDH, @qcXHGG, @qcCPBH, @qcCPPH, @qcCZR, @qcQTCZR, @qcYXQZ, @qcSCRQ, @qcTYRQ, @qcZRRQ, @eCBYYFX, @eCBCLQK, @eBGZT, @vGLXPJ1, @vGLXPJ2, @vGLXPJ3, @vGLXPJJG, @rBGRLB, @rBGRQM, @rBGRQ,@rBGKS)"
        UpdateCommand="UPDATE [AE_KYYLQX]
   SET [pName] = @pName, 
	  [pAge] = @pAge, 
	  [pSex] = @pSex, 
	  [pYQZY] = @pYQZY, 
	  [eZYBX] = @eZYBX, 
	  [eFSRQ] = @eFSRQ, 
	  [eFXHZXRQ] = @eFXHZXRQ, 
	  [eYLQXSYCS] = @eYLQXSYCS, 
	  [eQTCS] = @eQTCS, 
	  [eSJHG] = @eSJHG, 
	  [pDeadDate] = @pDeadDate, 
	  [eSJCS] = @eSJCS, 
	  [qCPMC] = @qCPMC, 
	  [qSPMC] = @qSPMC, 
	  [qZCZH] = @qZCZH, 
	  [qSCQYMC] = @qSCQYMC, 
	  [qSCQYDZ] = @qSCQYDZ, 
	  [qQYLXDH] = @qQYLXDH, 
	  [qcXHGG] = @qcXHGG, 
	  [qcCPBH] = @qcCPBH, 
	  [qcCPPH] = @qcCPPH, 
	  [qcCZR] = @qcCZR, 
	  [qcQTCZR] = @qcQTCZR, 
	  [qcYXQZ] = @qcYXQZ, 
	  [qcSCRQ] = @qcSCRQ, 
	  [qcTYRQ] = @qcTYRQ, 
	  [qcZRRQ] = @qcZRRQ, 
	  [eCBYYFX] = @eCBYYFX, 
	  [eCBCLQK] = @eCBCLQK, 
	  [eBGZT] = @eBGZT, 
	  [vGLXPJ1] = @vGLXPJ1, 
	  [vGLXPJ2] = @vGLXPJ2, 
	  [vGLXPJ3] = @vGLXPJ3, 
	  [vGLXPJJG] = @vGLXPJJG, 
	  [rBGRLB] = @rBGRLB, 
	  [rBGRQM] = @rBGRQM, 
	  [rBGRQ] = @rBGRQ
 WHERE ID=@ID" OnInserting="SqlDataSource1_Inserting" OnSelecting="SqlDataSource1_Selecting"
        OnUpdating="SqlDataSource1_Updating">
        <InsertParameters>
            <asp:ControlParameter ControlID="ASPxFormLayout1$txtPName" Name="pName" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$txtAge" Name="pAge" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$rblSex" Name="pSex" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$memoYQZL" Name="pYQZY" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$memoSJZYBX" Name="eZYBX" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$dateSJFSRQ" Name="eFSRQ" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$dateFSZXRQ" Name="eFXHZXRQ" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$rblYLQXSYCS" Name="eYLQXSYCS" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$txtQTCS" Name="eQTCS" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$rblSJHG" Name="eSJHG" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$dateDead" Name="pDeadDate" PropertyName="Value" />
            <asp:ControlParameter Name="eSJCS" ControlID="ASPxFormLayout1$memoSJCS" PropertyName="Text" />
            <asp:ControlParameter Name="qCPMC" ControlID="ASPxFormLayout1$txtqCPMC" PropertyName="Text" />
            <asp:ControlParameter Name="qSPMC" ControlID="ASPxFormLayout1$txtqSPMC" PropertyName="Text" />
            <asp:ControlParameter Name="qZCZH" ControlID="ASPxFormLayout1$txtqZCZH" PropertyName="Text" />
            <asp:ControlParameter Name="qSCQYMC" ControlID="ASPxFormLayout1$txtqSCQYMC" PropertyName="Text" />
            <asp:ControlParameter Name="qSCQYDZ" ControlID="ASPxFormLayout1$txtqSCQYDZ" PropertyName="Text" />
            <asp:ControlParameter Name="qQYLXDH" ControlID="ASPxFormLayout1$txtqQYLXDH" PropertyName="Text" />
            <asp:ControlParameter Name="qcXHGG" ControlID="ASPxFormLayout1$txtqcXHGG" PropertyName="Text" />
            <asp:ControlParameter Name="qcCPBH" ControlID="ASPxFormLayout1$txtqcCPBH" PropertyName="Text" />
            <asp:ControlParameter Name="qcCPPH" ControlID="ASPxFormLayout1$txtqcCPPH" PropertyName="Text" />
            <asp:ControlParameter Name="qcCZR" ControlID="ASPxFormLayout1$rblCZR" PropertyName="Value" />
            <asp:ControlParameter Name="qcQTCZR" ControlID="ASPxFormLayout1$txtQTCZR" PropertyName="Text" />
            <asp:ControlParameter Name="qcYXQZ" ControlID="ASPxFormLayout1$dateYXQZ" PropertyName="Value" />
            <asp:ControlParameter Name="qcSCRQ" ControlID="ASPxFormLayout1$dateSCRQ" PropertyName="Value" />
            <asp:ControlParameter Name="qcTYRQ" ControlID="ASPxFormLayout1$dateTYRQ" PropertyName="Value" />
            <asp:ControlParameter Name="qcZRRQ" ControlID="ASPxFormLayout1$dateZRRQ" PropertyName="Value" />
            <asp:ControlParameter Name="eCBYYFX" ControlID="ASPxFormLayout1$memoYYFX" PropertyName="Text" />
            <asp:ControlParameter Name="eCBCLQK" ControlID="ASPxFormLayout1$memoCLQK" PropertyName="Text" />
            <asp:Parameter Name="eBGZT" />
            <asp:ControlParameter Name="vGLXPJ1" ControlID="ASPxFormLayout1$rblvGLXPJ1" PropertyName="Value" />
            <asp:ControlParameter Name="vGLXPJ2" ControlID="ASPxFormLayout1$rblvGLXPJ2" PropertyName="Value" />
            <asp:ControlParameter Name="vGLXPJ3" ControlID="ASPxFormLayout1$rblvGLXPJ3" PropertyName="Value" />
            <%--<asp:ControlParameter Name="vGLXPJJG" ControlID="ASPxFormLayout1$rblvGLXPJJG" PropertyName="Value" />--%>
            <asp:Parameter Name="vGLXPJJG" />
            <asp:ControlParameter Name="rBGRLB" ControlID="ASPxFormLayout1$rblBGRLB" PropertyName="Value" />
            <asp:ControlParameter Name="rBGRQM" ControlID="ASPxFormLayout1$txtBGRQM" PropertyName="Text" />
            <asp:ControlParameter Name="rBGRQ" ControlID="ASPxFormLayout1$dateBGRQ" PropertyName="Value" />
            <asp:Parameter Name="rBGKS" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="ID" Type="Int32" DefaultValue="4" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$txtPName" Name="pName" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$txtAge" Name="pAge" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$rblSex" Name="pSex" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$memoYQZL" Name="pYQZY" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$memoSJZYBX" Name="eZYBX" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$dateSJFSRQ" Name="eFSRQ" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$dateFSZXRQ" Name="eFXHZXRQ" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$rblYLQXSYCS" Name="eYLQXSYCS" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$txtQTCS" Name="eQTCS" PropertyName="Text" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$rblSJHG" Name="eSJHG" PropertyName="Value" />
            <asp:ControlParameter ControlID="ASPxFormLayout1$dateDead" Name="pDeadDate" PropertyName="Value" />
            <asp:ControlParameter Name="eSJCS" ControlID="ASPxFormLayout1$memoSJCS" PropertyName="Text" />
            <asp:ControlParameter Name="qCPMC" ControlID="ASPxFormLayout1$txtqCPMC" PropertyName="Text" />
            <asp:ControlParameter Name="qSPMC" ControlID="ASPxFormLayout1$txtqSPMC" PropertyName="Text" />
            <asp:ControlParameter Name="qZCZH" ControlID="ASPxFormLayout1$txtqZCZH" PropertyName="Text" />
            <asp:ControlParameter Name="qSCQYMC" ControlID="ASPxFormLayout1$txtqSCQYMC" PropertyName="Text" />
            <asp:ControlParameter Name="qSCQYDZ" ControlID="ASPxFormLayout1$txtqSCQYDZ" PropertyName="Text" />
            <asp:ControlParameter Name="qQYLXDH" ControlID="ASPxFormLayout1$txtqQYLXDH" PropertyName="Text" />
            <asp:ControlParameter Name="qcXHGG" ControlID="ASPxFormLayout1$txtqcXHGG" PropertyName="Text" />
            <asp:ControlParameter Name="qcCPBH" ControlID="ASPxFormLayout1$txtqcCPBH" PropertyName="Text" />
            <asp:ControlParameter Name="qcCPPH" ControlID="ASPxFormLayout1$txtqcCPPH" PropertyName="Text" />
            <asp:ControlParameter Name="qcCZR" ControlID="ASPxFormLayout1$rblCZR" PropertyName="Value" />
            <asp:ControlParameter Name="qcQTCZR" ControlID="ASPxFormLayout1$txtQTCZR" PropertyName="Text" />
            <asp:ControlParameter Name="qcYXQZ" ControlID="ASPxFormLayout1$dateYXQZ" PropertyName="Value" />
            <asp:ControlParameter Name="qcSCRQ" ControlID="ASPxFormLayout1$dateSCRQ" PropertyName="Value" />
            <asp:ControlParameter Name="qcTYRQ" ControlID="ASPxFormLayout1$dateTYRQ" PropertyName="Value" />
            <asp:ControlParameter Name="qcZRRQ" ControlID="ASPxFormLayout1$dateZRRQ" PropertyName="Value" />
            <asp:ControlParameter Name="eCBYYFX" ControlID="ASPxFormLayout1$memoYYFX" PropertyName="Text" />
            <asp:ControlParameter Name="eCBCLQK" ControlID="ASPxFormLayout1$memoCLQK" PropertyName="Text" />
            <asp:Parameter Name="eBGZT" />
            <asp:ControlParameter Name="vGLXPJ1" ControlID="ASPxFormLayout1$rblvGLXPJ1" PropertyName="Value" />
            <asp:ControlParameter Name="vGLXPJ2" ControlID="ASPxFormLayout1$rblvGLXPJ2" PropertyName="Value" />
            <asp:ControlParameter Name="vGLXPJ3" ControlID="ASPxFormLayout1$rblvGLXPJ3" PropertyName="Value" />
            <%--<asp:ControlParameter Name="vGLXPJJG" ControlID="ASPxFormLayout1$rblvGLXPJJG" PropertyName="Value" />--%>
            <asp:Parameter Name="vGLXPJJG" />
            <asp:ControlParameter Name="rBGRLB" ControlID="ASPxFormLayout1$rblBGRLB" PropertyName="Value" />
            <asp:ControlParameter Name="rBGRQM" ControlID="ASPxFormLayout1$txtBGRQM" PropertyName="Text" />
            <asp:ControlParameter Name="rBGRQ" ControlID="ASPxFormLayout1$dateBGRQ" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
