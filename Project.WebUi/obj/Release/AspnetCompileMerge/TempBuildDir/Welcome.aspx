﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="Project.WebUi.Welcome" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
  <link id="cssfile" href="../css/style-blue.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var h = $(window).height();
            $('body').height(h);
            $('.mianBox').height(h);
            centerWindow(".tipInfo");
        });

        //2.将盒子方法放入这个方，方便法统一调用
        function centerWindow(a) {
            center(a);
            //自适应窗口
            $(window).bind('scroll resize',
                    function () {
                        center(a);
                    });
        }

        //1.居中方法，传入需要剧中的标签
        function center(a) {
            var wWidth = $(window).width();
            var wHeight = $(window).height();
            var boxWidth = $(a).width();
            var boxHeight = $(a).height();
            var scrollTop = $(window).scrollTop();
            var scrollLeft = $(window).scrollLeft();
            var top = scrollTop + (wHeight - boxHeight) / 2;
            var left = scrollLeft + (wWidth - boxWidth) / 2;
            $(a).css({
                "top": top,
                "left": left
            });
        }
    </script>
</head>
<body>
    <div class="welcome_bg" style="background-color:white;">
    <div class="welcome">
    <div class="mianBox">
            <img src="images/yun0.png" alt="" class="yun yun0" />
            <img src="images/yun1.png" alt="" class="yun yun1" />
            <img src="images/yun2.png" alt="" class="yun yun2" />
            <img src="images/bird.png" alt="" class="bird" />
            <img src="images/san.png" alt="" class="san" />
            <div class="tipInfo">
                <div class="in">
                    <div class="textThis">
                        <h2>您好：<asp:Label ID="LoginUserName" runat="server" Text=""></asp:Label>，欢迎进入</h2>
                        <p><span>综合业务上报系统</span></p>
                    </div>
                </div>
            </div>
        </div>
        </div>
        </div>
</body>
</html>
