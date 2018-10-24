<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/themes/default/default.css"/>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/plugins/code/prettify.css"/>
<div style="width: 100%">
    <div style="padding: 10px 20px 10px 20px">
        <form id="importPolicyScForm" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td><a href="${staticPath }/static/lsportal/file/lawSc.xls" style="color: #00b2ff">样例下载</a></td>
                </tr>
                <tr>
                    <td><br/><input name="upexcelfile" data-options="required:true" class="easyui-filebox"
                                    data-options="prompt:'Choose a file...'"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script charset="utf-8"
        src="${staticPath }/static/js/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
        src="${staticPath }/static/js/kindeditor/lang/zh_CN.js"></script>
<script>
    $(function () {
        $('#importPolicyScForm').form({
            url: '${path }/scpolicyback/excelUpload',
            onSubmit: function (param) {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success: function (result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#importPolicyScForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });
</script>