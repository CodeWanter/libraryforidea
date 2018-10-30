<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>机构中心</title>
	<link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css"/>
    <link rel="stylesheet" href="${staticPath }/static/js/pagination_zh/lib/pagination.css" />
	<script charset="utf-8"	src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>

    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/newresourse.js"></script>
	<script charset="utf-8"	src="${staticPath }/static/lsportal/js/personal/mysc.js"></script>
    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/myrecomend.js"></script>
	<script charset="utf-8"	src="${staticPath }/static/lsportal/js/personal/myorder.js"></script>
	<script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/mydeliver.js"></script>
	
	<script type="text/javascript">
		
		$("#centreID").trigger("click");
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
					servicePageInit();
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
                    //最新资源修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#ZXZY").addClass("current");
                    //将body中其他模块不显示，只显示我的收藏的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#newResource").css({display: 'inline'});
                    newResourseInit();
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
		//编辑
		function edit(){
			var sss = confirm('重新编辑机构信息后需要再次进行审核，您确定要编辑吗？');
			if(sss){
				$("#editOrgForm input[disabled='disabled']").removeAttr("disabled");
				$("#orgIntro").removeAttr("disabled");
				$("#shzt").hide()
				$("#bjbt").hide();
				$("#yyzzsc").show();
				$("#bcbt").show();
			}
			
		}
		function update(){
			var load = layer.load();
			$.ajax({
				type: "post",
				url: '${path }/intermedOrg/update',
				data:$("#editOrgForm").serialize(),
				
	            success: function (result) {
	            	layer.close(load);
	                result = eval("("+result+")");
	                
	                if (result.success) {
	                	layer.msg(result.msg)
	                } else {
	                	layer.msg(result.msg);
	                }
	                window.location.reload();
	            }
			 });
		}
		
		var servicePage=1;
		var servicePageSize = 10;
		var orgId = "";
		function servicePageInit(){
			orgId = $("#orgId").val();
			servicePaginationInit(servicePage, servicePageSize);
		}
		function servicePaginationInit(servicePage, servicePageSize) {
		    $.get("${path }/orgService/myService?page=" + servicePage + "&rows=" + servicePageSize + "&orgId="+ orgId +"&sort=createTime&order=desc",
		    		{}, 
				    function (data) {
				        data = JSON.parse(data);
				        var total = data.total;
				        if (data.total > 100) {
				            total = 100;
				        }
				        $("#RecomendPagination").pagination(total, {
				            num_edge_entries: 2, //边缘页数
				            num_display_entries: 10, //主体页数
				            callback: servicePaginationCallback, //回调函数
				            items_per_page: servicePageSize, //每页显示多少项
				            prev_text: "<<上一页",
				            next_text: "下一页>>"
		
				        });
				    }
		   	);
		}
		function servicePaginationCallback(servicePage, jq){
			var index;
		    $.ajax({
		        type: "post",
		        url: "${path }/orgService/myService?page=" + servicePage + 1 + "&pageSize=" + servicePageSize + "&orgId="+ orgId +"&sort=createTime&order=desc",
		        dataType: "json",
		        async: true,
		        beforeSend: function () {
		            index = layer.load(1);
		        },
		        complete: function () {
		            layer.close(index);
		        },
		        success: function (result) {
		        	result = JSON.parse(result);
		            //result = result.rows;
		            alert(result);
		            $("#recomendList").html("");
		            $.each(result, function (i, item) {
		                var html = "";
		                html += '<li><div class="aa"><a href="" target="_blank">' + item.serviceName + '</a></div>';
		                html += '<div class="txt"><label><span class="t1">时间：</span>' + item.pubflag + '</label><label><span class="t1">来源：</span>' + item.createtime + '</label></div>';
		               
		                html += '</li>';
		                $("#recomendList").append(html);
		            });
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            layer.msg('检索异常!');
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

<body class="LS2018_body" onload="select($('#centreID'));">
	<div class="LS2018_main">
		<%@ include file="/commons/head.jsp" %>
		<div class="LS2018_bd Z_clearfix">
			<div class="LS2018_MBX">
				当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>机构中心
			</div>
			<div class="LS2018_GRZX2 Z_clearfix">
				<div class="LS2018_Aleft">
                    
					<div class="LS2018_GRZX_lefttop">机构中心</div>
					<ul class="LS2018_GRZX_left_list" id="personCentreID">
                        
						<li><span>机构设置</span>
							<ul>
                                <li><a id="centreID" value="机构资料" onclick="select(this);" class="current"
                                       style="cursor: pointer;">机构资料</a></li>
								<li><a id="pswEditID" value="密码修改" onclick="select(this);" style="cursor: pointer;">密码修改</a></li>
							</ul>
						</li>
						<li><a id="dYID" value="我的服务" onclick="select(this);" style="cursor: pointer;">我的服务</a></li>
						
					</ul>
				</div>
                <div class="LS2018_Aright" id="newResource" style="display: none;">
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
                <div class="LS2018_Aright" id="centreDIVID" style="display: inline;">
					<div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 机构资料</h2></span>
						<span style="float:right;margin-right: 10px;">
						</span>
					</div>
					<form method="post" id="editOrgForm" class="layui-form">
						<input type="hidden" name="id" id="orgId" value="${intermedOrg.id}"/>
						<input type="hidden" name="pubflag" id="pubflag" value="0"/>
					<table class="LS2018_GRZX_TB1">
						<tr>
							<td class="td1" style="width: 150px;">机构名称：</td>
							<td><input type="text" id="orgName" name="orgName" value="${intermedOrg.orgName}" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="td1">机构联系人：</td>
							<td><input placeholder="请输入姓名" type="text" id="contactName" name="contactName" value="${intermedOrg.contactName}"  disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="td1">联系人电话：</td>
							<td><input placeholder="请输入联系人电话" lay-verify="required|phone" type="text" id="contactTel" name="contactTel"  value="${intermedOrg.contactTel}" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="td1">联系人email：</td>
							<td><input placeholder="请输入联系人email" lay-verify="required|email" type="text" id="contactEmail" name="contactEmail" value="${intermedOrg.contactEmail}" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="td1">机构代码：</td>
							<td><input placeholder="请输入机构代码" type="text" id="orgCode" name="orgCode" value="${intermedOrg.orgCode}" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td class="td1">机构介绍：</td>
							<td><textarea placeholder="请输入机构介绍" type="text" id="orgIntro" name="orgIntro" disabled="disabled"
									style="width: 349px; height: 117px;resize: none;">${intermedOrg.orgIntro}
								</textarea>
							</td>
						</tr>
						<tr>
							<td class="td1">营业执照：</td>
							<td>
								<c:if test="${intermedOrg.businessLicense!=null && intermedOrg.businessLicense!=''}">
									<a href="${intermedOrg.businessLicense}" download="" >查看已上传营业执照</a>
								</c:if>
								<input type="hidden" name="businessLicense" id="businessLicense" value="${intermedOrg.businessLicense}"/>
								
								<input type="file" id="yyzzsc" name="businessLicenseFile" disabled="disabled" style="display:none;"/>
							</td>
						</tr>
						
						
					</table>
					<div class="LS2018_GRZX_btns">
						<span id="shzt">
						<c:if test="${intermedOrg.pubflag=='0'}">
							<input class="btn1" type="button" value="未审核" style="background:#d2cd1e;"/>
						</c:if>
						<c:if test="${intermedOrg.pubflag=='1'}">
							<input class="btn1" type="button" value="已审核" style="background:#0cb247;"/>
						</c:if>
						<c:if test="${intermedOrg.pubflag=='2'}">
							<input class="btn1" type="button" value="审核不通过" style="background: #d21e1ee0;"/>
						</c:if>
						</span>
						<input class="btn1" type="button" value="编 辑" onclick="edit();" id="bjbt"/>
						<input class="btn2" type="button" value="保 存" onclick="update()" style="display:none;" id="bcbt"/>
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
						<span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 我的服务</h2></span>
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
<%
	String id = request.getSession().getId();
%>
<input type="hidden" id="sid" value="<%=id%>"/>
</body>
</html>
<script type="text/javascript">
	
    
	
    layui.use([ 'layer', 'form'], function() {
        var form = layui.form
            ,layer = layui.layer;
        //自定义验证规则
        form.verify({
            
        });
		

        
    });
</script>