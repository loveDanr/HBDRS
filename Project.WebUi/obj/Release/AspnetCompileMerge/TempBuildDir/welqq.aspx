<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="welqq.aspx.cs" Inherits="Project.WebUi.welqq" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> --%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题页</title>
    <link href="../css/welcome-qq.css" rel="stylesheet" />
    <script src="js/jquery.js" type="text/javascript"></script>
</head>
<body>
    <div class="md-modal" id="modal-1" >
        <div class="md-content">
            <h3>工资条查询</h3>
            <div>
                <p>
                    工资条查询菜单提供个人工资查询和科室工资查询两种功能。
                </p>
                <ul>
                    <li><strong>个人工资查询:</strong> 员工可以通过个人工资查询查询本人近几个月的所有工资清单。</li>
                    <li><strong>科室工资查询:</strong> 科室领导可以通过科室工资查询近几个月本科室所有员工的工资清单。</li>
                </ul>
                <button class="md-close">关闭!</button>
            </div>
        </div>
    </div>

    <div class="md-modal" id="modal-2">
        <div class="md-content">
            <h3>护理质量数据上报</h3>
            <div>
                <p>
                    护理质量数据上报提供护理质量数据科室上报、护理质量数据查询、和护理质量数据科室查询等功能。
                </p>
                <ul>
                    <li><strong>科室护理质量上报：</strong> 每季度上报本科室白、夜班责护人数，收治患者数及住院患者病情和身体状况的相关数据。</li>
                    <li><strong>护理质量数据查询：</strong>可查询本科室或全院任意科室所上报的信息，可查看各项信息的合计数据。</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>

    <div class="md-modal" id="modal-3">
        <div class="md-content">
            <h3>环境监测数据上报</h3>
            <div>
                <p>
                    环境监测上报系统提供区域空气环境监测，物体表面、液体、诊疗器械等相关数据的上报和查询功能。
                </p>
                <ul>
                    <li><strong>空气环境监测：</strong> 包括静配中心专用、洁净手术室和其他洁净场所的空气检测信息的上报和查询。</li>
                    <li><strong>物体表面检测：</strong> 包括医务人员手、物体表面、内镜消毒灭菌、透析用水和透析液、医用物品等环境卫生信息上报和查询。</li>
                    <li><strong>监测计划维护和查询：</strong> 制定上报计划和内容，提供调查追踪表，供监测科室如细菌培养有不合格者打印上交。</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>

    <div class="md-modal" id="modal-4">
        <div class="md-content">
            <h3>医护人员满意度调查表</h3>
            <div>
                <p>
                    为了促进医护良好协作，提高医护工作的质量和水平，了解医生和护士对护理工作的意见建议，特制定此调查问卷。
                </p>
                <ul>
                    <li><strong>医师对护理工作满意度调查：</strong> 主要包括在医护协同工作时，科室护理工作的安排和护士的各项工作能力满意度调查。</li>
                    <li><strong>护士对护理工作满意度</strong> 
主要包括护士对科室护理工作内容、科室关于护理工作的分配及工作时与领导和同事沟通、协同工作时易产生的相关问题满意度调查。</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>

    <div class="md-modal" id="modal-5">
        <div class="md-content">
            <h3>可疑医疗器械上报</h3>
            <div>
                <p>
                   提供可疑医疗器械信息的上报和查询功能。
                </p>
                <ul>
                    <li><strong>信息录入：</strong>录入的信息包括患者资料、不良事件和医疗器械的相关情况。</li>
                    <li><strong>信息查询：</strong>提供按日期查询已上报的信息。</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>

    <div class="md-modal" id="modal-6">
        <div class="md-content">
            <h3>不良事件上报</h3>
            <div>
                <p>
                    提供职业暴露、医技、医疗、护理、用药、输血、治安等全院各种不良事件的上报，并提供统计查询功能。
                </p>
                <ul>
                    <li><strong>功能涵盖：</strong>职业暴露、医技、医疗、护理、用药、输血、治安各个方面的不良事件上报，部分提供图表统计查询功能。</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>

    <div class="md-modal" id="modal-7">
        <div class="md-content">
            <h3>护理不良事件上报</h3>
            <div>
                <p>
                    包括护理工作中常见的跌倒、坠床、管路滑脱、输液反应、非预期压疮等各种不良事件的信息上报和查询。
                </p>
                <ul>
                    <li><strong>功能涵盖：</strong>信息的上报和查询，图表的统计显示功能。</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>
        <div class="md-modal" id="modal-8">
        <div class="md-content">
            <h3>关于我们</h3>
            <div>
                <p>
                    新乡市中心医院综合业务上报系统基于ASP.Net.NetFramework 4.0三层架构，由信息科研发团队耗时数月研发而成。支持SQLServer、MySQL、Oracle、SQLite、Access 等多数据库类型。模块化设计，层次结构清晰。
                </p>
                <ul>
                    <li><strong>操作权限管理：</strong> 操作权限控制精密细致，对所有管理链接都进行权限验证，可控制到导航菜单、功能按钮。</li>
                    <li><strong>数据权限管理：</strong>数据权限（精细化数据权限控制，控制到行级，列表级，表单字段级，实现不同人看不同数据，不同人对同一个页面操作不同字段。</li>
                    <li><strong>效率和质量控制：</strong> 常用类封装，日志、缓存、验证等等。</li>
                    <li><strong>架构优化和安全：</strong> 采用三层架构，系统功能模块高内聚、低耦合，保证安全性的同时利于后续开发，灵活性更高。</li>
                    <li><strong>界面友好：</strong> 提供换肤功能，用户可根据自己喜好更换系统皮肤，按钮和菜单的人性化设计使操作更加便捷高效。</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>
    
