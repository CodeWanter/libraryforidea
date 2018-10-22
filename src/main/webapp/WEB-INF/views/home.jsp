<%@ taglib prefix="shior" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
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
	<title>丽水市网络图书馆</title>
</head>

<body>
<!--title-->
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
<!--main-->
<section class="section-wrap">

	<div class="section section-1" id="bg">
		<div class="title active">

			<!--logo部分代码开始-->

			<!--统一检索部分代码开始-->

			<div class="search">
				<form id="form" onSubmit="lslibSearch();" target="_blank">

					<ul class="ser">
						<li>
							<input id="txtKeyWord" name="txtKeyWord" type="text" value="请输入关键词"
								   onFocus="if (value =='请输入关键词'){value =''}" onBlur="if (value ==''){value='请输入关键词'}"
								   style="background:#fff;font-size:13px;color:#8b8b8b;height:100%;outline: none">
							</input>
						</li>
						<li class="btu" onclick="lslibSearch();">
							<img src="${staticPath }/static/lsportal1/images/icon.png" alt="">
						</li>
					</ul>
				</form>
			</div>
		</div>

		<div class="container">
			<div id="fsDb" class="bannerfocus">
				<div id="D1picb" class="fPic">
					<div class="bannerfcon" style="display:block">
						<div class="text text_true">
							<h2><a href="" target="_blank"></a></h2>
							丽水市网络图书馆于2008年6月18日正式开通，现已成为全市公民上网学习的重要平台，为丽水创建学习型社会和经济建设提供了强大的信息支撑。2010年，丽水市网络图书馆建设项目被评为“浙江省十大民生工程”。
							丽水市网络图书馆共创建了期刊论文库、硕博士论文库等7个学术论文库，1亿2千多万篇论文，电子图书300多万册，同时兼顾了国家公务员考试、司法考试、计算机等级等各类社会考试，中学学科网、中小学考试试题500多万套，以及国务院研究发展中心信息网、丽水市农业专家知识系统等，已能较好满足丽水广大读者对“互联网+时代”对知识的“随时、免费、正版”需求。
						</div>
					</div>
					<div class="bannerfcon" style="display:none">
						<div class="text">
							<h2><a href="#resourcelist">资源服务</a></h2>
							资源服务包括各种数字资源服务，涵盖了自然科学、工程技术、医药卫生、农业科学、哲学政法、社会科学、科教文艺等各个学科；外文期刊主要来源于外文文献数据库。
						</div>
					</div>
					<div class="bannerfcon" style="display:none">
						<div class="text">
							<h2><a href="http://www.drcnet.com.cn/#g=library" target="_blank">政策资讯</a></h2>
                            以国务院发展研究中心丰富的信息资源和强大的专家阵容为依托，全面汇集、整合国内外经济金融领域的经济信息和研究成果，为中国各级政府部门、研究机构和企业准确把握国内外宏观环境、经济金融运行特征、发展趋势及政策走向。
						</div>
					</div>
					<!--<div class="bannerfcon" style="display:none">-->
					<!--<div class="text">-->
					<!--<h2><a href="/conf/load.do" target="_blank">会议论文</a></h2>-->
					<!--会议资源包括中文会议和外文会议，中文会议收录始于1982年，年收集4000多个重要学术会议，年增20万篇全文，每月更新；外文会议主要来源于外文文献数据库，收录了1985年以来世界各主要学协会、出版机构出版的学术会议论文。-->
					<!--</div>-->
					<!--</div>-->
					<div class="bannerfcon" style="display:none">
						<div class="text">
							<h2><a href="/navigations/patent.do" target="_blank">专利服务</a></h2>
							专利信息是集科技、法律、经济于一体的综合性信息,成为知识经济时代企业发展最重要的资源。优质的专利服务是有效获取、运用、保护、管理专利的基础,在这里可以获取你想要的专利信息。
						</div>
					</div>
					<div class="bannerfcon" style="display:none">
						<div class="text">
							<h2><a href="http://2018.lsnetlib.com/forehead/industry/indusrtyList"
								   target="_blank">产业库</a></h2>
							产业库主要覆盖了主要的十二个产业库，主要高新装备及机器人产业、生物医药产业、新材料产业、电子信息产业、节能环保产业、文化创意制造业、农林产品加工业、机械装备制造业、合成革制造业、羽绒和鞋革制品业、不锈钢及制品业、日用化工制造业，涵盖新技术、新产品、新工艺、新材料、新设计等众多领域。
						</div>
					</div>
					<div class="bannerfcon" style="display:none">
						<div class="text">
							<h2><a href="http://standard.lsnetlib.com/#g=db" target="_blank">标准</a></h2>
							标准资源来源于中外标准数据库，涵盖了中国标准、国际标准以及各国标准等在内的37万多条记录，综合了由国家技术监督局、建设部情报所、建材研究院等单位提供的相关行业的各类标准题录。全文数据来源于国家指定的专有标准出版单位，文摘数据来自中国标准化研究院国家标准馆，数据权威。
						</div>
					</div>
					<div class="bannerfcon" style="display:none">
						<div class="text">
							<h2><a href="http://video.wanfangdata.com.cn/" target="_blank">视频</a></h2>
							视频是以科技、教育、文化为主要内容的学术视频知识服务系统，现已推出高校课程、会议报告、考试辅导、医学实践、管理讲座、科普视频、高清海外纪录片等适合各类人群使用的精品视频。截止目前，已收录视频3万余部，近90万分钟。
						</div>
					</div>
				</div>
				<span class="prev"></span> <span class="next"></span>
			</div>
			<div class="BrainShadow"></div>
			<div class="BrainMapMain" id="D1fBtb">
				<div class="focus jianjie">
					<a target="_blank" href="javascript:void(0);">系统介绍</a>
				</div>
				<div class="focus qikan">
					<a href="#resourcelist">资源服务</a>
				</div>
				<div class="focus xuewei">
					<a target="_blank" href="http://www.drcnet.com.cn/#g=library">政策资讯</a>
				</div>
				<!--<div class="focus hylw">-->
				<!--<a target="_blank" href="/conf/load.do">会议</a>-->
				<!--</div>-->
				<div class="focus zhuanli">
					<a target="_blank" href="http://patent.lsnetlib.com/#g=db">专利服务</a>
				</div>
				<div class="focus kjcg">
					<a target="_blank" href="http://2018.lsnetlib.com/forehead/industry/indusrtyList">产业库</a>
				</div>
				<div class="focus biaozhun">
					<a target="_blank" href="http://standard.lsnetlib.com/#g=db">标准</a>
				</div>
				<div class="focus shipin">
					<a target="_blank" href="http://video.wanfangdata.com.cn" class="wfsp">视频</a>
				</div>
				<div class="focus more">
					<a target="_blank" href="javascript:void(0)">更多</a>
				</div>
			</div>
			<div class="BrainMap2"></div>
			<div class="BrainMap3"></div>
			<div class="BrainMap4"></div>
		</div>
		<script>
            $(".container").on('mouseenter', '.BrainMapMain div', function () {
//            console.log($(this).index());

                $('.fPic>div').eq($(this).index()).css({display: 'block'});
                $('.fPic>div').eq($(this).index()).siblings().css({display: 'none'})
            });
            //

		</script>
		<div class="marsk-container"></div>

		<script type="text/javascript">
            $(document).ready(function () {
                $("input").click(function (event) {
                    event.stopPropagation(); //停止事件冒泡
                    $(".marsk-container").toggle();
                });
                //点击空白处隐藏弹出层
                $("body").click(function (event) {
                    var _con = $('.marsk-containe');  // 设置目标区域
                    if (!_con.is(event.target) && _con.has(event.target).length == 0) {
                        $('.marsk-container').hide();     //淡出消失
                    }
                });
            });
		</script>
	</div>

	<div class="section section-2" id="a01">

		<div class="col-sm-6 four_contentBox" id="resourcelist">
			<h1>资源列表</h1>
			<div class="contentBox">
				<div class="data" style="display: flex;z-index: 101">
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-1.png);">
						<h3>视频报告</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>视频报告</h3>-->
							<p><a href="http://www.wsbgt.com/" target="_blank">爱迪科森网上报告厅</a></p>
							<p><a href="http://www.videolib.cn/" target="_blank">知识视界视频库</a></p>
							<p><a href="" target="_blank">书生企业管理：视频库·电子图书</a></p>
							<p><a href="http://xh30.lsnetlib.com/" target="_blank">星火科技30分农业视频库</a></p>
						</div>
					</div>
					<!-- end colored -->
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-2.png);">
						<h3>期刊论文</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>博硕 会议论文</h3>-->
							<p><a href="http://epub.cnki.net/kns/brief/result.aspx?dbPrefix=CJFQ" target="_blank">中国期刊全文数据库</a>
							</p>
							<p><a href="http://epub.cnki.net/kns/brief/result.aspx?dbprefix=CDFD" target="_blank">中国博士学位论文全文数据库</a>
							</p>
							<p><a href="http://epub.cnki.net/kns/brief/result.aspx?dbprefix=CMFD" target="_blank">中国优秀硕士学位论文全文数据库</a>
							</p>
							<p><a href="http://epub.cnki.net/kns/brief/result.aspx?dbPrefix=CIPD" target="_blank">中国重要会议论文全文数据库</a>
							</p>
						</div>
					</div>
					<!-- end colored -->
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-3.png);">
						<h3>图书杂志</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>电子图书</h3>-->
							<p><a href="http://kjxx.vip.qikan.com/text/text.aspx" target="_blank">龙源原貌期刊</a></p>
							<p><a href="http://www.sslibrary.com/#g=db" target="_blank">超星电子图书</a></p>
							<p><a href="http://www.lelisten.net/#g=db" target="_blank">时夕乐听网</a></p>
						</div>

					</div>
					<!-- end colored -->
				</div>
				<div class="data" style="display: flex;z-index: 100">
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-4.png);">
						<h3>企业创新</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>报刊杂志</h3>-->
							<p><a href="http://patent.lsnetlib.com/#g=db" target="_blank">丽水市专利信息公共服务平台</a></p>
							<p><a href="http://www.lsinfo.gov.cn/IndustryWeb.aspx" target="_blank">行业专题库</a></p>
							<p><a href="http://www.zckt.tv/#g=db" target="_blank"> 众创课堂</a></p>
							<p><a href="http://www.rarelit.net/#g=db" target="_blank">科技报告资源服务系统</a></p>
							<p><a href="http://standard.lsnetlib.com/#g=db" target="_blank">标准数据服务平台</a></p>
							<p><a href="http://gpd.sunwayinfo.com.cn/#g=db" target="_blank">产品样本数据库</a></p>
						</div>
					</div>
					<!-- end colored -->
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-5.png);">
						<h3>医学资源</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>医疗卫生</h3>-->
							<p><a href="http://kns.chkd.cnki.net/kns55/brief/single_default.aspx?dbprefix=chkd"
								  target="_blank">中国医院知识总库</a></p>
							<p><a href="http://new.metstr.com/login.aspx?mode=IP&class=B1#g=library" target="_blank">万方数据资源系统</a>
							</p>
							<p><a href="http://www.lsnetlib.com/zjelib.htm?lib=wf#g=library"
								  target="_blank">外文医学信息资源</a></p>
						</div>
					</div>
					<!-- end colored -->
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-1.png);">
						<h3>外刊资源</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>农业知识</h3>-->
							<p><a href="http://fpd.juhe.com.cn/#g=db" target="_blank">外刊资源服务系统</a></p>
							<p><a href="http://fdts.ideahome.com.cn/#g=db" target="_blank">外文博硕论文服务系统</a></p>
							<p><a href="http://new.metstr.com/login.aspx?mode=IP&class=B1#g=db"
								  target="_blank">外文医学信息资源</a></p>
						</div>
					</div>
					<!-- end colored -->
				</div>
				<div class="data" style="display: flex;z-index: 99">
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-2.png);">
						<h3>党政信息</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>党政信息</h3>-->
							<p><a href="http://www.drcnet.com.cn/#g=library" target="_blank">国研信息网</a></p>
							<p><a href="http://www.dangjian.cnki.net/#g=library" target="_blank">中国党建期刊文献总库</a></p>
						</div>
					</div>
					<!-- end colored -->
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-3.png);">
						<h3>教育学习</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>教育与学习</h3>-->
							<p><a href="http://zjls.school.zxxk.com/#g=db" target="_blank">中学·学科网</a></p>
							<p><a href="http://qdexam.lsnetlib.com/#g=db" target="_blank">起点考试系统</a></p>
							<p><a href="http://www.yjsexam.com/" target="_blank">起点考研网</a></p>
							<p><a href="http://yx.qdexam.com/" target="_blank">起点医考网</a></p>
						</div>
					</div>
					<!-- end colored -->
					<!-- colored -->
					<div class="ih-item square colored effect15 right_to_left"
						 style="background-image :url(${staticPath }/static/lsportal1/images/bg-5.png);">
						<h3>丽水资源数据库</h3>
						<div class="img"></div>
						<div class="info">
							<!--<h3>教育与学习</h3>-->
							<p><a href="http://tjj.lishui.gov.cn/sjjw" target="_blank">丽水统计信息库</a></p>
							<p><a href="http://zjxt.lsinfo.gov.cn/" target="_blank">丽水市农业专家知识系统</a></p>
							<p><a href="http://xh30.lsnetlib.com/" target="_blank">星火30农村科技视频库</a></p>
							<p><a href="http://www.51jishu.com/techmarket/InfoSearchHandler?action=list&Type=TP"
								  target="_blank">丽水市企业技术难题库</a></p>
							<p><a href="http://www.lishui.gov.cn/ztfw/ztzl/lstk/" target="_blank">丽水图库</a></p>
							<p><a href="http://www.51jishu.com/techmarket/InfoSearchHandler?action=list&Type=AC"
								  target="_blank">高校院所信息库</a></p>
							<p><a href="http://epaper.lsnews.com.cn/lsrb/" target="_blank">丽水日报电子版</a></p>
							<p><a href="http://epaper.lsnews.com.cn/czwb/" target="_blank">处州晚报电子版</a></p>
							<p><a href="http://202.107.251.98/lsmap/" target="_blank">丽水市电子地图</a></p>
						</div>
					</div>
					<!-- end colored -->
				</div>
			</div>
			<div class="point active_item ">
				<div></div>
				<div></div>
				<div></div>
			</div>
		</div>


	</div>

	<div class="section section-3">

		<div class="kuang">

			<!--<div class="k">-->

			<!--<div class="t"><a href="">-->
			<!--<img src="image/icon-1.png" alt="查重查新"></a>-->
			<!--</div>-->
			<!--<div class="z"><a href="">-->
			<!--<span>查重查新</span></a>-->
			<!--</div>-->

			<!--</div>-->
			<div class="k">
				<div class="t"><a href="${staticPath }/forehead/triz/index">
					<img src="${staticPath }/static/lsportal1/images/TRIZ.jpg" alt="TRIZ知识组织"></a>
				</div>
				<!--<div class="z"><a href="">-->
				<!--<span>TRIZ知识组织</span></a>-->
				<!--</div>-->
			</div>
			<!--<div class="k">-->
			<!--<div class="t"><a href="">-->
			<!--<img src="image/icon-3.png" alt="主题分析报告"></a>-->
			<!--</div>-->
			<!--<div class="z"><a href="">-->
			<!--<span>主题分析报告</span></a>-->
			<!--</div>-->
			<!--</div>-->
			<!--<div class="k">-->
			<!--<div class="t"><a href="">-->
			<!--<img src="image/icon-4.png" alt="产业库"></a>-->
			<!--</div>-->
			<!--<div class="z"><a href="">-->
			<!--<span>产业库</span></a>-->
			<!--</div>-->
			<!--</div>-->
			<div class="k">
				<div class="t"><a href="${staticPath}/forehead/industry/indusrtyList" target="_blank">
					<img src="${staticPath }/static/lsportal1/images/tsk.jpg" alt="特色专题库"></a>
				</div>
				<!--<div class="z"><a href="">-->
				<!--<span>特色专题库</span></a>-->
				<!--</div>-->
			</div>
		</div>

		<div class="slide_box">
			<h1>产业库</h1>
			<div class="slide_list">
				<ul>
					<c:forEach var="fld" items="${industrys}">
						<li>
							<a href="${staticPath}/forehead/industry/selectOneInfo/${fld.id}" target="_blank">
								<img src="${staticPath}/static/lsportal/images/industry/${fld.fileName}" alt=""/>
								<h3>${fld.title}</h3>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>

	</div>

	<div class="section section-4">
		<div class="section_Box">
			<div class="three_navBox">
				<h1>通知资讯</h1>
				<ul>
					<li class="section_active" id="bt1">最新动态
                        <span style="background: linear-gradient(to top right, rgba(255, 0, 0, 0),rgba(255, 0, 0, 0), #46c7ff);"><a
                                href="${staticPath }/forehead/article/articlelist">••• </a></span>
					</li>
					<li id="bt2">每日更新
                        <span style="background: linear-gradient(to top right, rgba(255, 0, 0, 0), rgba(255, 0, 0, 0),#43ffad);"><a
                                href="${staticPath}/forehead/collect/collectlist">•••</a> </span>
					</li>
					<li id="bt3">试用资源
                        <span style="background: linear-gradient(to top right, rgba(255, 0, 0, 0),rgba(255, 0, 0, 0), #d7ff86);"><a
                                href="${staticPath}/forehead/collect/articlelist#a02">•••</a> </span>
					</li>
				</ul>
			</div>

			<div class="three_contentBox">
				<div class="three_contentItem" style="display: block">
					<ul class="thr-l" id="trends1">
					</ul>
					<ul class="thr-r" id="trends2">
					</ul>
				</div>
				<div class="three_contentItem">
					<ul class="thr-l" id="collect1">
					</ul>
					<ul class="thr-r" id="collect2">
					</ul>
				</div>
				<div class="three_contentItem">
					<ul class="thr-l">
						<li>
							<p><a class="biaoqian" href="http://qikan.cqvip.com" target="_blank">维普中文期刊服务平台</a></p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>
						<li>
							<p><a class="biaoqian" href="http://zlf.cqvip.com/index.aspx?returnUrl=" target="_blank">智立方知识资源系统</a>
							</p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>
						<li>
							<p><a class="biaoqian" href="http://www.yjsexam.com/main" target="_blank">起点考研网</a></p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>
						<li>
							<p><a class="biaoqian" href="http://yx.qdexam.com/main" target="_blank">起点医考网</a></p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>

					</ul>
					<ul class="thr-r">
						<li>
							<p><a class="biaoqian" href="http://www.digitalmechanical.com.cn" target="_blank">CIDP制造业数字资源平台</a>
							</p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>
						<li>
							<p><a class="biaoqian" href="http://www.epsnet.com.cn" target="_blank">EPS数据平台</a></p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>
						<li>
							<p><a class="biaoqian" href="http://ipub.exuezhe.com/index.html" target="_blank">中国人民大学复印报刊资料</a>
							</p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>
						<li>
							<p><a class="biaoqian" href="http://fdts.ideahome.com.cn/index.aspx" target="_blank">万文博硕士论文服务系统</a>
							</p>
							<span style="font-size: 12px;color:#888888">2018-08-08</span></li>

					</ul>
				</div>
			</div>
		</div>


		<div class="x">
			<ul class="x2">
				<li>主办单位:丽水市人民政府</li>
				<li>承办单位:丽水市科技信息中心</li>
				<li>技术支持:上海万方数据有限公司</li>
				<li>免费咨询电话: 400-889-9177</li>
				<li>COPYRIGHT ©2007 LSNETLIB.COM INCORPORATED. ALL RIGHTS RESERVED.</li>
				<li>
					<span>浙ICP备09054032号</span>
					<img src="${staticPath }/static/lsportal1/image/icon-8.png">
				</li>
			</ul>
		</div>
		<!--页脚-->

	</div>

