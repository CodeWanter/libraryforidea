<%@ page language="java" 
	pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp"%>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
	  	<legend>新建关系数据库资源</legend>
		<form class="layui-form" id="industryCreateResourceForm" method="post" enctype="multipart/form-data">
		  <div class="layui-form-item">
		    <label class="layui-form-label">库名：</label>
		    <div class="layui-input-block">
		      <input name="resName" lay-verify="required" autocomplete="off" placeholder="请输入库名" class="layui-input" type="text">
		    </div>
		  </div>
	      <div class="layui-form-item">
		    <label class="layui-form-label">表名：</label>
		    <div class="layui-input-block">
		      <input name="resTblName" lay-verify="required" placeholder="请输入表名" autocomplete="off" class="layui-input" type="text">
		    </div>
		  </div>
	      <div class="layui-form-item">
		    <label class="layui-form-label">描述：</label>
		    <div class="layui-input-block">
		      <input name="resDesc" lay-verify="required" placeholder="请输入描述" autocomplete="off" class="layui-input" type="text">
		    </div>
		  </div>
		</form>
	</div>
</div>
<script>
	$(function() {
		$('#industryCreateResourceForm').form({
			url : '${path}/industry/createResource',
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
					//产业库自建库信息添加成功，就跳到自建库表的添加字段页面
					addFld();
				} else {
					var form = $('#industryCreateResourceForm');
					parent.$.messager.alert('错误', eval(result.msg), 'error');
				}
			}
		});
	});
    function addFld() {
        parent.$.modalDialog({
            title : '添加表字段',
            width : 900,
            height : 600,
            href : '${path}/industry/addFldPage',
            buttons : [ {
                text : '完成',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = industryDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                }
            } ]
        });
    }
</script>