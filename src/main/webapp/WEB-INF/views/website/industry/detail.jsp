<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/8/4
  Time: 14:13
  Abstract：文章详细页页面
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>细览</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css" />
</head>
<body class="LS2018_body">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
    <div class="LS2018_bd">
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span><a href="${staticPath}/forehead/industry/selectOneInfo/${nav.id }">${nav.title }</a><span class="gt">&gt;</span>${list.title}
        </div>
        <div class="LS2018_Txt">
            <h1>${list.title}</h1>
            <div class="time">
                <span class="t1">发布时间：<fmt:formatDate value="${list.createTime}" pattern="yyyy-MM-dd" /></span>
            </div>
            <div class="txt">
                ${list.content}
            </div>
        </div>
    </div>
<%@ include file="/commons/footer.jsp" %>
</div>
</body>
</html>
