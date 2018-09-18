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
				}
			}
		}
	</script>
	<script type="text/javascript">
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
	</style>
</head>
<body class="LS2018_body">
	<div class="LS2018_main">
		<%@ include file="/commons/head.jsp" %>
		<div class="LS2018_bd Z_clearfix">
			<div class="LS2018_MBX">
				当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>个人中心
			</div>
			<div class="LS2018_GRZX Z_clearfix">
				<div class="LS2018_Aleft">
					<div class="LS2018_GRZX_lefttop">个人中心</div>
					<ul class="LS2018_GRZX_left_list" id="personCentreID">
						<li><span>账户设置</span>
							<ul>
								<li><a class="current" id="centreID" value="个人资料" onclick="select(this);" style="cursor: pointer;">个人资料</a></li>
								<li><a id="pswEditID" value="密码修改" onclick="select(this);" style="cursor: pointer;">密码修改</a></li>
							</ul>
						</li>
						<li><a id="dYID" value="我的订阅" onclick="select(this);" style="cursor: pointer;">我的订阅</a></li>
						<li><a id="tJID" value="我的推荐" onclick="select(this);" style="cursor: pointer;">我的推荐</a></li>
						<li><a id="sCID" value="我的收藏" onclick="select(this);" style="cursor: pointer;">我的收藏</a></li>
					</ul>
				</div>
				<%--个人资料--%>
				<div class="LS2018_Aright" id="centreDIVID" style="display: inline;">
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
					<table class="LS2018_GRZX_TB2" >
						<tr>
							<th style="width: 170px">名称
								<select id="defineNameID" onchange="personalOrder('defineName',this)">
									<option value="asc">升序</option>
									<option value="desc">降序</option>
								</select>
							</th>
							<th style="width: 100px">时间
								<select id="createTimeID" onchange="personalOrder('createTime',this)">
									<option value="desc">降序</option>
									<option value="asc">升序</option>
								</select>
							</th>
							<th>摘要</th>
							<th style="width: 100px">操作</th>
						</tr>
						<tbody id="personalOrderId"></tbody>
					</table>
					<div id="OrderPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
				</div>
				<!-- 我的推荐 -->
				<div class="LS2018_Aright" id="tJDIVID" style="display: none;">
					<table class="LS2018_GRZX_TB2">
						<tr>
							<th style="width: 170px">标题
							</th>
							<th style="width: 90px">时间
							</th>
							<th style="min-width: 120px;">来源</th>
							<th>摘要</th>
						</tr>

                        <tbody id="recomendList"></tbody>
					</table>
                    <div id="RecomendPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
				</div>
				<!-- 我的收藏 -->
				<div class="LS2018_Aright" id="sCDIVID" style="display: none;">
					<table class="LS2018_GRZX_TB2" id="personalSCId">
						<tr>
							<th style="width: 150px">标题
								<select id="titleSelectID" onchange="personalSC('title',this)">
									<option value="desc">降序</option>
									<option value="asc">升序</option>
								</select>
							</th>
							<th style="width: 90px">作者
								<select id="authorSelectID" onchange="personalSC('author',this)">
									<option value="desc">降序</option>
									<option value="asc">升序</option>
								</select>
							</th>
							<th style="width: 90px">时间
								<select id="timeSelectID" onchange="personalSC('time',this)">
									<option value="desc">降序</option>
									<option value="asc">升序</option>
								</select>
							</th>
							<th style="width: 110px">来源</th>
							<th>摘要</th>
							<th style="width: 50px"></th>
						</tr>
					</table>
					<div id="Pagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
				</div>
			</div>
		</div>
		<%@ include file="/commons/footer.jsp" %>
	</div>
</body>
</html>
<script type="text/javascript">
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