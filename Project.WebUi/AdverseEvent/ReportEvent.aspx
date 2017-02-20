<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportEvent.aspx.cs" Inherits="Project.WebUi.AdverseEvent.ReportEvent" %>

<%@ Register Assembly="DevExpress.XtraReports.v15.2.Web, Version=15.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxDocumentViewer ID="ASPxDocumentViewer1" runat="server">
            <SettingsReportViewer PrintUsingAdobePlugIn="False" />
        </dx:ASPxDocumentViewer>
    </div>
    </form>
</body>
</html>