</section>
<!--main-->
<!--右侧导航-->
<ul class="section-btn">

	<li class="on">
		<img src="${staticPath }/static/lsportal1/images/r-icon-1.png" alt="">
		<!--<p>资源搜索</p>-->
	</li>
	<li>
		<img src="${staticPath }/static/lsportal1/images/r-icon-2.png" alt="">
		<!--<p>科技服务</p>-->
	</li>

	<li>
		<img src="${staticPath }/static/lsportal1/images/r-icon-3.png" alt="">
		<!--<p>公告公示</p>-->
	</li>

	<li>
		<img src="${staticPath }/static/lsportal1/images/r-icon-4.png" alt="">
		<!--<p>资源列表</p>-->
	</li>
	<!--<li>-->
	<!--<img src="${staticPath }/static/lsportal1/images/r-icon-5.png" alt="">-->
	<!--&lt;!&ndash;<p>资源列表</p>&ndash;&gt;-->
	<!--</li>-->

</ul>
<!--右侧导航结束-->
<div class="QQ">
	<a href="http://shang.qq.com/email/stop/email_stop.html?qq=1263242541&sig=da6a77f7c367c2bd1296169be40fe2c945c37a7b33685afc&tttt=1"
	   target="_blank"><img src="${staticPath }/static/lsportal1/images/r-icon-5.png" alt=""></a>
