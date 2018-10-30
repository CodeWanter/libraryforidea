<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var orgServiceDataGrid;
    var intermdOrgTree;
	
    $(function() {
    	intermdOrgTree = $('#intermdOrgTree').tree({
            url : '${path}/intermedOrg/back/tree',
            onClick : function(node) {
                $("#orgId").val(node.id);
                orgServiceDataGrid.datagrid('load', {
                	orgId: node.id
                });
            }
        });

    	orgServiceDataGrid = $('#orgServiceDataGrid').datagrid({
            url : '${path}/orgService/back/dataGrid',
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
                width : '100',
                title : '服务名称',
                field : 'serviceName',
                sortable : true
            }, {
                width : '80',
                title : '审核状态',
                field : 'pubflag',
                sortable : true,
                formatter: function (value, rec) {
                	 if (value == 1) {
                         return '通过';
                     } else if(value == 0) {
                         return '未审核';
                     }else if(value == 2) {
                         return '不通过';
                     }
                }
            },{
                width : '130',
                title : '创建时间',
                field : 'createTime',
                sortable : true
            }, {
                width : '130',
                title : '修改时间',
                field : 'modifyTime',
                sortable : true
            },  {
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/orgService/back/update">
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="editOrgServiceFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/orgService/back/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="deleteOrgServiceFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.user-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#orgServiceToolbar'
        });
    });
    
    function addOrgServiceFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 700,
            height : 400,
            href : '${path}/orgService/back/create',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = orgServiceDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#orgServiceForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function deleteOrgServiceFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = orgServiceDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
        	orgServiceDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前数据？', function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/orgService/back/delete', {
                    id : id
                }, function(result) {
                    result = $.parseJSON(result);
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        orgServiceDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'text');
            }
        });
    }
    
    function editOrgServiceFun(id) {
        if (id == undefined) {
            var rows = orgServiceDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	orgServiceDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 700,
            height : 400,
            href : '${path}/orgService/back/edit?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = orgServiceDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#orgServiceEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function searchOrgServiceFun() {
    	var orgIdV = $("#orgId").val();
    	if(orgIdV=null||orgIdV==''){
    		$("#orgId").val(0);
    	}
    	
    	orgServiceDataGrid.datagrid('load', $.serializeObject($('#searchOrgServiceForm')));
    }
    function cleanOrgServiceFun() {
        $('#searchOrgServiceForm input').val('');
        orgServiceDataGrid.datagrid('load', {});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchOrgServiceForm">
            <table>
                <tr>
                    <th>服务名称:</th>
                    <td><input name="serviceName" placeholder="请输入服务名称"/></td>
                    <th>审核状态:</th>
                    <td>
                    	<select class="easyui-combobox" name="pubflag">
                            <option value="">全部</option>
                            <option value="0">未审核</option>
                            <option value="1">通过</option>
                            <option value="2">不通过</option>
                        </select>
                        <input type="hidden" name="orgId" id="orgId" value=""/>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-search',plain:true" onclick="searchOrgServiceFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-remove-circle',plain:true" onclick="cleanOrgServiceFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'服务列表'" >
        <table id="orgServiceDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'中介机构'"  style="width:190px;overflow: hidden; ">
        <ul id="intermdOrgTree" style="width:200px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="orgServiceToolbar" style="display: none;">
    <shiro:hasPermission name="/orgService/back/save">
        <a onclick="addOrgServiceFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>