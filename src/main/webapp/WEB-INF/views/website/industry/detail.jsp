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
    <title>${list.title}</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css" />
</head>
<body class="LS2018_body">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
    <div class="LS2018_bd">
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a>
            <span class="gt">&gt;</span>
            <a href="${staticPath}/forehead/industry/indusrtyList">特色专题库</a>
            <span class="gt">&gt;</span>
            <a href="${staticPath}/forehead/industry/selectOneInfo/${nav.id }">${nav.title }</a>
            <span class="gt">&gt;</span>
            <c:if test="${type.equals('0')}">
                <a href="${staticPath}/forehead/industry/list?id=${nav.id }&tid=${type}">期刊</a>
            </c:if>
             <c:if test="${type.equals('1')}">
                <a href="${staticPath}/forehead/industry/list?id=${nav.id }&tid=${type}">论文</a>
            </c:if>
            <c:if test="${type.equals('2')}">
                <a href="${staticPath}/forehead/industry/list?id=${nav.id }&tid=${type}">专利</a>
            </c:if>
            <c:if test="${type.equals('3')}">
                <a href="${staticPath}/forehead/industry/list?id=${nav.id }&tid=${type}">项目信息</a>
            </c:if>
            <c:if test="${type.equals('4')}">
                <a href="${staticPath}/forehead/industry/list?id=${nav.id }&tid=${type}">资讯</a>
            </c:if>
            <c:if test="${type.equals('5')}">
                <a href="${staticPath}/forehead/industry/list?id=${nav.id }&tid=${type}">科技成果</a>
            </c:if>
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
