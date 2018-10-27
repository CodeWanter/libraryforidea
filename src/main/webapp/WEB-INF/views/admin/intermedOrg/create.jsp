<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/themes/default/default.css"/>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/plugins/code/prettify.css"/>
      <style>
      	.easyui-combobox{
      		height:80px;
      	}
      </style>
<div style="width: 100%">
    <div style="padding: 10px 20px 10px 20px">
        <form id="intermedForm" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>机构名称:</td>
                    <td><input class="easyui-textbox" type="text" name="orgName"
                               id="orgName" data-options="required:true"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields">
                    		<option value="orgName">显示</option>
                        	<option value="">禁用</option>
                    	</select>
                    </td>
                </tr>
                
                <tr>
                    <td>机构联系人:</td>
                    <td><input class="easyui-textbox" type="text" name="contactName"
                               id="contactName" data-options="required:true"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" >
                    		<option value="contactName">显示</option>
                        	<option value="">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>联系电话:</td>
                    <td><input class="easyui-textbox" type="text" name="contactTel"
                               id="contactTel" data-options="required:true"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" >
                    		<option value="contactTel">显示</option>
                        	<option value="">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>联系邮箱:</td>
                    <td><input class="easyui-textbox" type="text" name="contactEmail"
                               id="contactEmail" data-options="required:true"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" >
                    		<option value="contactEmail">显示</option>
                        	<option value="">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>机构代码:</td>
                    <td><input class="easyui-textbox" type="text" name="orgCode"
                               id="orgCode" data-options="required:true"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" >
                    		<option value="orgCode">显示</option>
                        	<option value="">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>营业执照:</td>
                    <td>
                        <input name="businessLicenseFile" data-options="required:true" class="easyui-filebox"
                                    data-options="prompt:'Choose a file...'">
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" >
                    		<option value="businessLicense">显示</option>
                        	<option value="">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>机构介绍:</td>
                    <td><br/> <textarea name="kindeditor" id="kindeditor"
                                        class="xt_textarea"></textarea> <br/>
                     </td>
                     <td>
                    	<select class="easyui-combobox" name="showFields" >
                    		<option value="orgIntro">显示</option>
                        	<option value="">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>审核:</td>
                    <td><select class="easyui-combobox" name="pubflag" id="pubflag">
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
        $('#intermedForm').form({
            url: '${path }/intermedOrg/back/save',
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
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#intermedForm');
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