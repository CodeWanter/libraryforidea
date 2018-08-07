<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
		<form id="linkEditForm" method="post">
			<input type="hidden" value="${link.id }" name="id" />
			<table>
				<tr>
					<td>链接名称:</td>
					<td><input class="easyui-textbox" type="text" name="linkName"
						id="linkName" data-options="required:true" value="${link.linkName}"></input></td>
				</tr>

				<tr>
					<td>链接URL:</td>
					<td><br /> <input class="easyui-textbox" type="text" name="linkUrl"
									  id="linkUrl" data-options="required:true" value="${link.linkUrl}"></input><br /></td>
				</tr>
				<tr>
					<td>是否开启:</td>
					<td><select class="easyui-combobox type" name="linkStatus"
						id="linkStatus">
						<option value="0">开启</option>
						<option value="1">禁用</option>
					</select></td>
				</tr>
			</table>
		</form>
	</div>
</div>
<script>
	$(function() {
		document.getElementById("linkStatus").value = "${link.linkStatus }";
		$('#linkEditForm').form({
			url : '${path }/linkback/edit',
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
					var form = $('#linkEditForm');
					parent.$.messager.alert('错误', eval(result.msg), 'error');
				}
			}
		});
	});
</script>