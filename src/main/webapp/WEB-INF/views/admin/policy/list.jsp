<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var policyDataGrid;

    $(function () {
        policyDataGrid = $('#policyDataGrid').datagrid({
            url: '${path }/policyback/dataGrid',
            fit: true,
            striped: true,
            rownumbers: true,
            pagination: true,
            singleSelect: true,
            idField: 'id',
            sortName: 'createTime',
            sortOrder: 'DESC',
            pageSize: 20,
            pageList: [10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
            columns: [[{
                width: '350',
                title: '标题',
                field: 'title',
                sortable: true
            }, {
                width: '100',
                title: '是否显示',
                field: 'isShow',
                sortable: true,
                formatter: function (value, rec) {
                    if (value == 1) {
                        return '显示';
                    } else {
                        return '禁用';
                    }
                }
            }, {
                width: '250',
                title: '创建时间',
                field: 'createTime',
                sortable: true
            }, {
                width: '250',
                title: '上次修改时间',
                field: 'modifyTime',
                sortable: true
            }, {
                field: 'action',
                title: '操作',
                width: 250,
                formatter: function (value, row, index) {
                    var str = '';
                    <shiro:hasPermission name="/policyback/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="editpolicyFun(\'{0}\');" >编辑</a>', row.id);
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/policyback/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="deletepolicyFun(\'{0}\');" >删除</a>', row.id);
                    </shiro:hasPermission>
                    return str;
                }
            }]],
            onLoadSuccess: function (data) {
                $('.user-easyui-linkbutton-edit').linkbutton({text: '编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text: '删除'});
            },
            toolbar: '#policyToolbar'
        });
    });

    function addpolicy() {
        parent.$.modalDialog({
            title: '添加',
            width: 900,
            height: 600,
            href: '${path }/policyback/create',
            buttons: [{
                text: '添加',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = policyDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#policyForm');
                    f.submit();
                }
            }]
        });
    }

    function importpolicy() {
        parent.$.modalDialog({
            title: 'excel导入',
            width: 280,
            height: 150,
            href: '${path }/policyback/excelImport',
            buttons: [{
                text: '导入',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = policyDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#importPolicyForm');
                    f.submit();
                }
            }]
        });
    }

    function deletepolicyFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = policyDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            policyDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除该文章？', function (b) {
            if (b) {
                progressLoad();
                $.post('${path }/policyback/delete', {
                    id: id
                }, function (result) {
                    result = $.parseJSON(result);
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        policyDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'text');
            }
        });
    }

    function editpolicyFun(id) {
        if (id == undefined) {
            var rows = policyDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            policyDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title: '编辑',
            width: 900,
            height: 600,
            href: '${path }/policyback/editPage?id=' + id,
            buttons: [{
                text: '确定',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = policyDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#policyEditForm');
                    f.submit();
                }
            }]
        });
    }

    function searchpolicyFun() {
        policyDataGrid.datagrid('load', $.serializeObject($('#searchpolicyForm')));
    }
    function cleanpolicyFun() {
        $('#searchpolicyForm input').val('');
        policyDataGrid.datagrid('load', {});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchpolicyForm">
            <table>
                <tr>
                    <th>标题:</th>
                    <td><input type="text" name="title" placeholder="请输入标题"/></td>
                    <th>审核状态:</th>
                    <td>
                        <select class="easyui-combobox" name="isShow">
                            <option value="">全部</option>
                            <option value="1">显示</option>
                            <option value="2">禁用</option>
                        </select>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-search',plain:true" onclick="searchpolicyFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-remove-circle',plain:true"
                           onclick="cleanpolicyFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'政策法规列表'">
        <table id="policyDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="policyToolbar" style="display: none;">
    <shiro:hasPermission name="/policyback/save">
        <a onclick="addpolicy();" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/policyback/exccelImport">
        <a onclick="importpolicy();" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'glyphicon-circle-arrow-up icon-green'">excel导入</a>
    </shiro:hasPermission>
</div>