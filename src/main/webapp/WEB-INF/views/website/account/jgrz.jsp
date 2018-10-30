<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>企业入驻</title>
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
			当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>企业入驻申请
		</div>

		<div class="LS2018_Aleft" style="width:510px;">
			<form method="post" id="jgrzform" class="layui-form">
				<input type="hidden" name="showFields" value="orgName,contactName,contactTel,contactEmail,orgCode,businessLicense,orgIntro" />
				<input type="hidden" name="pubflag" value="0" />
				<div class="layui-form-item">
					<label class="layui-form-label">机构名称:</label>
					<div class="layui-input-block">
						<input type="text" id="orgName" name="orgName"
							   lay-verify="orgName" autocomplete="off"
							   placeholder="请输入机构名称" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">机构联系人:</label>
					<div class="layui-input-block">
						<input type="text" id="contactName" name="contactName"
							   lay-verify="required|contactName" autocomplete="off"
							   placeholder="请输入联系人姓名" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">联系人电话:</label>
					<div class="layui-input-block">
						<input type="text" id="contactTel" name="contactTel"
							   lay-verify="required|phone" autocomplete="off"
							   placeholder="请输入联系人电话" class="layui-input">
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">联系人Email:</label>
					<div class="layui-input-block">
						<input type="text" id="contactEmail" name="contactEmail"
							   lay-verify="required|email" autocomplete="off"
							   placeholder="请输入联系人Email" class="layui-input">
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">机构代码:</label>
					<div class="layui-input-block">
						<input type="text" id="orgCode" name="orgCode"
							   lay-verify="orgCode" autocomplete="off"
							   placeholder="请输入机构代码" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">机构介绍:</label>
					<div class="layui-input-block">
						<textarea  id="orgIntro" name="orgIntro"
							   lay-verify="orgIntro" autocomplete="off"
							   placeholder="请输入机构介绍" class="layui-textarea"></textarea>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">营业执照:</label>
					<div class="layui-input-block">
						<input type="file" name="businessLicenseFile" id="businessLicenseFile"
						lay-verify="required|businessLicenseFile" autocomplete="off"
						placeholder="请上传机构营业执照pdf/word" class="layui-input" />
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">验证码:</label>
					<div class="layui-input-block">
						<P style="padding: 10px 0px 10px; position: relative;">
							<input class="captcha layui-input" type="text" name="captcha" id="yzm"
								   placeholder="请输入验证码" /> </br><img id="captcha" alt="验证码"
																src="${path }/captcha.jpg" data-src="${path }/captcha.jpg?t="
																style="vertical-align: middle; border-radius: 4px; width: 94.5px; height: 35px; cursor: pointer;">
						</P>
					</div>
				</div>
				<hr class="layui-bg-red">
				<div class="layui-form-item">
					<div class="layui-input-block">
						<label for="accept-terms">我已阅读并同意 <a href="${staticPath }/static/html/protocol.html" target="_blank" id="xieyi" style="text-decoration-line: underline;">用户协议</a></label>
						<div style="display: inline-block;vertical-align: middle;margin-top: -10px;">
						<input type="checkbox" id="accept-terms" name="acceptprotocol" lay-skin="switch" lay-text="ON|OFF" lay-filter="acceptFilter">
							</div>
						<%--<input type="checkbox" lay-skin="primary">--%>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit="" lay-filter="demo1"
						>注册</button>
					</div>
				</div>
			</form>
		</div>

		<div class="LS2018_Aright" style="width: 400px;margin-top: 80px;">
			<img src="${path }/static/lsportal/image/New_login_back.png"/>
		</div>
	</div>
	<%@ include file="/commons/footer.jsp" %>
</div>
</div>


</body>
<script type="text/javascript"
	src="${staticPath }/static/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
	var acceptFlag = false;
	layui.use([ 'form' ], function() {
		var form = layui.form, layer = layui.layer;
		//自定义验证规则
		form.verify({
			orgName : function(value) {
				if (value.length < 5) {
					return '机构名称至少6个字符';
				}
               
				if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
                    return '机构名称不能有特殊字符';
				}
                if(/(^\_)|(\__)|(\_+$)/.test(value)){
                    return '机构名称名首尾不能出现下划线\'_\'';
                }
                if(/^\d+\d+\d$/.test(value)){
                    return '机构名称不能全为数字';
                }
			}
		
		});
		
		form.on('switch(acceptFilter)', function(data){
			acceptFlag = this.checked ? 'true' : 'false'
		  });
	});

	
	
	// 注册
	$('#jgrzform').form({
		url : basePath + '/forehead/intermedOrg/save',
		onSubmit : function(param) {
            
			var isValid = $(this).form('validate');
			if (!isValid) {
				progressClose();
			}
			
			if(!checkFileType()){
				isValid=false;
			}
			var inputYzm = $("#yzm").val();
			if(inputYzm=null||inputYzm==''){
				isValid=false;
				layer.tips("请输入验证码！",
						"#yzm",
						{
							time:3000
						});
			}
			//判断是否同意须知
			if(!acceptFlag){
				isValid=false;
				layer.tips("请阅读用户协议！",
							"#xieyi",
							{
								time:3000
							});
			}
			
			return isValid;
		},
		success : function(result) {
			result = $.parseJSON(result);
			if (result.success) {
                layer.msg("申请成功，请等待审核通知！");
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
	//验证上传文件类型
	function checkFileType(){
		var fileName = $("#businessLicenseFile").val();
		
		if (fileName.lastIndexOf('.')==-1){    //如果不存在"."  
            layer.alert("路径不正确!");
            return false;
        }
        var AllImgExt=".jpg|.jpeg|.png|.pdf|.doc|.docx|";
        var extName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();//（把路径中的所有字母全部转换为小写）        
        if(AllImgExt.indexOf(extName+"|")==-1)        
        {
            ErrMsg="该文件类型不允许上传。请上传 "+AllImgExt+" 类型的文件，当前文件类型为"+extName;
            layer.alert(ErrMsg);
            return false;
        }
		return true;
	}
	
</script>
</html>