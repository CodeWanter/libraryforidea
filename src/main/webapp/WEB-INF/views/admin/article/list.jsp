<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var articleDataGrid;

    $(function() {
        articleDataGrid = $('#articleDataGrid').datagrid({
            url : '${path }/articleback/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'createTime',
	        sortOrder : 'DESC',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '250',
                title : '标题',
                field : 'title',
                sortable : true
            }, {
                width : '250',
                title: '发布平台',
                field : 'articleType',
                sortable : true,
                formatter: function (value, rec) {
                    if(value==1){
                        return '双创平台';
                    }else{
                        return '市图平台';
                    }
                }
            },{
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
                        <shiro:hasPermission name="/articleback/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="editArticleFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/articleback/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="deleteArticleFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.user-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#articleToolbar'
        });
    });
    
    function addArticle() {
        parent.$.modalDialog({
            title : '添加',
            width : 900,
            height : 600,
            href : '${path }/articleback/create',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = articleDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#articleForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function deleteArticleFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = articleDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            articleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除该文章？', function(b) {
            if (b) {
                progressLoad();
                $.post('${path }/articleback/delete', {
                    id : id
                }, function(result) {
                    result = $.parseJSON(result);
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        articleDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'text');
            }
        });
    }
    
    function editArticleFun(id) {
        if (id == undefined) {
            var rows = articleDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            articleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 900,
            height : 600,
            href : '${path }/articleback/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = articleDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#articleEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function searchArticleFun() {
        articleDataGrid.datagrid('load', $.serializeObject($('#searchArticleForm')));
    }
    function cleanArticleFun() {
        $('#searchArticleForm input').val('');
        articleDataGrid.datagrid('load', {});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchArticleForm">
            <table>
                <tr>
                    <th>文章标题:</th>
                    <td><input type="text" name="title" placeholder="请输入文章标题"/></td>
                    <th>发布平台:</th>
                    <td>
						<select class="easyui-combobox" name="articleType">
							<option value="">全部</option>
                            <option value="1">双创平台</option>
                            <option value="2">市图平台</option>
						</select>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-search',plain:true" onclick="searchArticleFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-remove-circle',plain:true" onclick="cleanArticleFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'文章列表'" >
        <table id="articleDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="articleToolbar" style="display: none;">
    <shiro:hasPermission name="/articleback/save">
        <a onclick="addArticle();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>