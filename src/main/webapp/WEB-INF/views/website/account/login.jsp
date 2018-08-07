<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<%@ include file="/commons/basejs.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${staticPath }/static/js/layui/css/layui.css" />
<script type="text/javascript"
	src="${staticPath }/static/js/layui/layui.js" charset="utf-8"></script>
</head>
<body>
	<form method="post" id="loginform" class="layui-form">
		<div class="layui-form-item">
			<label class="layui-form-label">用户名:</label>
			<div class="layui-input-block">
				<input type="text" id="username" name="username"
					lay-verify="loginName" autocomplete="off"
					placeholder="请输入用户名" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密 码：</label>
			<div class="layui-input-block">
				<input type="password" id="password" name="password"
					lay-verify="pass" autocomplete="off"
					placeholder="请输入密码" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<P style="padding: 10px 0px 10px; position: relative;">
					<input class="captcha" type="text" name="captcha"
						placeholder="请输入验证码" /> <img id="captcha" alt="验证码"
						src="${path }/captcha.jpg" data-src="${path }/captcha.jpg?t="
						style="vertical-align: middle; border-radius: 4px; width: 94.5px; height: 35px; cursor: pointer;">
				</P>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="demo1"
					>登录</button>
			</div>
		</div>
	</form>
</body>
</html>
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
			pass : [ /(.+){4,12}$/, '密码必须4到12位' ]
		});
	});

	// 登录
	$('#loginform').form({
		url : basePath + '/login',
		onSubmit : function() {
			progressLoad();
			var isValid = $(this).form('validate');
			if (!isValid) {
				progressClose();
			}
			return isValid;
		},
		success : function(result) {
			progressClose();
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

	// 验证码
	$("#captcha").click(function() {
		var $this = $(this);
		var url = $this.data("src") + new Date().getTime();
		$this.attr("src", url);
	});
</script>