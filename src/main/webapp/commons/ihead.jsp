<%--
  Created by IntelliJ IDEA.
  User: zhanghuaiyu
  Date: 2018/10/29
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="shior" uri="http://shiro.apache.org/tags" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript" src="${staticPath }/static/lsportal1/js/jquery-1.12.1.min.js"></script>
<script type="text/javascript">
    function logout() {
        $.post(basePath + '/logout', function (result) {
            window.location.href = basePath + '/';
        }, 'json');
    }
</script>
<div class="LSKJ2018_hd">
    <div class="main Z_clearfix">
        <div class="logo"></div>

        <div class="links">
            <shiro:user>
                <div class="LS2018_home_top">
				<span>当前用户：<b><shiro:principal property="name"/></b>
					<a href="${staticPath }/forehead/personal/center">个人中心</a>
				    <a href="#" onclick="logout();">退出登录</a>
				</span>
                </div>
            </shiro:user>
            <shiro:guest>
                <a href="${staticPath }/forehead/userRegist">注 册</a>
                <a href="#" target="_blank">登 录</a>
            </shiro:guest>
        </div>
    </div>

    <ul class="LSKJ2018_nav">
        <li>
            <a class="current">首 页</a>
        </li>
        <li>
            <a href="#">通知公告</a>
        </li>
        <li>
            <a href="#">政策法规</a>
        </li>
        <li>
            <a href="#">人才服务</a>
        </li>
        <li>
            <a href="#">中介服务</a>
            <ul>
                <li><a href="#">申请机构注册</a></li>
                <li><a href="#">机构服务中心</a></li>
            </ul>
        </li>
    </ul>
</div>
