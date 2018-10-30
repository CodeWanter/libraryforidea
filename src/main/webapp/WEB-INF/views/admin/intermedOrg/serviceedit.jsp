<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/themes/default/default.css"/>
<link rel="stylesheet"
      href="${staticPath }/static/js/kindeditor/plugins/code/prettify.css"/>
      <script type="text/javascript">
      $(function() {
    	  $("#orgNameId").combotree({
    		  url :"${path}/intermedOrg/back/tree",
    		  valueField: 'id',
    		  textField: 'text',
    		  onLoadSuccess: function (node, data) {
    			  var temid = "${orgService.orgId}";
    		      $("#orgNameId").combotree('setValue', temid);
    		  }
    	  })
    	  
    	//设置机构的回显
    	 
      });
      </script>
<div style="width: 100%">
    <div style="padding: 10px 20px 10px 20px">
        <form id="orgServiceEditForm" method="post">
            <input type="hidden" value="${orgService.id }" name="id"/>
            <table>
               <tr>
                    <td>服务名称:</td>
                    <td><input class="easyui-textbox" type="text" name="serviceName"
                               id="serviceName" data-options="required:true" value="${orgService.serviceName}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="serviceNameSet">
                    		<option value="serviceName">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>服务类型:</td>
                    <td><select id="serviceType" name="serviceType" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'"
                    		value="${orgService.serviceType}">
                        	<option value="技术培训">技术培训</option>
                        	<option value="知识产权">知识产权</option>
                        	<option value="产学研合作">产学研合作</option>
                        	<option value="项目申报">项目申报</option>
                        	<option value="查新鉴定">查新鉴定</option>
                        	<option value="政策咨询">政策咨询</option>
                        </select>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="serviceTypeSet">
                    		<option value="serviceType">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                </tr>
                	<td>所属机构:</td>
                	<td><select  name="orgId" id="orgNameId"  class="easyui-combobox" data-options="width:170,height:29,editable:false,panelHeight:'auto',required:true">
                    		
                    	</select>
                	</td>
                	<td><select class="easyui-combobox" name="showFields" id="orgIdSet">
                    		<option value="orgId">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                	
                <tr>
                    <td>机构联系人:</td>
                    <td><input class="easyui-textbox" type="text" name="serviceContact"
                               id="serviceContact" data-options="required:true" value="${orgService.serviceContact}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="serviceContactSet">
                    		<option value="serviceContact">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>联系方式:</td>
                    <td><input class="easyui-textbox" type="text" name="contactWay"
                               id="contactWay" data-options="required:true" value="${orgService.contactWay}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="contactWaySet">
                    		<option value="contactWay">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                
                <tr>
                    <td>收费标准:</td>
                    <td><input class="easyui-textbox" type="text" name="serviceFee"
                               id="serviceFee" data-options="required:true" value="${orgService.serviceFee}"></input>
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="serviceFeeSet">
                    		<option value="serviceFee">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>服务指南:</td>
                    <td>
                    	<c:if test="${orgService.serviceGuide != ''}">
                    		<a target="_blank" download="" href="${orgService.serviceGuide}" style="color: #00b2ff;" >机构营业执照下载</a>
                    		<input type="hidden" name="serviceGuide" value="${orgService.serviceGuide}"/>
                    	</c:if>
                        <input name="serviceGuideFile"  class="easyui-filebox"
                                    data-options="prompt:'Choose a file...'">
                    </td>
                    <td>
                    	<select class="easyui-combobox" name="showFields" id="serviceGuideSet">
                    		<option value="serviceGuide">显示</option>
                        	<option value="" selected="selected">禁用</option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>服务介绍:</td>
                    <td><br/> <textarea name="kindeditor" id="kindeditor"
                                        class="xt_textarea">${orgService.serviceIntro}</textarea> <br/>
                     </td>
                     <td>
                    	<select class="easyui-combobox" name="showFields" id="serviceIntroSet" >
                    		<option value="serviceIntro">显示</option>
                        	<option value="" selected="selected">禁用</option>
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
        document.getElementById("pubflag").value = "${orgService.pubflag }";
        var showfields = "${orgService.showFields }";
        var fields = showfields.split(",");
        for (var i = 0; i < fields.length; i++) {
        	
        	var fl = fields[i];
        	if(fl!=''){
        		$("#"+fl+"Set").val(fl);
        	}
        	
		}
        $('#orgServiceEditForm').form({
            url: '${path }/orgService/back/update',
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
                    var form = $('#orgServiceEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });
    function kedit(keid) {
        keditor = KindEditor.create('#' + keid, {
            themeType: 'simple',//风格
            width: '500px',//设置宽度
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