<%--
  Created by IntelliJ IDEA.
  User: zhanghuaiyu
  Date: 2018/10/30
  Time: 8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/layui.jsp" %>
<html>
<head>
    <title>通知公告</title>
    <link rel="stylesheet" type="text/css" href="${staticPath }/static/innovation/css/main.css"/>
</head>
<body>
<%@ include file="/commons/ihead.jsp" %>
<div class="LS2018_bd LSKJ2018_bd">
    <div class="LS2018_MBX">
        当前位置：&nbsp;<a href="${staticPath}/innovation/index">首 页</a><span class="gt">&gt;</span><a
            href="${staticPath}/forehead/article/nlist">通知公告</a>
    </div>

    <div class="LS2018_Txt">
        <h1>${article.title}</h1>
        <div class="time">
            <span class="t1">发布时间：<fmt:formatDate value="${article.createTime}" pattern="yyyy-MM-dd"/></span>
        </div>
        <div class="txt">
            ${article.content }
        </div>
    </div>
</div>
<%@ include file="/commons/ifooter.jsp" %>
</body>
</html>