<%--    <div class="md-modal" id="modal-9">
        <div class="md-content">
            <h3>护理质量数据上报</h3>
            <div>
                <p>
                    护理质量数据上报提供护理质量数据科室上报、护理质量数据查询、和护理质量数据科室查询等功能。
                </p>
                <ul>
                    <li><strong>护理质量数据科室上报:</strong> modal windows will probably 
						tell you something important so don&#39;t forget to read 
						what they say.</li>
                    <li><strong>Look:</strong> a modal window enjoys a 
						certain kind of attention; just look at it and 
						appreciate its presence.</li>
                    <li><strong>Close:</strong> click on the button below to 
						close the modal.</li>
                </ul>
                <button class="md-close">Close me!</button>
            </div>
        </div>
    </div>--%>
    <div id="main-content">
        <div class="wrapper">

            <div class="row">
                <div class="dashboard">
                    <div class="info-box blue-bg">
                        <div class="title" id="1">工资条查询</div>


                    </div>

                </div>
                <div class="dashboard">
                    <div class="info-box brown-bg">
                        <div class="title" id="2">护理质量数据上报</div>
                    </div>

                </div>
                <div class="dashboard">
                    <div class="info-box dark-bg">
                        <div class="title" id="3">环境监测上报</div>

                    </div>
                </div>
                <div class="dashboard">
                    <div class="info-box green-bg">
                        <div class="title" id="4">满意度调查</div>
                    </div>
                </div>
                <div class="dashboard">
                    <div class="info-box whiteblue-bg">
                        <div class="title" id="5">可疑医疗器械上报</div>
                    </div>
                </div>
                <div class="dashboard">
                    <div class="info-box red-bg">
                        <div class="title" id="6">不良事件上报</div>
                    </div>
                </div>
                <div class="dashboard">
                    <div class="info-box cyan-bg">
                        <div class="title" id="7">护理不良事件</div>
                    </div>
                </div>
                <div class="dashboard">
                    <div class="info-box yellow-bg">
                        <div class="title" id="8">关于我们</div>
                    </div>
                </div>
            </div>

            <div class="text">
            </div>
            <div></div>
            <div></div>


        </div>
    </div>
    <div class="md-overlay"></div>
    <script type="text/javascript">
        function center(a)
        {
            var wWidth = $(window).width();
            var wHeight = $(window).height();
            var boxWidth = $(a).width();
            var boxHeight = $(a).height();
            var scrollTop = $(window).scrollTop();
            var scrollLeft = $(window).scrollLeft();
            var top = scrollTop + (wHeight - boxHeight) / 2;
            var left = scrollLeft +(wWidth-boxWidth)/2;
            $(a).css({"top":top,"left":left});

        }
        function isIE()
        {
            var navigatorName = "Microsoft Internet Explorer";
            if (navigator.appName == navigatorName) {
                return true;
            }
            return false;
        }
        $("div.title").click(function () { $("#modal-" + this.id).show(); if (isIE()) { center("#modal-" + this.id); } $("div.md-overlay").show(); });
        $("button.md-close").click(function () { $("#" + this.parentNode.parentNode.parentNode.id).hide(); $("div.md-overlay").hide(); });
    </script>
</body>
</html>
