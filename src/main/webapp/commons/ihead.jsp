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

<script type="text/javascript">
    function logout() {
        $.post('${staticPath}/logout', function (result) {
            window.location.href = '${staticPath}/innovation/index';
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
					<a href="${staticPath }/innovation/center">个人中心</a>
				    <a href="#" onclick="logout();">退出登录</a>
				</span>
                </div>
            </shiro:user>
            <shiro:guest>
                <a href="${staticPath }/innovation/regist">注 册</a>
                <a href="${staticPath }/innovation/login">登 录</a>
            </shiro:guest>
        </div>
    </div>

    <ul class="LSKJ2018_nav">
        <li>
            <a href="${staticPath}/innovation/index">首 页</a>
        </li>
        <li>
            <a href="${staticPath}/forehead/article/nlist">通知公告</a>
        </li>
        <li>
            <a href="${staticPath}/forehead/policy/plist">政策法规</a>
        </li>
        <li>
            <a href="#">人才服务</a>
        </li>
        <li>
            <a href="#">中介服务</a>
            <ul>
                <li><a href="${staticPath}/forehead/intermedOrg/add">申请机构注册</a></li>
                <li><a href="#">机构服务中心</a></li>
            </ul>
        </li>
        <shiro:hasRole name="机构用户">
            <li>
                <a href="${staticPath}/intermedOrg/index">我的服务</a>
            </li>
        </shiro:hasRole>
    </ul>
</div>
