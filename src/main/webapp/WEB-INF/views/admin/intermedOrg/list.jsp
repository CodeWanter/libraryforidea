<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var intermedDataGrid;

    $(function () {
    	intermedDataGrid = $('#intermedDataGrid').datagrid({
            url: '${path }/intermedOrg/back/dataGrid',
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
                title: '机构名称',
                field: 'orgName',
                sortable: true
            }, {
                width: '100',
                title: '审核状态',
                field: 'pubflag',
                sortable: true,
                formatter: function (value, rec) {
                    if (value == 1) {
                        return '通过';
                    } else if(value == 0) {
                        return '未审核';
                    }else if(value == 2) {
                        return '不通过';
                    }
                }
            }, {
                width: '120',
                title: '创建时间',
                field: 'createTime',
                sortable: true
            }, {
                width: '120',
                title: '上次修改时间',
                field: 'modifyTime',
                sortable: true
            }, {
                field: 'action',
                title: '操作',
                width: 250,
                formatter: function (value, row, index) {
                    var str = '';
                    <shiro:hasPermission name="/intermedOrg/back/update">
                    str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="editintermedFun(\'{0}\');" >编辑</a>', row.id);
                    </shiro:hasPermission>
                    <shiro:hasPermission name="/intermedOrg/back/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="deleteintermedFun(\'{0}\');" >删除</a>', row.id);
                    </shiro:hasPermission>
                    return str;
                }
            }]],
            onLoadSuccess: function (data) {
                $('.user-easyui-linkbutton-edit').linkbutton({text: '编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text: '删除'});
            },
            toolbar: '#intermedToolbar'
        });
    });

    function addintermed() {
        parent.$.modalDialog({
            title: '添加',
            width: 800,
            height: 400,
            href: '${path }/intermedOrg/back/create',
            buttons: [{
                text: '添加',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = intermedDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#intermedForm');
                    f.submit();
                }
            }]
        });
    }

   

    function deleteintermedFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = intermedDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
        	intermedDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除该中介机构？', function (b) {
            if (b) {
                progressLoad();
                $.post('${path }/intermedOrg/back/delete', {
                    id: id
                }, function (result) {
                    result = $.parseJSON(result);
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        intermedDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'text');
            }
        });
    }

    function editintermedFun(id) {
        if (id == undefined) {
            var rows = policyDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	intermedDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title: '编辑',
            width: 800,
            height: 400,
            href: '${path }/intermedOrg/back/edit?id=' + id,
            buttons: [{
                text: '确定',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = intermedDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#intermedEditForm');
                    f.submit();
                }
            }]
        });
    }

    function searchintermedFun() {
    	intermedDataGrid.datagrid('load', $.serializeObject($('#searchintermedForm')));
    }
    function cleanintermedFun() {
        $('#searchintermedForm input').val('');
        intermedDataGrid.datagrid('load', {});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchintermedForm">
            <table>
                <tr>
                    <th>机构名称:</th>
                    <td><input type="text" name="orgName" placeholder="请输入机构名称"/></td>
                    <th>审核状态:</th>
                    <td>
                        <select class="easyui-combobox" name="pubflag">
                            <option value="">全部</option>
                            <option value="0">未审核</option>
                            <option value="1">通过</option>
                            <option value="2">不通过</option>
                        </select>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-search',plain:true" onclick="searchintermedFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-remove-circle',plain:true"
                           onclick="cleanintermedFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'中介机构列表'">
        <table id="intermedDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="intermedToolbar" style="display: none;">
    <shiro:hasPermission name="/intermedOrg/back/save">
        <a onclick="addintermed();" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
    
</div>