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
		<form id="industryEditForm" method="post" enctype="multipart/form-data">
			<input type="hidden" value="${industry.id}" name="id" />
			<table class="in_table">
				<tr>
					<td>产业库名称:</td>
					<td><input class="easyui-textbox" type="text" name="title"
						id="title" data-options="required:true" value="${industry.title}"></input></td>
				</tr>
				<tr>
					<td>产业库图片:</td>
					<td>
						<input name="pic" value="${industry.fileName}"  data-options="required:true" class="easyui-filebox" data-options="prompt:'Choose a file...'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<script>
	$(function() {
		$('#industryEditForm').form({
			url : '${path}/industry/edit',
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
					var form = $('#industryEditForm');
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>