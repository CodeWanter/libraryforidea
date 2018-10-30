<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/themes/default/default.css"/>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/plugins/code/prettify.css"/>
<div style="width: 100%">
    <div style="padding: 10px 20px 10px 20px">
        <form id="intermedEditForm" method="post">
            <input type="hidden" value="${intermedOrg.id }" name="id"/>
            <table>
                <tr>
                    <td>机构名称:</td>
                    <td><input class="easyui-textbox" type="text" name=orgName
                               id="orgName" data-options="required:true" value="${intermedOrg.orgName}"></input>
                    </td>
                	<td>
                    	<select class="easyui-combobox" name="showFields" id="orgNameSet">
                    		<option value="orgName">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                
                <tr>
                    <td>机构联系人:</td>
                    <td><input class="easyui-textbox" type="text" name="contactName"
                               id="contactName" data-options="required:true" value="${intermedOrg.contactName}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="contactNameSet">
                    		<option value="contactName">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
				<tr>
                    <td>联系电话:</td>
                    <td><input class="easyui-textbox" type="text" name="contactTel"
                               id="contactTel" data-options="required:true" value="${intermedOrg.contactTel}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="contactTelSet">
                    		<option value="contactTel">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>联系邮箱:</td>
                    <td><input class="easyui-textbox" type="text" name="contactEmail"
                               id="contactEmail" data-options="required:true" value="${intermedOrg.contactEmail}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="contactEmailSet">
                    		<option value="contactEmail">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>机构代码:</td>
                    <td><input class="easyui-textbox" type="text" name="orgCode"
                               id="orgCode" data-options="required:true" value="${intermedOrg.orgCode}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="orgCodeSet">
                    		<option value="orgCode">显示</option>
                        	<option value="" selected="selected" >禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>营业执照:</td>
                    <td>
                    	<c:if test="${intermedOrg.businessLicense != null && intermedOrg.businessLicense != ''}">
                    		<a target="_blank" download="" href="${intermedOrg.businessLicense}" style="color: #00b2ff;" >机构营业执照下载</a>
                    		<input type="hidden" name="businessLicense" value="${intermedOrg.businessLicense}"/>
                    	</c:if>
                    	<input name="businessLicenseFile" class="easyui-filebox"
                                    data-options="prompt:'Choose a file...'">
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="businessLicenseSet">
                    		<option value="businessLicense">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>机构介绍:</td>
                    <td><br/> <textarea name="kindeditor" id="kindeditor"
                                        class="xt_textarea">${intermedOrg.orgIntro }</textarea><br/>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="orgIntroSet" >
                    		<option value="orgIntro">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>审核:</td>
                    <td><select class="easyui-combobox type" name="pubflag"
                                id="pubflag">
                        <option value="1">通过</option>
                        <option value="2">不通过</option>
                    </select></td>
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
    //KindEditor脚本
    var keditor;
    $(function () {
        kedit("kindeditor");
        document.getElementById("pubflag").value = "${intermedOrg.pubflag }";
        var showfields = "${intermedOrg.showFields }";
        var fields = showfields.split(",");
        for (var i = 0; i < fields.length; i++) {
        	
        	var fl = fields[i];
        	if(fl!=''){
        		$("#"+fl+"Set").val(fl);
        	}
        	
		}
        $('#intermedEditForm').form({
            url: '${path }/intermedOrg/back/update',
            onSubmit: function (param) {
                param.orgIntro = keditor.html();
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
                    keditor.html('');
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#intermedEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });
    function kedit(keid) {
        keditor = KindEditor.create('#' + keid, {
            themeType: 'simple',//风格
            width: '600px',//设置宽度
            height: '300px',//设置高度
            autoHeightMode: true,//自动高度调整
            cssData: 'body {font-family: "微软雅黑"; font-size: 14px}', //修改字体
            allowPreviewEmoticons: false,
            allowFileManager: true,//true时显示图片上传按钮。默认值: true
            allowImageUpload: true,
            uploadJson: '${staticPath }/editor/fileUpload',
            fileManagerJson: '${staticPath }/editor/fileManager',//指定浏览远程图片的服务器端程序
        });
    };
</script>