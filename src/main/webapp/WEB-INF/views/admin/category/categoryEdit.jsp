<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#categoryEditPid').combotree({
            url : '${path }/category/tree?flag=false',
            parentField : 'pid',
            panelHeight : 'auto',
            value :'${category.pid}'
        });
        
        $('#categoryEditForm').form({
            url : '${path }/category/edit',
            onSubmit : function() {
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
                    parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为category.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#categoryEditForm');
                    parent.$.messager.alert('提示', eval(result.msg), 'warning');
                }
            }
        });
        
    });
</script>
<div style="padding: 3px;">
    <form id="categoryEditForm" method="post">
      <table class="grid">
            <tr>
                <td>分类名称</td>
                <td><input name="id" type="hidden"  value="${category.id}"><input name="categoryName" type="text" value="${category.categoryName}"  placeholder="请输入分类名称" class="easyui-validatebox" data-options="required:true" ></td>
            </tr>
             <tr>
            	<td>分类图标</td>
                <td ><input name="icon" value="${category.icon}"  onclick='top.window.openIconDialog(this)'/></td>
            	<td>排序</td>
                <td><input name="seq"   value="${category.seq}"  class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false" value="0"></td>
            </tr>
            <tr>
            	<td>是否顶级分类</td>
                <td>
                    <select name="isRootMenu"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="1"  <c:if test="${category.isRootMenu==1}">select="select"</c:if> >是</option>
                        <option value="0"  <c:if test="${category.isRootMenu==0}">select="select"</c:if> >否</option>
                    </select>
                </td>
                <td>分类状态</td>
                <td>
                    <select name="isShow"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                        <option value="1" <c:if test="${category.ifShow==1}">select="select"</c:if>>正常</option>
                        <option value="0" <c:if test="${category.ifShow==0}">select="select"</c:if>>停用</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>上级分类</td>
                <td colspan="3"><select id="categoryAddPid" name="pid" style="width:200px;height: 29px;"></select>
                <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#pid').combotree('clear');" >清空</a></td>
            </tr>
        </table>
    </form>
</div>
