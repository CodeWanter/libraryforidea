<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册</title>
<%@ include file="/commons/basejs.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${staticPath }/static/js/layui/css/layui.css" />
</head>
<body>
<form method="post" id="registform" class="layui-form">
	<input type="hidden" name="userType" value="1" />
				<input type="hidden" name="status" value="0" />
				<input type="hidden" name="roleIds" value="" />
		<div class="layui-form-item">
			<label class="layui-form-label">用户名:</label>
			<div class="layui-input-block">
				<input type="text" id="loginName" name="loginName"
					lay-verify="loginName" autocomplete="off"
					placeholder="请输入用户名" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">姓名:</label>
			<div class="layui-input-block">
				<input type="text" id="name" name="name"
					lay-verify="name" autocomplete="off"
					placeholder="请输入姓名" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密 码：</label>
			<div class="layui-input-block">
				<input type="password" id="password" name="password"
					lay-verify="password" lay-verify="title" autocomplete="off"
					placeholder="请输入密码" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码：</label>
			<div class="layui-input-block">
				<input type="password" id="comfimPassword" 
					lay-verify="comfimPassword" lay-verify="title" autocomplete="off"
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
					>注册</button>
			</div>
		</div>
	</form>
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