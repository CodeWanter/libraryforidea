<%@ page language="java" 
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
		<form id="industryForm" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>产业库名称:</td>
					<td><input class="easyui-textbox" type="text" name="title"
						id="title" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>产业库图片:</td>
					<td><br/>
			   	 		<input type="file" name="pic">
					<br/></td>
				</tr>
				<tr>
					<td>库名：</td>
					<td><br/>
				    	<input name="resName" lay-verify="required" autocomplete="off" placeholder="请输入库名" class="layui-input" type="text">
					<br/></td>
				</tr>
					<td>表名：</td>
					<td><br/>
				    	<input name="resTblName" lay-verify="required" placeholder="请输入表名" autocomplete="off" class="layui-input" type="text">
					<br/></td>
				</tr>
					<td>描述：</td>
					<td><br/>
				    	<input name="resDesc" lay-verify="required" placeholder="请输入描述" autocomplete="off" class="layui-input" type="text">
					<br/></td>
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