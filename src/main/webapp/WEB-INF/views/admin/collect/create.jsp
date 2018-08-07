<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
		<form id="collectForm" method="post">
			<table>
				<tr>
					<td>标题:</td>
					<td><input class="easyui-textbox" type="text" name="title"
						id="title" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>Url:</td>
					<td><input class="easyui-textbox" type="text" name="url"
									  id="url" data-options="required:true"></input></td>
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
					<td><select class="easyui-combobox" name="orignForm" id="orignForm">
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
		$('#collectForm').form({
			url : '${path }/collectback/save',
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
					var form = $('#collectForm');
					parent.$.messager.alert('错误', eval(result.msg), 'error');
				}
			}
		});
	});
</script>