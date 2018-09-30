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
<input type="hidden" id="account" value="${Account}"/>
<input type="hidden" id="logintime" value="${LoginTime}"/>
<input type="hidden" id="seccode" value="${SecCode}"/>
</body>
<script type="text/javascript">
    $(function () {
        var account = $("#account").val();
        var logintime = $("#logintime").val();
        var seccode = $("#seccode").val();
        var url = "http://115.29.2.102:8092/ky/Home";
        $.ajax({
            type: "post",
            url: "http://115.29.2.102:8092/ky/LoginSSO",
            data: {"Account": account, "LoginTime": logintime, "SecCode": seccode, "returnUrl": url},
            dataType: "json",
            async: true,
            beforeSend: function () {
            },
            complete: function () {
            },
            success: function (result) {
                window.open("et.wanfangdata.com.cn/ky/Home");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {

            }
        });
    });
</script>
</html>
