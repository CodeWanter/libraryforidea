<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/9/29
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/layui.jsp" %>
<html>
<head>
    <script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/filter.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="http://webstads.sciinfo.cn/static/css/main.css"/>
    <link rel="stylesheet" type="text/css" href="http://webstads.sciinfo.cn/static/css/jquery-modal-plug.css"/>
    <link rel="stylesheet" type="text/css" href="http://webstads.sciinfo.cn/static/css/demoModal.css"/>
    <title>创新助手</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css"/>
</head>
<body class="LS2018_body" onload="load()">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
    <div>
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a>
        </div>
    </div>
    <iframe src="http://webstads.sciinfo.cn/stads.do?index" width="100%" height="100%" frameborder="0"></iframe>
    <%--<div class="LS2018_Txt" id="stads"></div>--%>
    <%@ include file="/commons/footer.jsp" %>
</div>
</body>
<script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/tools.tabs-1.0.4.min.js"></script>
<script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/main.js"></script>
<script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/fileService.js"></script>
<script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/Sweefty.js"></script>
<script type="text/javascript" src="${staticPath}/static/lsportal/stads/index.js"></script>
<script type="text/javascript" src="${staticPath}/static/lsportal/stads/public.js"></script>
<script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/qrcode.js"></script>
<script type="text/javascript" src="http://webstads.sciinfo.cn/static/js/jquery-modal-plug.js"></script>
<script type="text/javascript">
    function load() {
        $.get("${staticPath}/forehead/stads/stadshtml", {}, function (data) {
            $("#stads").html(data);
        })
    }
</script>
</html>
