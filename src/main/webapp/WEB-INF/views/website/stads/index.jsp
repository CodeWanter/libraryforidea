<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/9/29
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="shior" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="max-age=7200"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0"/>
    <meta name="renderer" content="webkit">
    <link rel="shortcut icon" href="${staticPath }/static/style/${staticPath }/static/lsportal1/images/favicon.ico"/>
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
    <style>
        body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
            overflow: hidden;
        }
    </style>
    <title>创新助手</title>
</head>
<body>
<div id="main">
    <div class="txt">
        <a href="#"><img src="${staticPath }/static/lsportal1/image/logo.png">
            <a href="http://www.lsnetlib.com" target="_blank" style="cursor: pointer;color: #0d78d3;">返回旧版</a>
        </a>
    </div>
    <div class="demo">
        <nav class="main_nav">
            <shiro:guest>
                <ul>
                    <li style="border-right:1px solid blue"><a class="cd-signin" href="#0" id="userlogin">登录</a></li>
                    <li><a class="" href="${staticPath }/forehead/userRegist">注册</a></li>
                </ul>
            </shiro:guest>
        </nav>
        <shiro:user>
            <!--###### 2018-08-06 ######-->
            <div class="LS2018_home_top">
				<span>当前用户：<b><shiro:principal/></b>
					<a href="${staticPath }/forehead/personal/center">个人中心</a>
				<a href="#" onclick="logout();">退出登录</a>
				</span>
            </div>
        </shiro:user>
    </div>
    <div class="cd-user-modal">
        <div class="cd-user-modal-container">
            <ul class="cd-switcher" style="font-size: medium;font-weight: bold">
                <li style="width:100%;"><a href="#0" style="background-color: #4cbbe1;">用户登录</a></li>
                <%--<li><a href="#0">注册新用户</a></li>--%>
            </ul>
            <div id="cd-login"> <!-- 登录表单 -->
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
                        <input class="full-width2" type="submit" value="登 录">
                    </p>
                </form>
            </div>
            <a href="#0" class="cd-close-form">关闭</a>
        </div>
    </div>

</div>
<div class="section-wrap">
    <iframe src="http://webstads.sciinfo.cn/stads.do?index" width="100%" height="100%" frameborder="0"></iframe>
    <div class="layui-clear"></div>
    <%--<div class="x">--%>
    <%--<ul class="x2">--%>
    <%--<li>主办单位:丽水市人民政府</li>--%>
    <%--<li>承办单位:丽水市科技信息中心</li>--%>
    <%--<li>技术支持:上海万方数据有限公司</li>--%>
    <%--<li>免费咨询电话: 400-889-9177</li>--%>
    <%--<li>COPYRIGHT ©2007 LSNETLIB.COM INCORPORATED. ALL RIGHTS RESERVED.</li>--%>
    <%--<li>--%>
    <%--<span>浙ICP备09054032号</span>--%>
    <%--<img src="${staticPath }/static/lsportal1/image/icon-8.png">--%>
    <%--</li>--%>
    <%--</ul>--%>
    <%--</div>--%>
</div>
</div>
</body>
<script type="text/javascript">
    // 登录
    $('#loginform').form({
        url: basePath + '/login',
        onSubmit: function () {
            var isValid = $(this).form('validate');
            return isValid;
        },
        success: function (result) {
            result = $.parseJSON(result);
            if (result.success) {
                window.location.href = basePath + '/forehead/stads/index';
            } else {
                // 刷新验证码
                $("#captcha")[0].click();
                layer.msg(result.msg);
            }
        }
    });
    function logout() {
        $.post(basePath + '/logout', function (result) {
            result = $.parseJSON(result);
            if (result.success) {
                progressClose();
                window.location.href = basePath + '/forehead/stads/index';
            }
        }, 'text');
    }
</script>
</html>
