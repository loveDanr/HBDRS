<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridReport.aspx.cs" Inherits="Project.WebUi.MYDHS.GridReport" %>
<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxGridView ID="ASPxGridViewReport" runat="server" Width="100%" AutoGenerateColumns="False">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="科室" VisibleIndex="0" FixedStyle="Left">
                    <Settings AllowSort="True" AllowHeaderFilter="True"></Settings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewBandColumn Caption="工作稳定度">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f1my" ReadOnly="True" VisibleIndex="1" ToolTip=""
                            Width="25" Caption="满意项数">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f1jbmy" ReadOnly="True" VisibleIndex="2" ToolTip=""
                            Width="25" Caption="基本满意项数">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f1bmy" ReadOnly="True" VisibleIndex="3" ToolTip=""
                            Width="25" Caption="不满意项数">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f1null" ReadOnly="True" VisibleIndex="4" ToolTip=""
                            Width="25" Caption="空项票数">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="医院有标准化的管理流程和护理工作流程">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f2my" ReadOnly="True" VisibleIndex="5" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f2jbmy" ReadOnly="True" VisibleIndex="6" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f2bmy" ReadOnly="True" VisibleIndex="7" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f2null" ReadOnly="True" VisibleIndex="8" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="职业保护设施与设备配备完善">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f3my" ReadOnly="True" VisibleIndex="9" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f3jbmy" ReadOnly="True" VisibleIndex="10" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f3bmy" ReadOnly="True" VisibleIndex="11" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f3null" ReadOnly="True" VisibleIndex="12" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="人身安全保障制度与护理制度保障体系操作">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f4my" ReadOnly="True" VisibleIndex="13" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f4jbmy" ReadOnly="True" VisibleIndex="14" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f4bmy" ReadOnly="True" VisibleIndex="15" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f4null" ReadOnly="True" VisibleIndex="16" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="病房配套设施使病人方便舒适且利于护理操作">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f5my" ReadOnly="True" VisibleIndex="17" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f5jbmy" ReadOnly="True" VisibleIndex="18" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f5bmy" ReadOnly="True" VisibleIndex="19" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f5null" ReadOnly="True" VisibleIndex="25" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="报酬与工作付出成正比">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f6my" ReadOnly="True" VisibleIndex="21" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f6jbmy" ReadOnly="True" VisibleIndex="25" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f6bmy" ReadOnly="True" VisibleIndex="23" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f6null" ReadOnly="True" VisibleIndex="24" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="夜班及节假日的值班、加班补贴满足您的期望">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f7my" ReadOnly="True" VisibleIndex="25" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f7jbmy" ReadOnly="True" VisibleIndex="26" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f7bmy" ReadOnly="True" VisibleIndex="27" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f7null" ReadOnly="True" VisibleIndex="28" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="工作中能得到晋升、评优的机会">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f8my" ReadOnly="True" VisibleIndex="29" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f8jbmy" ReadOnly="True" VisibleIndex="30" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f8bmy" ReadOnly="True" VisibleIndex="31" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f8null" ReadOnly="True" VisibleIndex="32" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="工作中有进修、交流、学习的机会">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f9my" ReadOnly="True" VisibleIndex="33" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f9jbmy" ReadOnly="True" VisibleIndex="34" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f9bmy" ReadOnly="True" VisibleIndex="35" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f9null" ReadOnly="True" VisibleIndex="36" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="您对目前科室的排班模式">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f10my" ReadOnly="True" VisibleIndex="37" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f10jbmy" ReadOnly="True" VisibleIndex="38"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f10bmy" ReadOnly="True" VisibleIndex="39" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f10null" ReadOnly="True" VisibleIndex="40"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="科室实行弹性排班，您有足够的时间安排私人事务">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f11my" ReadOnly="True" VisibleIndex="41" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f11jbmy" ReadOnly="True" VisibleIndex="42"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f11bmy" ReadOnly="True" VisibleIndex="43" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f11null" ReadOnly="True" VisibleIndex="44"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="您对科室护理人员配置与护理患者数量的比例">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f12my" ReadOnly="True" VisibleIndex="45" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f12jbmy" ReadOnly="True" VisibleIndex="46"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f12bmy" ReadOnly="True" VisibleIndex="47" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f12null" ReadOnly="True" VisibleIndex="48"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="后勤保障系统能使您有更多的时间服务于病人">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f13my" ReadOnly="True" VisibleIndex="49" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f13jbmy" ReadOnly="True" VisibleIndex="50"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f13bmy" ReadOnly="True" VisibleIndex="51" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f13null" ReadOnly="True" VisibleIndex="52"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="护理管理者能倾听和反馈您在工作中关心的问题">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f14my" ReadOnly="True" VisibleIndex="53" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f14jbmy" ReadOnly="True" VisibleIndex="54"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f14bmy" ReadOnly="True" VisibleIndex="55" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f14null" ReadOnly="True" VisibleIndex="56"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="在工作中被误解时，能得到管理者的帮助并协作处理问题">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f15my" ReadOnly="True" VisibleIndex="57" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f15jbmy" ReadOnly="True" VisibleIndex="58"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f15bmy" ReadOnly="True" VisibleIndex="59" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f15null" ReadOnly="True" VisibleIndex="60"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="您与同事相处和谐">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f16my" ReadOnly="True" VisibleIndex="61" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f16jbmy" ReadOnly="True" VisibleIndex="62"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f16bmy" ReadOnly="True" VisibleIndex="63" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f16null" ReadOnly="True" VisibleIndex="64"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="您的工作得到医疗、医技、后勤人员的理解及尊重">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f17my" ReadOnly="True" VisibleIndex="65" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f17jbmy" ReadOnly="True" VisibleIndex="66"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f17bmy" ReadOnly="True" VisibleIndex="67" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f17null" ReadOnly="True" VisibleIndex="68"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="您认为在现在的管理体制下能体现出自己的价值">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f18my" ReadOnly="True" VisibleIndex="69" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f18jbmy" ReadOnly="True" VisibleIndex="70"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f18bmy" ReadOnly="True" VisibleIndex="71" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f18null" ReadOnly="True" VisibleIndex="72"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="您对科室间配合、同事合作的程度评价">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f19my" ReadOnly="True" VisibleIndex="73" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f19jbmy" ReadOnly="True" VisibleIndex="74"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f19bmy" ReadOnly="True" VisibleIndex="75" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f19null" ReadOnly="True" VisibleIndex="76"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="您对医院及时为临床护理工作解决实际困难">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="f20my" ReadOnly="True" VisibleIndex="77" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f20jbmy" ReadOnly="True" VisibleIndex="78"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f20bmy" ReadOnly="True" VisibleIndex="79" ToolTip=""
                            Width="25">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="f20null" ReadOnly="True" VisibleIndex="80"
                            ToolTip="" Width="25">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewBandColumn>
            </Columns>
            <SettingsBehavior AllowDragDrop="False" AllowGroup="False" AllowSort="False" ColumnResizeMode="Control" />
            <Settings ShowHorizontalScrollBar="True" ShowFilterRow="False" />
            <Styles>
            <AlternatingRow Enabled="True"></AlternatingRow>
            <Cell HorizontalAlign="Center" VerticalAlign="Middle"></Cell>
            </Styles>
        </dx:ASPxGridView>
    </div>
    </form>
</body>
</html>
