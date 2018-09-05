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
					//产业库图片和标题名添加成功，就跳到自建库表的创建页
					createResource();
				} else {
					var form = $('#industryForm');
					parent.$.messager.alert('错误', eval(result.msg), 'error');
				}
			}
		});
	});
	
    function createResource() {
        parent.$.modalDialog({
            title : '新建关系数据库资源',
            width : 900,
            height : 600,
            href : '${path}/industry/resource',
            buttons : [ {
                text : '新建',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = industryDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#industryCreateResourceForm');
                    f.submit();
                }
            } ]
        });
    }
</script>