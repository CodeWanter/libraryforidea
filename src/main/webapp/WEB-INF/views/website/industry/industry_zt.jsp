<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp"%>
<!DOCTYPE html>
<head>
<script type="text/javascript" src="${staticPath}/static/lsportal/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${staticPath}/static/lsportal/js/tools.tabs-1.0.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css" />
	<title>${industry.title}</title>
<style type="text/css">
	.LS2018_ZT_banner .ZT{
	    width: 1000px;
   		height: 250px;
	}
</style>
</head>
<body class="LS2018_body">
	<div class="LS2018_main">
		<%@ include file="/commons/head.jsp" %>
		<div class="LS2018_bd Z_clearfix">
			<div class="LS2018_MBX">
				当前位置：&nbsp;<a href="${staticPath}/forehead/index">首 页</a>
				<span class="gt">&gt;</span>
				<a href="${staticPath}/forehead/industry/indusrtyList">特色专题库</a>
				<span class="gt">&gt;</span>${industry.title}
			</div>
			<!-- 专题头部，不同专题用不同样式名 ZT1~ZT12 -->
			<div class="LS2018_ZT_banner" style="height: 250px;width: 1000px;background-image:url(${staticPath}/static/lsportal/images/industry/${industry.fileName});background-size: 100% 100%;">
				<div class="tt">${industry.title}</div>
			</div>		
			
			<div class="LS2018_ZT_left">
				<div class="LS2018_ZT_card1 cardA">
					<div class="card_nav Z_clearfix">
						<a href="#">期  刊</a>
						<a href="#">论  文</a>
					</div>
					<div class="card_div">
						<div>
							<ul>
								<%--${list.records}--%>
								<c:forEach var="data" items="${list.records}">
									<c:if test="${data.type.equals('0')}">
										<li><a href="javascript:void(0)" onclick="javascript:goDetail('${data.id}','${data.type}')">${data.title}</a></li>
									</c:if>
								</c:forEach>
							</ul>
							<div class="more">
								<a href="${staticPath}/forehead/industry/list?id=${industry.id}&tid=0">more &gt;</a>
							</div>
						</div>
						<div>
							<ul>
								<c:forEach var="data" items="${list.records}">
									<c:if test="${data.type.equals('1')}">
										<li><a href="javascript:void(0)" onclick="javascript:goDetail('${data.id}','${data.type}')">${data.title}</a></li>
									</c:if>
								</c:forEach>
							</ul>
							<div class="more">
								<a href="${staticPath}/forehead/industry/list?id=${industry.id}&tid=1">more &gt;</a>
							</div>
						</div>
					</div>
				</div>
				<script type="text/javascript">
				$(function(){
					$('.cardA .card_nav').tabs('.cardA .card_div > div' , {history:true});
				});
				</script>
			</div>
			
			
			<div class="LS2018_ZT_right">
				<div class="LS2018_ZT_card2 cardB">
					<div class="card_nav Z_clearfix">
						<a href="#">专  利</a>
						<a href="#">项目信息</a>
					</div>
					<div class="card_div">
						<div>
							<ul>
								<c:forEach var="data" items="${zllist.records}">
									<c:if test="${data.type.equals('2')}">
										<li>· <a href="javascript:void(0)" onclick="javascript:goDetail('${data.id}','${data.type}')">${data.title}</a></li>
									</c:if>
								</c:forEach>
							</ul>
							<a class="more" href="${staticPath}/forehead/industry/list?id=${industry.id}&tid=2">more &gt;</a>
						</div>
						<div>
							<ul>
								<c:forEach var="data" items="${xmlist.records}">
									<c:if test="${data.type.equals('3')}">
										<li>· <a href="javascript:void(0)" onclick="javascript:goDetail('${data.id}','${data.type}')">${data.title}</a></li>
									</c:if>
								</c:forEach>
							</ul>
							<a class="more" href="${staticPath}/forehead/industry/list?id=${industry.id}&tid=3">more &gt;</a>
						</div>
					</div>
				</div>
				<script type="text/javascript">
				$(function(){
					$('.cardB .card_nav').tabs('.cardB .card_div > div' , {history:true});
				});
				</script>			
				
				<div class="LS2018_ZT_adv">
					<a href="#" target="_blank">
						<img src="${staticPath}/static/lsportal/images/New_ZT_01B.jpg" /><!-- 根据不同专题，替换图片 New_ZT_01B ~ New_ZT_12B -->
					</a>
				</div>
				
				<div class="LS2018_ZT_card2 cardC">
					<div class="card_nav Z_clearfix">
						<a href="#">资  讯</a>
						<a href="#">科技成果</a>
					</div>
					<div class="card_div">
						<div>
							<ul>
								<c:forEach var="data" items="${zxlist.records}">
									<c:if test="${data.type.equals('4')}">
										<li>· <a href="javascript:void(0)" onclick="javascript:goDetail('${data.id}','${data.type}')">${data.title}</a></li>
									</c:if>
								</c:forEach>
							</ul>
							<a class="more" href="${staticPath}/forehead/industry/list?id=${industry.id}&tid=4">more &gt;</a>
						</div>
						<div>
							<ul>
								<c:forEach var="data" items="${kjlist.records}">
									<c:if test="${data.type.equals('5')}">
										<li>· <a href="javascript:void(0)" onclick="javascript:goDetail('${data.id}','${data.type}')">${data.title}</a></li>
									</c:if>
								</c:forEach>
							</ul>
							<a class="more" href="${staticPath}/forehead/industry/list?id=${industry.id}&tid=5">more &gt;</a>
						</div>
					</div>
				</div>
				<script type="text/javascript">
				$(function(){
					$('.cardC .card_nav').tabs('.cardC .card_div > div' , {history:true});
				});
				</script>			
			</div>
			
			<div class="Z_clear">&nbsp;</div>
			
			
			<div class="LS2018_ZT_other Z_clearfix">
				<div class="ot_left">
					<div class="tt">其他产业</div>
				</div>
				<div class="ot_right">
					<div class="list small">
						<c:forEach var="fld" items="${industrys}">
							<c:if test="${fld.id != id}">
								<a href="${staticPath}/forehead/industry/selectOneInfo/${fld.id}">
									<span class="tt">${fld.title}</span>
									<img src="${staticPath}/static/lsportal/images/industry/${fld.fileName}" alt=""/>
								</a>
							</c:if>
						</c:forEach>
					</div>
					<div class="zk">
						<a class="a1">展开 ↓</a><a class="a2">收起 ↑</a>
					</div>
				</div>
				<script type="text/javascript">
				$(function(){
					$('.zk .a1').click(function(){
						$(this).parent().prev('.list').removeClass('small');
						$(this).next('.a2').css('display','inline');
						$(this).css('display','none');
					});
					$('.zk .a2').click(function(){
						$(this).parent().prev('.list').addClass('small');
						$(this).prev('.a1').css('display','inline');
						$(this).css('display','none');
					});
	
				});
				</script>
			</div>
			
		</div>
		<%@ include file="/commons/footer.jsp" %>
	</div>
</body>
</html>
<script type="text/javascript">
	//专题浏览日志记录
	$.post("${staticPath}/logmanage/add",{userid:1,t:"专题浏览",u:window.location.href},"json");
	function goDetail(id,type){
	    window.location.href="${staticPath}/forehead/industry/detail/"+id+"/"+ ${industry.id}+"/"+ type;
	}
</script>