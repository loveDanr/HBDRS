<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HLBQWH.aspx.cs" Inherits="Project.WebUi.HLBQ.HLBQWH" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>护理病区维护</title>
    <script type="text/javascript">
        var itemKeys;
        function gridFocusedRowChanged(s, e) {
            //var key = s.GetRowKey(s.GetFocusedRowIndex());
            lbY.ClearItems();
            lbW.ClearItems();
            lbY.PerformCallback();
            lbW.PerformCallback();
            e.processOnServer = false;
        }

        function AddSelectedItems() {
            lbY.PerformCallback(lbW.GetSelectedValues());
            MoveSelectedItems(lbW, lbY);
            UpdateButtonState();
        }
        function RemoveSelectedItems() {
            lbW.PerformCallback(lbY.GetSelectedValues());
            MoveSelectedItems(lbY, lbW);
            UpdateButtonState();
        }

        function MoveSelectedItems(srcListBox, dstListBox) {
            srcListBox.BeginUpdate();
            dstListBox.BeginUpdate();
            var items = srcListBox.GetSelectedItems();
            for (var i = items.length - 1; i >= 0; i = i - 1) {
                dstListBox.AddItem(items[i].text, items[i].value);
                srcListBox.RemoveItem(items[i].index);
            }
            srcListBox.EndUpdate();
            dstListBox.EndUpdate();
        }
        function UpdateButtonState() {
            btnAdd.SetEnabled(lbW.GetItemCount() > 0);
            btnRemove.SetEnabled(lbY.GetItemCount() > 0);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p style="text-align: center; font-size: 20px; font-weight: bold;">护理病区维护</p>
            <table align="center" style="width: 500px;">
                <tr>
                    <td colspan="3">
                        <dx:ASPxGridView runat="server" ID="ASPxGridView1" AutoGenerateColumns="False" KeyFieldName="AreaID" Width="100%" OnRowInserting="ASPxGridView1_RowInserting" OnRowDeleting="ASPxGridView1_RowDeleting" OnRowUpdating="ASPxGridView1_RowUpdating" OnDataBinding="ASPxGridView1_DataBinding">
                            <ClientSideEvents FocusedRowChanged="gridFocusedRowChanged" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True"
                                    VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="AreaID" ReadOnly="True" VisibleIndex="1" Visible="false">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="片区名称" FieldName="AreaName" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="负责人" FieldName="AreaManager" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsBehavior AllowDragDrop="False" AllowGroup="False" AllowSort="False" AllowSelectByRowClick="True"
                                AllowFocusedRow="True" ConfirmDelete="True" AllowSelectSingleRowOnly="True" />
                            <SettingsText CommandCancel="取消" CommandDelete="删除" CommandEdit="编辑"
                                CommandNew="新增" CommandUpdate="更新" ConfirmDelete="确定删除，归属科室也将被移除？" />
                        </dx:ASPxGridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="已归属片区科室：">
                        </dx:ASPxLabel>
                    </td>
                    <td></td>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="未归属片区科室：">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxListBox ID="ASPxListBox1" runat="server" Height="500px" ValueType="System.String"
                            SelectionMode="CheckColumn" TextField="DeptName" ValueField="DeptID" ClientInstanceName="lbY"
                            OnDataBinding="ASPxListBox1_DataBinding" OnCallback="ASPxListBox1_Callback">
                            <Columns>
                                <dx:ListBoxColumn Caption="科室名称" FieldName="DeptName" Width="200px" />
                            </Columns>
                        </dx:ASPxListBox>
                    </td>
                    <td>
                        <dx:ASPxButton ID="ASPxButtonAdd" runat="server" Text="&lt;&lt;添加" ClientInstanceName="btnAdd" Height="21px" AutoPostBack="false">
                            <ClientSideEvents Click="AddSelectedItems" />
                        </dx:ASPxButton>
                        <p>
                        </p>
                        <dx:ASPxButton ID="ASPxButtonRemove" runat="server" Text="移除&gt;&gt;" ClientInstanceName="btnRemove"
                            Height="21px" AutoPostBack="false">
                            <ClientSideEvents Click="RemoveSelectedItems" />
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxListBox ID="ASPxListBox2" runat="server" Height="500px" ValueType="System.String"
                            SelectionMode="CheckColumn" TextField="DeptName" ValueField="DeptID" OnDataBinding="ASPxListBox2_DataBinding" ClientInstanceName="lbW" OnCallback="ASPxListBox2_Callback">
                            <Columns>
                                <dx:ListBoxColumn Caption="科室名称" FieldName="DeptName" Width="200px" />
                            </Columns>
                        </dx:ASPxListBox>
                    </td>
                </tr>
            </table>
            <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AnyOfficeConnectionString %>"
            SelectCommand="SELECT * FROM [HLX_Area]" UpdateCommand="UPDATE HLX_Area SET AreaName =@AreaName,AreaManager = @AreaManager WHERE AreaID=@AreaID"
            DeleteCommand="DELETE FROM HLX_Area WHERE (AreaID = @AreaID)" InsertCommand="INSERT INTO HLX_Area(AreaName, AreaManager) VALUES (@AreaName, @AreaManager)">
            <UpdateParameters>
                <asp:Parameter Name="AreaName" />
                <asp:Parameter Name="AreaManager" />
                <asp:Parameter Name="AreaID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AnyOfficeConnectionString %>"
            SelectCommand="SELECT DeptId ,deptname FROM [Department] WHERE FaxNo in( '临床','医技') EXCEPT SELECT DeptId,deptname FROM anyoffice..hlx_areadepts "
            InsertCommand="INSERT INTO HLX_AreaDepts ([AreaID],[DeptID],[DeptName]) VALUES (@AreaID, @DeptID, @DeptName)">
            <InsertParameters>
                <asp:Parameter Name="AreaID" />
                <asp:Parameter Name="DeptID" />
                <asp:Parameter Name="DeptName" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:AnyOfficeConnectionString %>"
            SelectCommand="SELECT DeptId,deptname FROM anyoffice..hlx_areadepts where AreaID=@AreaID "
            DeleteCommand="DELETE FROM  HLX_AreaDepts WHERE AreaID=@AreaID AND DeptID=@DeptID">
            <SelectParameters>
                <asp:Parameter Name="AreaID" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="AreaID" />
                <asp:Parameter Name="DeptID" />
            </DeleteParameters>
        </asp:SqlDataSource>--%>
        </div>
    </form>
</body>
</html>
