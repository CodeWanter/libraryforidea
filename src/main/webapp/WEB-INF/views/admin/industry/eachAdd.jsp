<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script charset="utf-8"
	src="${staticPath }/static/js/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
	src="${staticPath }/static/js/kindeditor/lang/zh_CN.js"></script>
<link rel="stylesheet"
	href="${staticPath }/static/js/kindeditor/themes/default/default.css" />
<link rel="stylesheet"
	href="${staticPath }/static/js/kindeditor/plugins/code/prettify.css" />
<script type="text/javascript">
    $(function() {
        $('#industryAddOrganizationId').combotree({
            url : '${path}/industry/tree',
            panelHeight : 'auto'
        });
    });
</script>
<div style="width: 100%">
	<div style="padding: 10px 20px 10px 20px">
        <form id="eachAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>题名:</td>
                    <td><input name="title" type="text" placeholder="请输入题名" class="easyui-validatebox" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>库名:</td>
                    <td>
            	        <select id="industryAddOrganizationId" name="tableName" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        </select>
                    </td>
                </tr>
                <tr>
                	<td>种类:</td>
                    <td>
                        <select name="type" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="2" >专利</option>
                            <option value="3" selected="selected">项目信息</option>
                            <option value="4" >资讯</option>
                            <option value="5" >科技成果</option>
                        </select>
                    </td>
                </tr>
                <tr>
					<td>内容:</td>
					<td><br /> <textarea name="kindeditor" id="kindeditor" class="xt_textarea"></textarea> <br/></td>
				</tr>
            </table>
        </form>
    </div>
</div>
<script>
	//KindEditor脚本
	var keditor;
	$(function() {
		kedit("kindeditor");
		$('#eachAddForm').form({
			url : '${path}/industryEach/save',
			onSubmit : function(param) {
				param.content =  keditor.html();
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
					var form = $('#eachAddForm');
					parent.$.messager.alert('错误',result.msg, 'error');
				}
			}
		});
	});
	function kedit(keid) {
		keditor = KindEditor.create('#' + keid, {
			themeType : 'simple',//风格
			width : '800px',//设置宽度
			height : '400px',//设置高度
			autoHeightMode : true,//自动高度调整
			cssData : 'body {font-family: "微软雅黑"; font-size: 14px}', //修改字体
			allowPreviewEmoticons : false,
			allowFileManager : true,//true时显示图片上传按钮。默认值: true
			allowImageUpload : true,
			uploadJson : '${staticPath }/editor/fileUpload',
			fileManagerJson : '${staticPath }/editor/fileManager',//指定浏览远程图片的服务器端程序
		});
	};
</script>