</div>
<!--下翻页-->
<div class="arrow">&laquo;</div>
<!--下翻页-->
<script src="js/main-1.js"></script>
<!-- Resource jQuery --/>
<!--第四屏逻辑js代码开始-->
<script>
    $(function () {
        $(".section_Box").on('click', '.three_navBox li', function () {
            console.log($(this).index());
            $(this).addClass('section_active');
            $(this).siblings().removeClass('section_active');
            $('.three_contentItem').eq($(this).index()).css({display: 'block'});
            $('.three_contentItem').eq($(this).index()).siblings().css({display: 'none'})
        });
        $(".four_contentBox").on('click', '.active_item div', function () {
            console.log($(this).index());
            $('.contentBox .data').eq($(this).index()).css({display: 'flex'});
            $('.contentBox .data').eq($(this).index()).siblings().css({display: 'none'})
        })
    })
</script>
<!--第四屏逻辑js代码结束-->
<!--鼠标滚轮时间js代码开始-->
<script type="text/javascript">

    //此处引用：鼠标滚轮mousewheel插件
    !function (a) {
        "function" == typeof define && define.amd ? define(["jquery"], a) : "object" == typeof exports ? module.exports = a : a(jQuery)
    }(function (a) {
        function b(b) {
            var g = b || window.event, h = i.call(arguments, 1), j = 0, l = 0, m = 0, n = 0, o = 0, p = 0;
            if (b = a.event.fix(g), b.type = "mousewheel", "detail" in g && (m = -1 * g.detail), "wheelDelta" in g && (m = g.wheelDelta), "wheelDeltaY" in g && (m = g.wheelDeltaY), "wheelDeltaX" in g && (l = -1 * g.wheelDeltaX), "axis" in g && g.axis === g.HORIZONTAL_AXIS && (l = -1 * m, m = 0), j = 0 === m ? l : m, "deltaY" in g && (m = -1 * g.deltaY, j = m), "deltaX" in g && (l = g.deltaX, 0 === m && (j = -1 * l)), 0 !== m || 0 !== l) {
                if (1 === g.deltaMode) {
                    var q = a.data(this, "mousewheel-line-height");
                    j *= q, m *= q, l *= q
                } else if (2 === g.deltaMode) {
                    var r = a.data(this, "mousewheel-page-height");
                    j *= r, m *= r, l *= r
                }
                if (n = Math.max(Math.abs(m), Math.abs(l)), (!f || f > n) && (f = n, d(g, n) && (f /= 40)), d(g, n) && (j /= 40, l /= 40, m /= 40), j = Math[j >= 1 ? "floor" : "ceil"](j / f), l = Math[l >= 1 ? "floor" : "ceil"](l / f), m = Math[m >= 1 ? "floor" : "ceil"](m / f), k.settings.normalizeOffset && this.getBoundingClientRect) {
                    var s = this.getBoundingClientRect();
                    o = b.clientX - s.left, p = b.clientY - s.top
                }
                return b.deltaX = l, b.deltaY = m, b.deltaFactor = f, b.offsetX = o, b.offsetY = p, b.deltaMode = 0, h.unshift(b, j, l, m), e && clearTimeout(e), e = setTimeout(c, 200), (a.event.dispatch || a.event.handle).apply(this, h)
            }
        }

        function c() {
            f = null
        }

        function d(a, b) {
            return k.settings.adjustOldDeltas && "mousewheel" === a.type && b % 120 === 0
        }

        var e, f, g = ["wheel", "mousewheel", "DOMMouseScroll", "MozMousePixelScroll"],
            h = "onwheel" in document || document.documentMode >= 9 ? ["wheel"] : ["mousewheel", "DomMouseScroll", "MozMousePixelScroll"],
            i = Array.prototype.slice;
        if (a.event.fixHooks) for (var j = g.length; j;) a.event.fixHooks[g[--j]] = a.event.mouseHooks;
        var k = a.event.special.mousewheel = {
            version: "3.1.12", setup: function () {
                if (this.addEventListener) for (var c = h.length; c;) this.addEventListener(h[--c], b, !1); else this.onmousewheel = b;
                a.data(this, "mousewheel-line-height", k.getLineHeight(this)), a.data(this, "mousewheel-page-height", k.getPageHeight(this))
            }, teardown: function () {
                if (this.removeEventListener) for (var c = h.length; c;) this.removeEventListener(h[--c], b, !1); else this.onmousewheel = null;
                a.removeData(this, "mousewheel-line-height"), a.removeData(this, "mousewheel-page-height")
            }, getLineHeight: function (b) {
                var c = a(b), d = c["offsetParent" in a.fn ? "offsetParent" : "parent"]();
                return d.length || (d = a("body")), parseInt(d.css("fontSize"), 10) || parseInt(c.css("fontSize"), 10) || 16
            }, getPageHeight: function (b) {
                return a(b).height()
            }, settings: {adjustOldDeltas: !0, normalizeOffset: !0}
        };
        a.fn.extend({
            mousewheel: function (a) {
                return a ? this.bind("mousewheel", a) : this.trigger("mousewheel")
            }, unmousewheel: function (a) {
                return this.unbind("mousewheel", a)
            }
        })
    });

    $(function () {
        var i = 0;
        var $btn = $('.section-btn li'),

            $wrap = $('.section-wrap'),

            $arrow = $('.arrow');
		/*当前页面赋值*/
        function up() {
            i++;
            if (i == $btn.length) {
                i = 0
            }
            ;
        }

        function down() {
            i--;
            if (i < 0) {
                i = $btn.length - 1
            }
            ;
        }

		/*页面滑动*/
        function run() {
            $btn.eq(i).addClass('on').siblings().removeClass('on');
            $wrap.attr("class", "section-wrap").addClass(function () {
                return "put-section-" + i;
            }).find('.section').eq(i).find('.title').addClass('active');

            if (i >= 1) {
                $("#izl_rmenu").data("expanded", true);
                $("#izl_rmenu .btn-top").slideDown();
            } else {
                $("#izl_rmenu").data("expanded", false);
                $("#izl_rmenu .btn-top").slideUp();
            }
        };
		/*右侧按钮点击*/
        $btn.each(function (index) {
            $(this).click(function () {
                i = index;
                run();
            })

        });

		/*翻页按钮点击*/
        $arrow.one('click', go);
        function go() {
            up();
            run();
            setTimeout(function () {
                $arrow.one('click', go)
            }, 1000)

        };
        $('body').on('click', '.btn-top', function () {

            $btn[0].click(function () {
                i = 1;
                run();
            })

        })


		/*响应鼠标*/
        $wrap.one('mousewheel', mouse_);
        function mouse_(event) {
            if (event.deltaY < 0) {
                up()
            }
            else {
                down()
            }
            run();
            setTimeout(function () {
                $wrap.one('mousewheel', mouse_)
            }, 1000)
        };

		/*响应键盘上下键*/

        $(document).one('keydown', k);
        function k(event) {
            var e = event || window.event;
            var key = e.keyCode || e.which || e.charCode;
            switch (key) {
                case 38:
                    down();
                    run();
                    break;
                case 40:
                    up();
                    run();
                    break;
            }
            ;
            setTimeout(function () {
                $(document).one('keydown', k)
            }, 1000);
        }
    });

