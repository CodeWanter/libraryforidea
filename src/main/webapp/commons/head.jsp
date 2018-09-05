<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/8/9
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
    function logout(){
        $.post(basePath + '/logout', function(result) {
             if(result.success){
                  window.location.href = basePath + '/';
             }
        }, 'json');
    }
</script>

<div class="LS2018_hd">
<shiro:user>
    <div class="LS2018_home_top" style="float: right;margin: 10px;">
				<span>当前用户：<b><shiro:principal property="name"/></b>
					<a href="${staticPath }/forehead/personal/center">个人中心</a>
				<a href="#" onclick="logout();">退出登录</a>
				</span>
    </div>
    </shiro:user>
    <ul class="LS2018_nav">
        <li><a href="${staticPath}/">首  页</a></li>
        <li><a href="#">科技服务</a>
            <ul>
                <li><a href="#">查重查新</a></li>
                <li><a href="#">TRIZ知识组织</a></li>
                <li><a href="#">主题分析报告</a></li>
                <li><a href="#">特色专题库</a></li>
            </ul>
        </li>
        <li><a href="#">公告公示</a>
            <ul>
                <li><a href="${staticPath}/forehead/article/articlelist">最新动态</a></li>
                <li><a href="${staticPath}/forehead/collect/collectlist">每日更新</a></li>
                <li><a href="${staticPath}/forehead/article/articlelist#a02">试用资源</a></li>
            </ul>
        </li>
        <li><a href="${staticPath}/#a01">资源列表</a></li>
    </ul>
</div>
