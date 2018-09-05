<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册</title>
<%@ include file="/commons/basejs.jsp"%>
	<title>用户注册</title>
	<link rel="stylesheet" type="text/css"
	href="${staticPath }/static/js/layui/css/layui.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css" />
</head>
<body class="LS2018_body">
<div class="LS2018_main">
	<%@ include file="/commons/head.jsp" %>
	<div class="LS2018_bd Z_clearfix">
		<div class="LS2018_MBX">
			当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>用户注册
		</div>

			<form method="post" id="registform" class="layui-form">
				<input type="hidden" name="userType" value="1" />
				<input type="hidden" name="status" value="0" />
				<input type="hidden" name="roleIds" value="" />
				<input type="hidden" name="name" value="" />
				<div class="layui-form-item">
					<div class="layui-inline">
					<label class="layui-form-label">用户名:</label>
					<div class="layui-input-inline">
						<input type="text" id="loginName" name="loginName"
							   lay-verify="loginName" autocomplete="off"
							   placeholder="请输入用户名" class="layui-input">
					</div>
					</div>
					<div class="layui-inline">
					<label class="layui-form-label">姓名:</label>
					<div class="layui-input-inline">
						<input type="text" id="name" name="name"
							   lay-verify="name" autocomplete="off"
							   placeholder="请输入姓名" class="layui-input">
					</div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-inline">
					<label class="layui-form-label">密 码：</label>
					<div class="layui-input-inline">
						<input type="password" id="password" name="password"
							   lay-verify="password" lay-verify="title" autocomplete="off"
							   placeholder="请输入密码" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">确认密码：</label>
					<div class="layui-input-inline">
						<input type="password" id="comfimPassword"
							   lay-verify="comfimPassword" lay-verify="title" autocomplete="off"
							   placeholder="请输入密码" class="layui-input">
					</div>
				</div>

				</div>
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">Email:</label>
					<div class="layui-input-inline">
						<input type="text" id="email" name="email"
							   lay-verify="email" autocomplete="off"
							   placeholder="请输入Email" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">行业:</label>
					<div class="layui-input-inline">
						<input type="text" id="industry" name="industry"
							   lay-verify="industry" autocomplete="off"
							   placeholder="请输入行业" class="layui-input">
					</div>
				</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-inline">
					<label class="layui-form-label">学历:</label>
					<div class="layui-input-inline">
						<input type="text" id="education" name="education"
							   lay-verify="education" autocomplete="off"
							   placeholder="请输入学历" class="layui-input">
					</div>
					</div>
					<div class="layui-inline">
					<label class="layui-form-label">职称:</label>
					<div class="layui-input-inline">
						<input type="text" id="professor" name="professor"
							   lay-verify="professor" autocomplete="off"
							   placeholder="请输入职称" class="layui-input">
					</div>
					</div>
				</div>
				<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">验证码:</label>
					<div class="layui-input-inline">
						<P style="padding: 10px 0px 10px; position: relative;">
							<input class="captcha layui-input" type="text" name="captcha"
								   placeholder="请输入验证码" />
						</P>
					</div>
				</div>
						<div class="layui-inline">
							<img id="captcha" alt="验证码"
																			 src="${path }/captcha.jpg" data-src="${path }/captcha.jpg?t="
																			 style="vertical-align: middle; border-radius: 4px; width: 94.5px; height: 35px; cursor: pointer;">
								</P>
							</div>
						</div>
				<div class="layui-form-item">
					<div class="layui-input-inline center">
						<button class="layui-btn" lay-submit="" lay-filter="demo1"
						>注册</button>
					</div>
				</div>
			</form>
	</div>
	<%@ include file="/commons/footer.jsp" %>
</div>
</div>


</body>
<script type="text/javascript"
	src="${staticPath }/static/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
	layui.use([ 'form' ], function() {
		var form = layui.form, layer = layui.layer;

		//自定义验证规则
		form.verify({
			loginName : function(value) {
				if (value.length < 5) {
					return '用户名至少6个字符';
				}
			},
			password : [ /(.+){4,12}$/, '密码必须4到12位' ]
		});
	});
	
	// 注册
	$('#registform').form({
		url : basePath + '/add',
		onSubmit : function() {
			var isValid = $(this).form('validate');
			if (!isValid) {
				progressClose();
			}
			return isValid;
		},
		success : function(result) {
			result = $.parseJSON(result);
			if (result.success) {
				window.location.href = basePath + '/forehead/index';
			} else {
				alert(result.msg);
				// 刷新验证码
				$("#captcha")[0].click();
				layer.msg(result.msg);
			}
		}
	});

	// 验证码
	$("#captcha").click(function() {
		var $this = $(this);
		var url = $this.data("src") + new Date().getTime();
		$this.attr("src", url);
	});
</script>
</html>