<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/9/11
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp"%>
<html>
<head>
    <title>特色专题库</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css" />
</head>
<body class="LS2018_body">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
        <div class="LS2018_bd">
            <div class="LS2018_MBX">
                当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>特色专题库
            </div>
            <ul class="LS2018_ZT_list">
            <c:forEach var="data" items="${list}">
                    <li class="Z_clearfix">
                        <a href="${staticPath}/forehead/industry/selectOneInfo/${data.id}">
                            <img src="${staticPath}/static/lsportal/images/industry/${data.fileName}"
                                 onmouseover="tip('${data.infomation}',this)"/>
                            <div class="aa">${data.title}</div>
                            <div class="tt">点击率：${data.clickCount}</div>
                        </a>
                    </li>
            </c:forEach>
            </ul>
            <div class="Z_clear">&nbsp;</div>
        </div>
    <%@ include file="/commons/footer.jsp" %>
</body>
</html>
<script type="text/javascript">
    function tip(msg, obj) {
        if (msg != "")
            layer.tips(msg, obj, {
                tips: [2, '#3280FC']
            });
    }
</script>