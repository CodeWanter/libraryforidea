<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<link rel="stylesheet"
	href="${staticPath }/static/js/kindeditor/themes/default/default.css" />
<link rel="stylesheet"
	href="${staticPath }/static/js/kindeditor/plugins/code/prettify.css" />
<script charset="utf-8"
	src="${staticPath }/static/js/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
	src="${staticPath }/static/js/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript">
	//KindEditor脚本
	var keditor;
	$(function() {
        $("#industryEditAuditing").val('${industryEach.auditing}');
        $("#industryEditType").val('${industryEach.type}');
        $("#industryEditTitle").val('${industryEach.title}');
        $("#kindeditor").val('${industryEach.content}');
		kedit("kindeditor");
		$('#eachEditForm').form({
			url : '${path}/industryEach/edit',
			onSubmit : function(param) {
				param.content =  keditor.html();
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
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					var form = $('#eachEditForm');
					parent.$.messager.alert('错误',result.msg, 'error');
				}
			}
		});
	});
	function kedit(keid) {
		keditor = KindEditor.create('#' + keid, {
			themeType : 'simple',//风格
			width : '800px',//设置宽度
			height : '400px',//设置高度
			autoHeightMode : true,//自动高度调整
			cssData : 'body {font-family: "微软雅黑"; font-size: 14px}', //修改字体
			allowPreviewEmoticons : false,
			allowFileManager : true,//true时显示图片上传按钮。默认值: true
			allowImageUpload : true,
			uploadJson : '${staticPath }/editor/fileUpload',
			fileManagerJson : '${staticPath }/editor/fileManager',//指定浏览远程图片的服务器端程序
		});
	};
</script>
	
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
		<form id="eachEditForm" method="post" enctype="multipart/form-data">
			<input type="input" hidden="hidden" name="id" value="${industryEach.id}">
	        <table class="grid">
                <tr>
                    <td>题名:</td>
                    <td><input id="industryEditTitle" name="title" type="text" placeholder="请输入登录名称" class="easyui-validatebox" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>审核:</td>
                    <td>
            	        <select id="industryEditAuditing" name="auditing" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
      	                    <option value="1" selected="selected">通过</option>
                            <option value="0" >不通过</option>
                        </select>
                    </td>
                </tr>
                <tr>
                	<td>种类:</td>
                    <td>
                        <select id="industryEditType" name="type" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0" selected="selected">期刊</option>
                            <option value="1" >论文</option>
                            <option value="2" >专利</option>
                            <option value="3" >项目信息</option>
                            <option value="4" >咨询</option>
                            <option value="5" >科技成果</option>
                        </select>
                    </td>
                </tr>
                <tr>
					<td>内容:</td>
					<td><br /> <textarea name="kindeditor" id="kindeditor" class="xt_textarea"></textarea> <br/></td>
				</tr>
            </table>
		</form>
	</div>
</div>