</script>
<!--鼠标滚轮时间js代码结束-->
<!--search Start-->
<script>
    //洄图检索
    function lslibSearch() {
        var val = document.getElementById('txtKeyWord').value;
        var sid = $("#sid").val();
        sessionStorage.setItem("indName", "123");
        var searchUrl = "http://2018.lsnetlib.com:7007/search?&sid=" + sid + "&q=";
        searchUrl = searchUrl + encodeURI(document.getElementById("txtKeyWord").value);
        window.open(searchUrl);
    }

    function logout() {
        layer.confirm('确定要退出?', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.post(basePath + '/logout', function (result) {
                //result = $.parseJSON(result);
                //if(result.success){
                window.location.href = '${staticPath }/forehead/index';
                //}
            }, 'text');
        }, function () {

        });
    }

    $(function () {
//		type 1 --通知资讯
        $.post(basePath + '/forehead/article/topTenData', {
            "title": "",
            "type": 1,
            "nowpage": 1,
            "pageSize": 10,
            "sort": "create_time",
            "order": "desc"
        }, function (result) {
            result = eval('(' + result + ')');
            var data = result.rows;
            $.each(result.rows, function (i, item) {
                var htmll = "";
                var htmlr = "";
                $.each(result.rows, function (i, item) {
                    if (i < 5) {
                        htmll += '<li><p><a class="biaoqian" href="${path }/forehead/article/detail?id=' + item.id + '">' + (i + 1) + '、' + item.title + '</a></p><span style="font-size: 12px;color:#888888">' + item.createTime.substr(0, 10) + '</span></li>';
                    } else {
                        htmlr += '<li><p><a class="biaoqian" href="${path }/forehead/article/detail?id=' + item.id + '">' + (i + 1) + '、' + item.title + '</a></p><span style="font-size: 12px;color:#888888">' + item.createTime.substr(0, 10) + '</span></li>';
                    }
                });
                $("#news1").append(htmll);
                $("#news2").append(htmlr);
            });
        });
//       type 2 --最新动态
        $.post(basePath + '/forehead/article/topTenData', {
            "title": "",
            "type": 2,
            "nowpage": 1,
            "pageSize": 10,
            "sort": "create_time",
            "order": "desc"
        }, function (result) {
            result = eval('(' + result + ')');
            var data = result.rows;
            var htmll = "";
            var htmlr = "";
            $.each(result.rows, function (i, item) {
                if (i < 5) {
                    htmll += '<li><p><a class="biaoqian" href="${path }/forehead/article/detail?id=' + item.id + '">' + (i + 1) + '、' + item.title + '</a></p><span style="font-size: 12px;color:#888888">' + item.createTime.substr(0, 10) + '</span></li>';
                } else {
                    htmlr += '<li><p><a class="biaoqian" href="${path }/forehead/article/detail?id=' + item.id + '">' + (i + 1) + '、' + item.title + '</a></p><span style="font-size: 12px;color:#888888">' + item.createTime.substr(0, 10) + '</span></li>';
                }
            });
            $("#trends1").append(htmll);
            $("#trends2").append(htmlr);
        });
        //每日更新
        $.post(basePath + '/forehead/collect/topTenData', {
            "title": "",
            "nowpage": 1,
            "pageSize": 10,
            "sort": "collect_time",
            "order": "desc"
        }, function (result) {
            result = eval('(' + result + ')');
            var data = result.rows;
            var htmll = "";
            var htmlr = "";
            $.each(result.rows, function (i, item) {
                if (i < 5) {
                    htmll += '<li><p><a class="biaoqian" href="' + item.url + '" target="_blank">' + (i + 1) + '、' + item.title + '</a></p><span style="font-size: 12px;color:#888888">' + item.collectTime.substr(0, 10) + '</span></li>';
                } else {
                    htmlr += '<li><p><a class="biaoqian" href="' + item.url + '" target="_blank">' + (i + 1) + '、' + item.title + '</a></p><span style="font-size: 12px;color:#888888">' + item.collectTime.substr(0, 10) + '</span></li>';
                }
            });
            $("#collect1").append(htmll);
            $("#collect2").append(htmlr);
        });
    });
    layui.use(['form'], function () {
        var form = layui.form, layer = layui.layer;
    });

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
                window.location.href = basePath + '/forehead/index';
            } else {
                // 刷新验证码
                $("#captcha")[0].click();
                layer.msg(result.msg);
            }
        }
    });

    // 注册
    $('#registform').form({
        url: basePath + '/add',
        onSubmit: function () {
            var isValid = $(this).form('validate');
            return isValid;
        },
        success: function (result) {
            result = $.parseJSON(result);
            if (result.success) {
                layer.msg("注册成功，请登录");
                window.location.href = basePath + '/forehead/index';
            } else {
                // 刷新验证码
                $("#regcaptcha")[0].click();
                layer.msg(result.msg);
            }
        }
    });

    // 验证码
    $("#captcha").click(function () {
        var $this = $(this);
        var url = $this.data("src") + new Date().getTime();
        $this.attr("src", url);
    });
    $("#regcaptcha").click(function () {
        var $this = $(this);
        var url = $this.data("src") + new Date().getTime();
        $this.attr("src", url);
    });
</script>
<!--search End-->
</body>
<%
	String id = request.getSession().getId();
%>
<input type="hidden" id="sid" value="<%=id%>"/>
</html>