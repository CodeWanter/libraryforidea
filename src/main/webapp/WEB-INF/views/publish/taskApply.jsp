<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$('#resourceId').combotree({
	        url : '${path }/category/tree',
	        parentField : 'pid',
	        panelHeight : 'auto'
	    });
		$('#libId').combotree({
	        url : '${path }/organization/topTree',
	        parentField : 'pid',
	        panelHeight : 'auto'
	    });

	});
</script>
<div title="资源发布">
	<div style="padding-left: 200px;padding-top: 20px; width: 600px">
	    <form id="publishTaskForm" action="${path }/publish/publishTask" method="post" enctype="multipart/form-data">
	    	<table class="grid" align="center">
	    		<tr>
	    			<td style="font-size:14px;">发布编号:</td>
	    			<td><input type="text" id="batchCode" name="batchCode" value="${publishId}"></input></td>
	    		</tr>
	    		<tr>
	    			<td style="font-size:14px;">资源描述:</td>
	    			<td><input id="publishDesc" name="batchDesc" style="height:80px;width: 180px"></input></td>
	    		</tr>
	    		<tr>
	    			<td style="font-size:14px;">资源类别:</td>
	    			<td style="font-size:14px;">
	    				<select id="resourceId" name="resourceId" class="easyui-combobox" data-options="width:180,height:29,panelHeight:'auto'" data-options="required:true">
	    				</select>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td style="font-size:14px;">资源来源:</td>
	    			<td>
	    				<select id="libId" name="libId" class="easyui-combobox" data-options="width:180,height:29,editable:false,panelHeight:'auto'" data-options="required:true">
	    				</select>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td style="font-size:14px;">元数据:</td>
	    			<td>
	    				<input type="file" name="attachment" id="attachment">
	    			</td>
	    		</tr>
	    		<tr>
	    			<td></td>
	    			<td>
	    				<input type="file" name="attachment" id="attachment">
	    			</td>
	    		</tr>
	    		<tr>
	    			<td><input type="submit" value="提交"></td>
	    			<td>
	    				<input type="reset" value="重置">
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	</div>
</div>