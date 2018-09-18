<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var industryDataGrid;
    $(function() {
    	industryDataGrid = $('#industryDataGrid').datagrid({
            url : '${path}/industry/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'createTime',
	        sortOrder : 'desc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '250',
                title : '标题',
                field : 'title',
                sortable : true
            }, {
                width : '250',
                title : '创建时间',
                field : 'createTime',
                sortable : true
            },{
                width : '250',
                title : '上次修改时间',
                field : 'modifyTime',
                sortable : true
            }, {
                field : 'action',
                title : '操作',
                width : 250,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/industry/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="editIndustryFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/industry/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="deleteIndustryFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.user-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#industryToolbar'
        });
    });
    
    function addIndustry() {
        parent.$.modalDialog({
            title : '添加',
            width : 400,
            height: 280,
            href : '${path}/industry/create',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = industryDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#industryForm');
                    f.submit();
                }
            } ]
        });
    }
    function deleteIndustryFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = industryDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
        	industryDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除该产业库信息？', function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/industry/delete', {
                    id : id
                }, function(result) {
                    result = $.parseJSON(result);
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        industryDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'text');
            }
        });
    }
    
    function editIndustryFun(id) {
        if (id == undefined) {
            var rows = industryDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	industryDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 400,
            height: 280,
            href : '${path}/industry/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = industryDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#industryEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function searchIndustryFun() {
    	industryDataGrid.datagrid('load', $.serializeObject($('#searchIndustryForm')));
    }
    function cleanIndustryFun() {
        $('#searchIndustryForm input').val('');
        industryDataGrid.datagrid('load', {});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchIndustryForm">
            <table>
                <tr>
                    <th>产业库名称:</th>
                    <td><input type="text" name="title" placeholder="请输入产业库名称"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-search',plain:true" onclick="searchIndustryFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-remove-circle',plain:true" onclick="cleanIndustryFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'产业库列表'" >
        <table id="industryDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="industryToolbar" style="display: none;">
    <shiro:hasPermission name="/industry/save">
        <a onclick="addIndustry();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>