<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>个人中心</title>
	<link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css"/>
    <link rel="stylesheet" href="${staticPath }/static/js/pagination_zh/lib/pagination.css" />
	<script charset="utf-8"	src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>

	<script charset="utf-8"	src="${staticPath }/static/lsportal/js/personal/mysc.js"></script>
    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/myrecomend.js"></script>
	<script charset="utf-8"	src="${staticPath }/static/lsportal/js/personal/myorder.js"></script>
	<script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/mydeliver.js"></script>
	<script charset="utf-8" src="${staticPath }/static/js/tagcloud.js"></script>
	<script type="text/javascript">
		function select(sel) {
			if ($("#personCentreID .current").html() != sel.value) {
				if (sel.id == "centreID") {
					//个人资料选中状态
					$("#personCentreID .current").removeClass("current");
					$("#centreID").addClass("current");
					//将body中其他模块不显示，只显示个人资料的模块
					$(".LS2018_Aright").css({display: 'none'});
					$("#centreDIVID").css({display: 'inline'});

				} else if(sel.id == "pswEditID"){
					//密码修改选中状态
					$("#personCentreID .current").removeClass("current");
					$("#pswEditID").addClass("current");
					//将body中其他模块不显示，只显示密码修改的模块
					$(".LS2018_Aright").css({display: 'none'});
					$("#pswEditDIVID").css({display: 'inline'});
				} else if(sel.id == "dYID"){
					//我的订阅修改选中状态
					$("#personCentreID .current").removeClass("current");
					$("#dYID").addClass("current");
					//将body中其他模块不显示，只显示我的订阅的模块
					$(".LS2018_Aright").css({display: 'none'});
					$("#dYDIVID").css({display: 'inline'});
                    personalOrderInit();
				} else if(sel.id == "tJID"){
					//我的推荐修改选中状态
					$("#personCentreID .current").removeClass("current");
					$("#tJID").addClass("current");
					//将body中其他模块不显示，只显示我的推荐的模块
					$(".LS2018_Aright").css({display: 'none'});
					$("#tJDIVID").css({display: 'inline'});
                    personalRecommendInit();
				} else if(sel.id == "sCID"){
					//我的收藏修改选中状态
					$("#personCentreID .current").removeClass("current");
					$("#sCID").addClass("current");
					//将body中其他模块不显示，只显示我的收藏的模块
					$(".LS2018_Aright").css({display: 'none'});
					$("#sCDIVID").css({display: 'inline'});
					personalScInit();
                } else if (sel.id == "dCID") {
                    //我的收藏修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#dCID").addClass("current");
                    //将body中其他模块不显示，只显示我的收藏的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#dCDIVID").css({display: 'inline'});
                    personalDeliverInit();
                } else if (sel.id == "ZXZY") {
                    //我的收藏修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#ZXZY").addClass("current");
                    //将body中其他模块不显示，只显示我的收藏的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#newResource").css({display: 'inline'});
                    personalDeliverInit();
                }
			}
		}
		//修改个人资料
		function centre(){
			var logName = $("#centreLogNameID").val(); 
			var name = $("#centreNameID").val(); 
			var sex = $("#centreSexID option:selected").val();
			var age = $("#centreAgeID").val();
            var phone = $("#centrePhoneID").val();
            var email = $("#email").val();
            var industry = $("#industry1 option:selected").val()+"/"+$("#industry2 option:selected").val();
            var education = $("#educate option:selected").val();
            var professor = $("#professor").val();

            console.log(logName+","+name+","+sex+","+age+","+phone);
		    $.ajax({
		        type: "post",
		        url : '${path}/forehead/personal/centerEdit',
		        data: {"logName":logName,"name":name,"sex":sex,"age": age, "phone": phone, "email": email, "industry": industry, "education": education, "professor": professor},
		        async: true,
                dataType:"json",
	            success : function(result) {
                    if (result.success) {
                        layer.msg(result.msg);
                    }else{
                        layer.msg(result.msg);
                        <%--layer.msg(result.msg,function(){--%>
                            <%--window.location.href="${path}/";--%>
                        <%--});--%>
                    }
	            }
		    });
		}
		//修改密码
	    function pswEdit() {
	    	var oldPwd = $("[name='oldPwd']").val(); 
	    	var pwd = $("[name='pwd']").val(); 
	    	var rePwd = $("[name='rePwd']").val();
            if (oldPwd == "") {
                layer.msg("原密码不能为空!");
                return;
            }
	    	if (pwd == "") {
	    		layer.msg("新密码不能为空!");
				return;
			}
	    	if (pwd != rePwd) {
	    		if (pwd != "" && rePwd != "") {
		    		layer.msg("两次密码输入不一致!");
					return;
				}else if (pwd != "" && rePwd == ""){
					layer.msg("请再次输入新密码!");
					return;
				}else if (pwd == "" && rePwd != ""){
					layer.msg("请输入新密码!");
					return;
				}
			}
	    	if (pwd == oldPwd) {
	    		layer.msg("原密码和新密码相同！");
				return;
			}
	    	$.ajax({
	            type: "post",
	            url : '${path}/user/editUserPwd',
	            data: {"oldPwd": oldPwd,"pwd": pwd},
	            async: true,
	            success : function(result) {
	                result = $.parseJSON(result);
	                if (result.success) {
	                	 layer.msg(result.msg);
	                	 $("[name='oldPwd']").val("");
	                	 $("[name='pwd']").val("");
	                	 $("[name='rePwd']").val("");
	                }else{
	                	 layer.msg(result.msg);
	                }
	            }
	        });
		}
	</script>	
	<style type="text/css">
		input[type="password"] {
		    border: 1px #B3BDD0 solid;
		    border-radius: 2px;
		    width: 350px;
		    height: 40px;
		    padding: 0 5px;
		    font-size: 15px;
		}

        em {
            font-style: normal;
        }

		.tagcloud {
			position: relative;
			margin-top: 35px;
		}

		.tagcloud a {
			position: absolute;
			top: 0;
			left: 0;
			display: block;
            padding: 6px 15px;
            color: #333;
            /* font-size:16px; */
            border: 1px solid #e6e7e8;
            border-radius: 18px;
            background-color: #f2f4f8;
			text-decoration: none;
			white-space: nowrap;
			-o-box-shadow: 6px 4px 8px 0 rgba(151, 142, 136, .34);
			-ms-box-shadow: 6px 4px 8px 0 rgba(151, 142, 136, .34);
			-moz-box-shadow: 6px 4px 8px 0 rgba(151, 142, 136, .34);
			-webkit-box-shadow: 6px 4px 8px 0 rgba(151, 142, 136, .34);
			box-shadow: 6px 4px 8px 0 rgba(151, 142, 136, .34);
			-ms-filter: "progid:DXImageTransform.Microsoft.Shadow(Strength=4,Direction=135, Color='#000000')"; /*兼容ie7/8*/
			filter: progid:DXImageTransform.Microsoft.Shadow(color='#969696', Direction=125, Strength=9);
			/*strength是阴影大小，direction是阴影方位，单位为度，可以为负数，color是阴影颜色 （尽量使用数字）使用IE滤镜实现盒子阴影的盒子必须是行元素或以行元素显示（block或inline-block;）*/
		}

		.tagcloud a:hover {
			color: #3385cf;
		}
	</style>
