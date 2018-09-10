<%@ page language="java" 
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<style type="text/css">
	.in_table tr{
		line-height:45px;
	}
	.in_table tr input{
		width: 250px;
	}
</style>
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
		<form id="industryForm" method="post" enctype="multipart/form-data">
			<table class="in_table">
				<tr>
					<td>产业库名称:</td>
					<td><input class="easyui-textbox" type="text" name="title"
						id="title" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>产业库图片:</td>
					<td>
						<input name="pic" data-options="required:true" class="easyui-filebox" data-options="prompt:'Choose a file...'">
						</td>
				</tr>
				<tr>
					<td>描述：</td>
					<td>
				    	<input name="infomation" lay-verify="required" placeholder="请输入描述" autocomplete="off" class="layui-input" type="text">
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<script>
	$(function() {
		$('#industryForm').form({
			url : '${path}/industry/save',
			onSubmit : function(param) {
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
					var form = $('#industryForm');
					console.log(result);
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>