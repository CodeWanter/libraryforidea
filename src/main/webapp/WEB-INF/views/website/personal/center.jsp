<%--
  Created by IntelliJ IDEA.
  User: hjqyl
  Date: 2018/8/8
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/commons/layui.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0"/>
    <meta name="renderer" content="webkit">

    <title>个人中心</title>
</head>
<body>
<shiro:user>
    <div>
        <table>
            <tr>
                <td>用户名：</td>
                <td><input type="text" id="name" value="${user.name}"></td>
            </tr>
            <tr>
                <td>年龄：</td>
                <td> <input type="text" id="age" name="age" value="${user.age}"></td>
            </tr>
        </table>
    </div>
</shiro:user>
</body>
</html>
