<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Project.WebUi.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新乡市中心医院综合业务上报系统·系统登录</title>
    <link id="cssfile" rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/dd.ico" media="screen" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/jquery.cookie.js" type="text/javascript"></script>
    <script type="text/javascript">
        if (top.location.href !== location.href) top.location.href = location.href;
        $(function () {
            var cookie_skin = $.cookie("MyCssSkin");//优化了代码，将功能模块化了
            if (cookie_skin) {
                switchSkin(cookie_skin);
            }
        });
        function switchSkin(skinName) {
            $("#cssfile").attr("href", "../css/" + skinName + ".css"); //设置不同皮肤
        }
    </script>
</head>
    <body>
        <div class="cloud">
        <form action="" runat="server" class="login" method="post">
            <div style="top:28%;left:35%;position:absolute;">
                <div style="width:400px;height:100px;margin:auto;background-image:url(images/Loginlogo.png)"></div>
                <div style="width:400px;margin:auto;">
                    <div style="width:100px;line-height:50px;text-align:center;color:white;float:left;font-size:22px;font-weight:bolder">
                        用户名
                    </div>
                    <div style="background-image:url(images/login_name_bg.jpg);padding:7px 8px 7px 8px;float:left">
                        <asp:TextBox ID="txtAdminName" runat="server" Width="251px" Height="32px" Font-Size="Large" />
                    </div>
                </div>
                <div style="width:400px;margin:auto;">
                    <div style="width:100px;line-height:50px;text-align:center;color:white;float:left;font-size:22px;font-weight:bolder" >
                        密&nbsp;&nbsp;&nbsp;码
                    </div>
                    <div style="background-image:url(images/login_name_bg.jpg);padding:7px 8px 7px 8px;float:left">
                        <asp:TextBox ID="txtAdminPwd" runat="server" TextMode="Password" Width="251px" Height="32px" Font-Size="Large"  />
                    </div>
                </div>
                <div style="width:400px;margin:auto;">
                   <div style="width:100px;line-height:50px;text-align:center;color:white;float:left;font-size:22px;font-weight:bolder" >
                        验证码
                    </div>
                    <div style="background-image:url(images/login_name_bg.jpg);width:257px;padding:6px 6px 6px 8px;float:left">
                        <asp:TextBox ID="txtVcode" runat="server" Width="170px" Height="32px" Font-Size="Medium" />
                            <a id="txtChange"  href="javascript:document.getElementById('imgcode').src='Vcode.aspx?'+new Date();void(0);">
                            <asp:Image ID="imgcode" runat="server" ImageUrl="~/Vcode.aspx" ImageAlign="AbsMiddle" CssClass="img_code" /></a>
                    </div>
                </div>
                <div style="width:150px;margin:auto;">
                    <asp:Button ID="btnLogin" runat="server" Text="登陆" OnClick="btnLogin_Click" CssClass="login_btn" />
                </div>
            </div>
        </form>
            </div>
</body>
</html>

<%--<body class="login_body">
    <div class="login_div">
        <div class="col-xs-12 login_title">登录</div>
        <form action="" runat="server" class="login" method="post">
            <div class="nav">
                <div class="nav login_nav">
                    <div class="col-xs-4 login_username">
                        用户名:
                    </div>
                    <div class="col-xs-6 login_usernameInput">
                        <asp:TextBox ID="txtAdminName" runat="server" CssClass="name" Font-Size="Medium" />
                    </div>
                    <div class="col-xs-1 ok_gou">
                        √
                    </div>
                    <div class="col-xs-1 error_cuo">
                        ×
                    </div>
                </div>
                <div class="nav login_psdNav">
                    <div class="col-xs-4">
                        密&nbsp;&nbsp;&nbsp;码:
                    </div>
                    <div class="col-xs-6">
                        <asp:TextBox ID="txtAdminPwd" runat="server" TextMode="Password" CssClass="psd" Font-Size="Medium" />
                    </div>
                    <div class="col-xs-1 ok_gou">
                        √
                    </div>
                    <div class="col-xs-1 error_cuo">
                        ×
                    </div>
                </div>
                <div class="nav login_scdNav">
                    <div class="col-xs-4">
                        验证码:
                    </div>
                    <div class="col-xs-6">
                        <asp:TextBox ID="txtVcode" runat="server" CssClass="scd" Font-Size="Medium" />
                    </div>
                    <div>
                        <a id="txtChange" href="javascript:document.getElementById('imgcode').src='Vcode.aspx?'+new Date();void(0);">
                            <asp:Image ID="imgcode" runat="server" ImageUrl="~/Vcode.aspx" ImageAlign="AbsMiddle" CssClass="img_code" /></a>
                    </div>

                </div>


                <div class="col-xs-12 login_btn_div">

                    <asp:Button ID="btnLogin" runat="server" Text="登陆" OnClick="btnLogin_Click" CssClass="login_btn" />
                </div>
            </div>
        </form>
    </div>
</body>--%>