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
</div>
</body>
<%--<script type="text/javascript" src="${staticPath}/static/js/ckplayer/ckplayer.js"></script>--%>
<%--<div class="video" style="width: 1000px;height: 600px;"></div>--%>
<%--<script type="text/javascript">--%>
    <%--var videoObject = {--%>
        <%--container: '#video',//“#”代表容器的ID，“.”或“”代表容器的class--%>
        <%--variable: 'player',//该属性必需设置，值等于下面的new chplayer()的对象--%>
        <%--poster:'pic/wdm.jpg',//封面图片--%>
        <%--video:$("#video").attr("src")//视频地址--%>
    <%--};--%>
    <%--var player=new ckplayer(videoObject);--%>
<%--</script>--%>
</html>
