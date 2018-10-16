<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/9/21
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/layui.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<input type="hidden" id="account" value="${account}"/>
<input type="hidden" id="logintime" value="${logintime}"/>
<input type="hidden" id="seccode" value="${seccode}"/>
</body>
<script type="text/javascript">
    $(function () {
        var account = $("#account").val();
        var logintime = $("#logintime").val();
        var seccode = $("#seccode").val();
        console.log("http://115.29.2.102:8092/ky/Login/LoginSSO?Account=" + account + "&LoginTime=" + logintime + "&SecCode=" + seccode + "&returnUrl=http://115.29.2.102:8092/ky/Home");
        //window.location.href="http://115.29.2.102:8092/ky/Login/LoginSSO?Account=" + account + "&LoginTime=" + logintime + "&SecCode=" + seccode + "&returnUrl=http://115.29.2.102:8092/ky/Home"
    });
</script>
</html>
