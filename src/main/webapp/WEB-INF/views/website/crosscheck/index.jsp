<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/9/29
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="shior" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="max-age=7200"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0"/>
    <meta name="renderer" content="webkit">
    <link rel="shortcut icon" href="${staticPath }/static/style/${staticPath }/static/lsportal1/images/favicon.ico"/>
    <script type="text/javascript" src="${staticPath }/static/lsportal1/js/jquery-1.12.1.min.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/extJs.js?v=${version}"></script>
    <script type="text/javascript" src="${staticPath }/static/lsportal1/js/slide.js"></script>
    <script src="${staticPath }/static/lsportal1/js/formValidator_min.js" type="text/javascript"
            charset="UTF-8"></script>
    <script src="${staticPath }/static/lsportal1/js/formValidatorRegex.js" type="text/javascript"
            charset="UTF-8"></script>
    <script src="${staticPath }/static/lsportal1/js/main.js"></script>
    <script type="text/javascrsipt" src="${staticPath }/static/lsportal1/js/modernizr-1.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/main.js?v=${version}"></script>

    <link rel="stylesheet" type="text/css" href="${staticPath }/static/lsportal1/css/style.css"/>
    <link rel="stylesheet" href="${staticPath }/static/lsportal1/css/index.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath }/static/lsportal1/css/all.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath }/static/lsportal1/css/slide.css" type="text/css"/>

    <link rel="stylesheet" type="text/css"
          href="${staticPath }/static/js/layui/css/layui.css"/>
    <script type="text/javascript"
            src="${staticPath }/static/js/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">
        //layui初始化
        layui.use('layer', function () {
            var $ = layui.jquery, layer = layui.layer;
        });
        var basePath = "${staticPath }";

    </script>
    <style>
        body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
            overflow: hidden;
        }
    </style>
    <title>查重查新</title>
</head>
<body>
<div id="main">
    <div class="txt">
        <a href="${staticPath }/" title="点此处返回首页"><img src="${staticPath }/static/lsportal1/image/logo.png">
            <a href="http://www.lsnetlib.com" target="_blank" style="cursor: pointer;color: #0d78d3;">返回旧版</a>
        </a>
    </div>
    <div class="demo">
        <nav class="main_nav">
        </nav>
    </div>
</div>
<div class="section-wrap">
    <iframe src="http://115.29.2.102:8092/ky/login" width="100%" height="100%" frameborder="0"></iframe>
    <div class="layui-clear"></div>
</div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        try {
            document.domain = "115.29.2.102"
        } catch (e) {
        }
    })
</script>
</html>
