<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/10/18
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${staticPath }/static/lsportal1/css/style.css"/>
    <script type="text/javascript" src="${staticPath }/static/lsportal1/js/jquery-1.12.1.min.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/extJs.js?v=${version}"></script>
    <script type="text/javascript" src="${staticPath }/static/lsportal1/js/slide.js"></script>
    <script src="${staticPath }/static/lsportal1/js/formValidator_min.js" type="text/javascript"
            charset="UTF-8"></script>
    <script src="${staticPath }/static/lsportal1/js/formValidatorRegex.js" type="text/javascript"
            charset="UTF-8"></script>
    <script src="${staticPath }/static/lsportal1/js/main.js"></script>
    <script type="text/javascrsipt" src="${staticPath }/static/lsportal1/js/modernizr-1.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/main.js?v=${version}"></script>

    <link rel="stylesheet" type="text/css" href="${staticPath }/static/lsportal1/css/style.css"/>
    <link rel="stylesheet" href="${staticPath }/static/lsportal1/css/index.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath }/static/lsportal1/css/all.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath }/static/lsportal1/css/slide.css" type="text/css"/>

    <link rel="stylesheet" type="text/css"
          href="${staticPath }/static/js/layui/css/layui.css"/>
    <script type="text/javascript"
            src="${staticPath }/static/js/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">
        //layui初始化
        layui.use('layer', function () {
            var $ = layui.jquery, layer = layui.layer;
        });
        var basePath = "${staticPath }";
    </script>
</head>
<body>
<div class="cd-user-modal-container" style="float: left;">
    <ul class="cd-switcher" style="font-size: medium;font-weight: bold">
        <li style="width:100%;"><a href="#0" style="background-color: #4cbbe1;">用户登录</a></li>
    </ul>
    <div> <!-- 登录表单 -->
        <form class="cd-form" method="post" id="loginform" class="layui-form">
            <p class="fieldset">
                <label class="image-replace cd-username" for="username">用户名</label>
                <input class="full-width has-padding has-border" lay-verify="loginName" id="username"
                       name="username" type="text" placeholder="输入用户名">
            </p>

            <p class="fieldset">
                <label class="image-replace cd-password" for="password">密码</label>
                <input class="full-width has-padding has-border" id="password" lay-verify="pass" name="password"
                       type="password" placeholder="输入密码">
            </p>
            <p class="fieldset">
                <label class="image-replace cd-password" for="captcha">验证码</label>
                <input class="captcha" style="height: 40px;text-indent: 50px;border: 1px solid #d2d8d8;"
                       type="text" name="captcha" placeholder="请输入验证码"/>
                <img id="captcha" alt="验证码" src="${path }/captcha.jpg" data-src="${path }/captcha.jpg?t="
                     style="vertical-align: middle; border-radius: 4px; width: 94.5px; height: 35px; cursor: pointer;">
            </p>
            <p class="fieldset">
                <input type="checkbox" id="rememberMe" name="rememberMe" checked value="1">
                <label for="rememberMe">记住登录状态</label>
            </p>

            <p class="fieldset">
                <input class="full-width2" type="submit" value="登 录" onclick="userlogin();">
            </p>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    // 验证码
    $("#captcha").click(function () {
        var $this = $(this);
        var url = $this.data("src") + new Date().getTime();
        $this.attr("src", url);
    });
    // 登录
    $('#loginform').form({
        url: basePath + '/api/login',
        onSubmit: function () {
            var isValid = $(this).form('validate');
            return isValid;
        },
        success: function (result) {
            result = $.parseJSON(result);
            if (result.success) {
                var url = getUrlParam("backurl") + "&sid=" + result.obj.sid;
                top.location.href = url;
            } else {
                // 刷新验证码
                $("#captcha")[0].click();
                layer.msg(result.msg);
            }
        }
    });

    //获取url中的参数
    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        if (r != null) return unescape(r[2]);
        return null; //返回参数值
    }
</script>
</html>
