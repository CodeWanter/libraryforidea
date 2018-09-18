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
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span><a href="${staticPath}/forehead/article/articlelist">最新动态</a>
        </div>

        <div class="LS2018_Txt">
            <h1>${article.title}</h1>
            <div class="time">
                <span class="t1">发布时间：<fmt:formatDate value="${article.createTime}" pattern="yyyy-MM-dd" /></span>
            </div>
            <div class="txt">
                ${article.content }
            </div>
        </div>
    </div>
<%@ include file="/commons/footer.jsp" %>
    <input type="hidden" value="<%=request.getSession().getId()%>" id="userid"/>
</div>
</body>
</html>
<script type="text/javascript">
    //新闻浏览日志记录
    $.post("${staticPath}/logmanage/add", {sid: 1, t: "公告浏览", u: window.location.href}, "json");
</script>