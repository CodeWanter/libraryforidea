<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<link rel="stylesheet"
	href="${staticPath }/static/js/kindeditor/themes/default/default.css" />
<link rel="stylesheet"
	href="${staticPath }/static/js/kindeditor/plugins/code/prettify.css" />
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
		<form id="industryEditForm" method="post">
			<input type="hidden" value="${industry.id}" name="id" />
			<table>
				<tr>
					<td>产业库名称:</td>
					<td><input class="easyui-textbox" type="text" name="title"
						id="title" data-options="required:true" value="${article.title}"></input></td>
				</tr>

				<tr>
					<td>产业库图片:</td>
					<td><br /><input type="file"><br/></td>
				</tr>
			</table>
		</form>
	</div>
</div>
