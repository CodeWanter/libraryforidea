<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/8/4
  Time: 14:13
  Abstract：文章详细页页面
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/layui.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath }/static/lsportal1/H5/css/main_WeiXin.css"/>
</head>
<body class="LS2018_WX_body">
<div class="LS2018_WX_txt">
    <h1>${article.title}</h1>
    <div class="time">发布时间：<fmt:formatDate value="${article.createTime}" pattern="yyyy-MM-dd"/></div>
    <div class="txt">
        ${article.content }
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    //新闻浏览日志记录
    $.post("${staticPath}/logmanage/add", {sid: 1, t: "公告浏览", u: window.location.href}, "json");
</script>