</head>

<body class="LS2018_body">
	<div class="LS2018_main">
		<%@ include file="/commons/head.jsp" %>
		<div class="LS2018_bd Z_clearfix">
			<div class="LS2018_MBX">
				当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>个人中心
			</div>
			<div class="LS2018_GRZX2 Z_clearfix">
				<div class="LS2018_Aleft">
                    <div class="LS2018_GRZX_lefttop">热门检索词</div>
					<div class="LS2018_Cloud">
						<div class="main">
							<div class="tagcloud fl" id="tagcloud">

							</div>
						</div>
					</div>
					<div class="LS2018_GRZX_lefttop">个人中心</div>
					<ul class="LS2018_GRZX_left_list" id="personCentreID">
                        <li><a id="ZXZY" class="current" value="最新资源" onclick="select(this);" style="cursor: pointer;">最新资源</a>
                        </li>
						<li><span>账户设置</span>
							<ul>
                                <li><a id="centreID" value="个人资料" onclick="select(this);"
                                       style="cursor: pointer;">个人资料</a></li>
								<li><a id="pswEditID" value="密码修改" onclick="select(this);" style="cursor: pointer;">密码修改</a></li>
							</ul>
						</li>
						<li><a id="dYID" value="我的订阅" onclick="select(this);" style="cursor: pointer;">我的订阅</a></li>
						<li><a id="tJID" value="我的推荐" onclick="select(this);" style="cursor: pointer;">我的推荐</a></li>
						<li><a id="sCID" value="我的收藏" onclick="select(this);" style="cursor: pointer;">我的收藏</a></li>
						<li><a id="dCID" value="原文传递" onclick="select(this);" style="cursor: pointer;">原文传递</a></li>
					</ul>
				</div>
                <div class="LS2018_Aright" id="newResource" style="display: inline;">
                    <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                        <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 最新资源</h2></span>
                        <span style="float:right;margin-right: 10px;">
						</span>
                    </div>
                    <ul class="LS2018_List2" id="newResourceId">
                        数据整合中……
                    </ul>
                    <div id="newRPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
                </div>
				<%--个人资料--%>
                <div class="LS2018_Aright" id="centreDIVID" style="display: none;">
					<div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 个人资料</h2></span>
						<span style="float:right;margin-right: 10px;">
						</span>
					</div>
					<form method="post" id="registform" class="layui-form">
					<table class="LS2018_GRZX_TB1">
						<tr>
							<td class="td1" style="width: 150px;">用户名：</td>
							<td><input type="text" id="centreLogNameID" disabled="disabled" <c:if test="${not empty user.loginName}">value="${user.loginName}"</c:if>/>
							</td>
						</tr>
						<tr>
							<td class="td1">姓名：</td>
							<td><input placeholder="请输入姓名" type="text" id="centreNameID" <c:if test="${not empty user.name}">value="${user.name}"</c:if>/>
							</td>
						</tr>
						<tr>
							<td class="td1">性别：</td>
							<td>
								<div class="layui-input-inline">
								<select style="width: 80px" id="centreSexID">
									<c:if test="${not empty user.sex}">
										<c:if test="${user.sex == 0}"><option selected="selected" value="0">男</option><option value="1">女</option></c:if>
										<c:if test="${user.sex == 1}"><option selected="selected" value="1">女</option><option value="0">男</option></c:if>
									</c:if>
								</select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="td1">年龄：</td>
							<td><input type="text" id="centreAgeID" <c:if test="${not empty user.age}">value="${user.age}"</c:if>/>
							</td>
						</tr>
						<tr>
							<td class="td1">电话：</td>
							<td><input type="text" id="centrePhoneID" <c:if test="${not empty user.phone}">value="${user.phone}"</c:if>/>
							</td>
						</tr>
						<tr>
							<td class="td1">Emial：</td>
							<td>
								<input type="text" id="email" lay-verify="required|phone"  autocomplete="off" class="layui-input" <c:if test="${not empty user.email}">value="${user.email}"</c:if>/>
							</td>
						</tr>
						<tr>
							<td class="td1">基础行业：</td>
							<td>
								<div class="layui-input-inline">
								<input type="hidden" value="${user.industry}" id="industry"/>
									<select name="industry1" lay-verify="industry1" lay-filter="industry" id="industry1" class="industry1" lay-search>
										<option value="">请选择行业</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="td1">详细行业：</td>
							<td>
								<div class="layui-input-inline">
									<select name="industry2" id="industry2" lay-verify="industry2" lay-search>
										<option value="">请选择详细行业</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="td1">学历：</td>
							<td>
								<input type="hidden" value="${user.education}" id="education"/>
								<div class="layui-input-inline">
									<select name="education" id="educate">
										<option value="" selected="">请选择学历</option>
										<option value="小学">小学</option>
										<option value="中学">中学</option>
										<option value="高级中学">高级中学</option>
										<option value="专科">专科</option>
										<option value="本科">本科</option>
										<option value="硕士研究生">硕士研究生</option>
										<option value="博士研究生">博士研究生</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="td1">职称：</td>
							<td><input type="text" id="professor" <c:if test="${not empty user.professor}">value="${user.professor}"</c:if>/>
							</td>
						</tr>
					</table>
					<div class="LS2018_GRZX_btns">
						<input class="btn1" type="button" value="确 定" onclick="centre();"/>
						<input class="btn2" type="button" value="取 消" onclick="history.go('-1');"/>
					</div>
					</form>
				</div>
				<!-- 密码修改 -->
				<div class="LS2018_Aright" id="pswEditDIVID" style="display: none;">
					<div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 密码修改</h2></span>
						<span style="float:right;margin-right: 10px;">
						</span>
					</div>
					<table class="LS2018_GRZX_TB1">
						<tr>
							<td class="td1" style="width: 150px;">用户名：</td>
							<td><input type="text" disabled="disabled" value="<shiro:principal></shiro:principal>"/></td>
						</tr>
						<tr>
							<td class="td1">原密码：</td>
							<td><input type="password" name="oldPwd" value="" placeholder="请输入原密码" data-options="required:true"/></td>
						</tr>
						<tr>
							<td class="td1">新密码：</td>
							<td><input type="password" name="pwd" value="" placeholder="请输入新密码" data-options="required:true"/></td>
						</tr>
						<tr>
							<td class="td1">确认密码：</td>
							<td><input type="password" name="rePwd" value="" placeholder="请再次输入新密码" data-options="required:true"/></td>
						</tr>
					</table>
					
					<div class="LS2018_GRZX_btns">
						<input class="btn1" type="button" value="确 定" onclick="pswEdit();"/>
						<input class="btn2" type="button" value="取 消" onclick="history.go('-1');"/>
					</div>
				</div>
				<!-- 我的订阅 -->
				<div class="LS2018_Aright" id="dYDIVID" style="display: none;">
					<div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 我的订阅</h2></span>
						<span style="float:right;margin-right: 10px;">
						名称
						<select id="defineNameID" onchange="personalOrder('defineName',this)">
							<option value="asc">升序</option>
							<option value="desc">降序</option>
						</select>
						时间
						<select id="createTimeID" onchange="personalOrder('createTime',this)">
							<option value="desc">降序</option>
							<option value="asc">升序</option>
						</select>
					</span></div>
					<ul class="LS2018_List2" id="personalOrderId">
					</ul>
					<div id="OrderPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
				</div>
				<!-- 我的推荐 -->
				<div class="LS2018_Aright" id="tJDIVID" style="display: none;">
					<div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 我的推荐</h2></span>
						<span style="float:right;margin-right: 10px;">
						</span>
					</div>
					<ul class="LS2018_List2" id="recomendList">
					</ul>
                    <div id="RecomendPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
				</div>
				<!-- 我的收藏 -->
				<div class="LS2018_Aright" id="sCDIVID" style="display: none;">
					<div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 我的收藏</h2></span>
						<span style="float:right;margin-right: 10px;">
							标题
					<select id="titleSelectID" onchange="personalSC('title',this)">
						<option value="desc">降序</option>
						<option value="asc">升序</option>
					</select>
					作者
					<select id="authorSelectID" onchange="personalSC('author',this)">
						<option value="desc">降序</option>
						<option value="asc">升序</option>
					</select>
					时间
					<select id="timeSelectID" onchange="personalSC('time',this)">
						<option value="desc">降序</option>
						<option value="asc">升序</option>
					</select>
						</span>
					</div>
					<ul class="LS2018_List2" id="personalSCId">
					</ul>
					<div id="Pagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
				</div>
				<%--原文传递--%>
				<div class="LS2018_Aright" id="dCDIVID" style="display: none;">
					<div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 原文传递</h2></span>
						<span style="float:right;margin-right: 10px;">
						</span>
					</div>
					<ul class="LS2018_List2" id="personalDeliverId">
					</ul>
					<div id="DeliverPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
				</div>
			</div>
		</div>
		<%@ include file="/commons/footer.jsp" %>
	</div>
