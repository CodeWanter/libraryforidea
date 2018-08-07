<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/8/4
  Time: 14:13
  Abstract：文章详细页页面
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--加载jstl和当前上下文环境--%>
<%@ include file="/commons/layui.jsp" %>
<html>
<head>
    <title>细览</title>
</head>
<body style="width:1000px;margin: 0 auto;">

    <h2>${article.title}</h2>
    <hr class="layui-bg-red">
<div class="content">
    ${article.content }
</div>
<footer>
<span>发布时间：<fmt:formatDate value="${article.createTime}" pattern="yyyy-MM-dd HH:mm" />
</footer>
</body>
</html>
