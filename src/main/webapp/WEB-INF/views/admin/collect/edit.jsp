<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
		<form id="collectEditForm" method="post">
			<input type="hidden" value="${collect.id }" name="id" />
			<table>
				<tr>
					<td>标题:</td>
					<td><input class="easyui-textbox" type="text" name="title"
						id="title" data-options="required:true" value="${collect.title}"></input></td>
				</tr>
				<tr>
					<td>Url:</td>
					<td><input class="easyui-textbox" type="text" name="url"
							   id="url" data-options="required:true" value="${collect.url}"></input></td>
				</tr>
				<tr>
					<td>是否显示:</td>
					<td><select class="easyui-combobox" name="isShow" id="isShow">
						<option value="0">启用</option>
						<option value="1">禁止</option>
					</select></td>
				</tr>
				<tr>
					<td>来源:</td>
					<td><select class="easyui-combobox" name="orignFrom" id="orignFrom">
						<option value="超星">超星</option>
						<option value="乐听">乐听</option>
					</select></td>
				</tr>
			</table>
		</form>
	</div>
</div>
<script>

	$(function() {
        document.getElementById("isShow").value = "${collect.isShow }";
        document.getElementById("orignFrom").value = "${collect.orignForm }";
		$('#collectEditForm').form({
			url : '${path }/collectback/edit',
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
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');
					parent.$.modalDialog.handler.dialog('close');
				} else {
					var form = $('#collectEditForm');
					parent.$.messager.alert('错误', eval(result.msg), 'error');
				}
			}
		});
	});
</script>