</body>
</html>
<script type="text/javascript">
    $.ajax({
        type: "get",
        url: "${staticPath }/forehead/keyword/getTopSixKeyWordLog",
        dataType: "json",
        async: false,
        success: function (result) {
            $.each(result, function (i, item) {
                $("#tagcloud").append("<a href='http://2018.lsnetlib.com:7007/search?source=baidu&q=" + item + "&returnFilter=true' target='_blank'>" + item + "</a>")
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg('加载异常!');
        }
    });
	/*3D标签云*/
    tagcloud({
        selector: "#tagcloud",  //元素选择器
        fontsize: 8,       //基本字体大小, 单位px
        radius: 40,         //滚动半径, 单位px
        mspeed: "normal",   //滚动最大速度, 取值: slow, normal(默认), fast
        ispeed: "normal",   //滚动初速度, 取值: slow, normal(默认), fast
        direction: 135,     //初始滚动方向, 取值角度(顺时针360): 0对应top, 90对应left, 135对应right-bottom(默认)...
        keep: false          //鼠标移出组件后是否继续随鼠标滚动, 取值: false, true(默认) 对应 减速至初速度滚动, 随鼠标滚动
    });
    layui.use([ 'layer', 'form'], function() {
        var form = layui.form
            ,layer = layui.layer;
        //自定义验证规则
        form.verify({
            industry1:function (value) {
                if(value=="")
                    return '请选择基础行业！';
            },
            industry2:function (value) {
                if(value=="")
                    return '请选择详细行业！';
            }
        });
		if($("#education").val()!=""){
            var select = 'dd[lay-value=' +$("#education").val() + ']';
            $('select[name=education]').siblings("div.layui-form-select").find('dl').find(select).click();
		}

        var industry = $("#industry").val().split('/');
        $.get("${staticPath }/static/lsportal/json/industry.json", function (data) {
            data= JSON.parse(data);
            var proHtml = '';
            for (var i = 0; i < data.length; i++) {
                proHtml += '<option value="' + data[i].industry + '">' + data[i].industry + '</option>';
            }
            //初始化省数据
            $("select[name=industry1]").append(proHtml);
            form.render();
            if(industry[0]!=""){
                var select = 'dd[lay-value=' + industry[0] + ']';
                $('select[name=industry1]').siblings("div.layui-form-select").find('dl').find(select).click();
			}
        })
        form.on('select(industry)', function(data){
            $("select[name=industry2]").empty();
            form.render();
            $.get("${staticPath }/static/lsportal/json/industry.json", function (msg) {
                msg= JSON.parse(msg);
                var cityHtml = '';
                cityHtml += '<option value="">请选择详细行业</option>';
                for (var i = 0; i < msg.length; i++) {
                    if(msg[i].industry==data.value){
                        for (var j = 0; j < msg[i].city.length; j++) {
                            cityHtml += '<option value="' + msg[i].city[j].city_name + '">' + msg[i].city[j].city_name + '</option>';
                        }
                        break;
                    }
                }
                //初始化省数据
                $("select[name=industry2]").append(cityHtml);
                form.render();
                if(industry[1]!="") {
                    var select = 'dd[lay-value=' + industry[1] + ']';
                    $('select[name=industry2]').siblings("div.layui-form-select").find('dl').find(select).click();
                }
            })
        });
    });
</script>