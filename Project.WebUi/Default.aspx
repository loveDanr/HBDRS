<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Project.WebUi._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>首页</title>
   <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/jquery.cookie.js" type="text/javascript"></script>
    <script src="../js/lhgdialog.min.js?skin=discuz" type="text/javascript"></script>
    <link id="cssfile" href="../css/style.css" rel="stylesheet" type="text/css" />
   <link rel="shortcut icon" type="image/x-icon" href="images/dd.ico" media="screen" />
    <script type="text/javascript">
    //    jQuery(document).ready(function () {
    //    //关闭打开左栏目
    //        $("#sysBar").toggle(function () {
    //            $("#mainLeft").hide();
    //            $("#barImg").attr("src", "images/butOpen.gif");
	//    },function(){
	//        $("#mainLeft").show();
	//        $("#barImg").attr("src", "images/butClose.gif");
	//    });
    //});
        $(function () {
            var $div = $("#persInfo li div");
            $div.click(function () {
                switchSkin(this.id);
            });
            var cookie_skin = $.cookie("MyCssSkin");//优化了代码，将功能模块化了
            if (cookie_skin) {
                switchSkin(cookie_skin);
            }
        });
        function switchSkin(skinName) {
            $("#cssfile").attr("href", "../css/" + skinName + ".css"); //设置不同皮肤
            $.cookie("MyCssSkin", skinName, { path: '/', expires: 10 });
        }

    function PwdFix(url) {
        $.dialog({ lock: true, skin: "discuz", title: '密码修改', content: 'url:' + url, max: false, mix: false, });
    }
    function sh(id,s) {
        $(s).addClass("current").next("ul").slideToggle(300).siblings("ul").slideUp("slow");
        $(s).siblings().removeClass("current");
    }
    function sha(s) {
        
        $(".left_menu li a").removeClass("acurrent");;//.css("color", "#09c").
        $(s).addClass("acurrent");//.css("color","white");
        //$(s).parent().siblings().children().css("color","#09c").removeClass("acurrent");
        //点击后loading效果
        var topBody = window.document.body;
        var rightBody = window.frames["sysMain"].document.body;
        var loadingDiv = $("#loading", rightBody);
        if (loadingDiv.length == 0) {
            loadingDiv = $("<div id='loading'><img id='loadingImg' src='../images/loading.gif'><br/><img id='loadingImg' src='../images/trying.png'></div>");
            loadingDiv.css("position", "absolute");
            loadingDiv.css("z-index", "999");
            loadingDiv.css("font-size", "15px");
            loadingDiv.css("text-align", "center");
            loadingBankDiv = $("<div id='bankDiv'></div>");
            loadingBankDiv.width($(topBody).width()-200);
            //alert($(topBody).width()-190);
            loadingBankDiv.height($(topBody).height());
            //alert($(topBody).height() - 55);
            loadingBankDiv.css("position", "absolute");
            loadingBankDiv.css("z-index", "998");
            loadingBankDiv.css("background-color", "#eff8fe");
            loadingBankDiv.css("filter", "alpha(opacity=90)");
            loadingBankDiv.append(loadingDiv);
            $(rightBody).append(loadingBankDiv);
            loadingBankDiv.css("left", 0);
            loadingBankDiv.css("top", 0);
            loadingDiv.css("left", ($(topBody).width()-180 - loadingDiv.width()) / 2);
            loadingDiv.css("top", ($(topBody).height()-280 ) / 2);
        }
    }
    function hidePs() {
        $('#persInfo').hide();
    };
    function shPs() {
        $('#persInfo').show();
    };
    
    
    window.onunload = function () {
        //alert($.cookie(".myformName"));
        $.cookie(".myformName", null);
    }

    

    </script>
</head>

<body>
    <form id="form1" runat="server" style="height:100%">

 <table  style="width:100%;height:100%;vertical-align:top;"   >
  <tr style="height:50px">
    <td  colspan="3" class="topLogo">
       <div style="width:80px;position:absolute;right:0;top:0px;border-left:1px solid gray;line-height:50px;text-align:center;">
           <ul onmouseout="hidePs();" onmouseover="shPs();">
               <li>&nbsp;<asp:Label ID="lblAdminName" runat="server" ForeColor="White" Text=""/>&nbsp;<img alt="个人中心" src="images/arrow_drop_down.png" /></li>
               <li>
                   <ul id="persInfo"  style="display:none; text-align:center;line-height:20px; background-color:white;border:1px solid #ccc;position:absolute;top:50px;left:-1px; width:80px;">
                       <li style="padding:3px;" >
                           <a href='#' onclick='PwdFix("SystemManage/PwdChange.aspx")'> 修改密码</a>
                       </li>
                       <li style="padding:3px;" ><a href='<%=ResolveUrl("UserExit.aspx")%>' target="_self">安全退出</a></li>
                       <li><div id="style" style="background-color:#444359;border:1px solid  #b63b4d"></div><div id="style-blue" style="background-color:#049EC4;border:1px solid gray"></div><div id="style-qq" style="background-color:white;border:1px solid "></div></li>
                   </ul>
               </li>
           </ul>
       </div>
    </td>
  </tr>
  
<%--  <tr style="height:30px; background-color:#b63b4d;vertical-align:top;display:none;">
    <td  colspan="3" style="padding:0px 10px;font-size:13px;vertical-align:middle">
    <div class="topStatus" > </div>
    <div class="topStatus" > </div>
    <div class="topStatus" ><font color="White">
    </font></div>
    </td>
  </tr>--%>


  <tr>
    <td  id="mainLeft"  style="background:#FFF; width:185px;height:100%; vertical-align:top; ">
	  <div style="text-align:left;width:185px;font-size:12px;height:100%; overflow-y: scroll;">

        <div class="navgn">
          <span></span>
        </div>
   
         <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        <%--<div class="left_menu">
          <div class="ti" onclick="sh(1)">用户管理</div>
          <ul id="1" style="display:block">
            <li><a href="UserManage/AdminList.aspx" target="sysMain">用户列表</a></li>
            <li><a href="UserManage/RoleList.aspx" target="sysMain">角色管理</a></li>
            <li><a href="UserManage/MenuList.aspx" target="sysMain">菜单管理</a></li>
            <li><a href="UserManage/UpdatePassword.aspx" target="sysMain">修改密码</a></li>
          </ul>
        </div> --%>    
           
      </div>
	</td>
	<%--<td style="width:8px;background:url(main_cen_bg.gif) repeat-x;  vertical-align:middle">
      <div id="sysBar" style="cursor:pointer;"><img id="barImg" src="images/butClose.gif" alt="关闭/打开左栏" /></div>
	</td>--%>
	<td  style="width:100%; height:100%;" valign="top">
      <iframe frameborder="0" id="sysMain" name="sysMain" scrolling="auto" src="welqq.aspx" style="height:100%; width:100%;"></iframe>
	</td>
  </tr>
  
  <tr style="height:10px;">
    <td  colspan="3"style="padding:0px 10px;font-size:10px;color:#2C89AD;"></td>
  </tr>
  
</table>
</form>
</body>
</html>