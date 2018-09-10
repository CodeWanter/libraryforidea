<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var industryEachDataGrid;
    var industryEachTree;

    $(function() {
        industryEachTree = $('#industryEachTree').tree({
            url : '${path}/industryEach/tree',
            onClick : function(node) {
                $("#tableName").val(node.id);
                industryEachDataGrid.datagrid('load', {
                	tableName: node.id
                });
            }
        });

        industryEachDataGrid = $('#industryEachDataGrid').datagrid({
            url : '${path}/industryEach/dataEachGrid',
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
                width : '500',
                title : '题名',
                field : 'title',
                sortable : true
            }, {
                width : '80',
                title : '审核',
                field : 'auditing',
                hidden : true
            },{
                width : '80',
                title : '类别',
                field : 'type',
                sortable : true,//期刊 0   论文1     专利2   项目信息3   咨询4   科技成果5
                formatter: function (value, rec) {
                    if(value==0){
                        return '期刊';
                    }else if(value==1){
                        return '论文';
                    }else if(value==2){
                        return '专利';
                    }else if(value==3){
                        return '项目信息';
                    }else if(value==4){
                        return '咨询';
                    }else if(value==5){
                        return '科技成果';
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
                field : 'editTime',
                sortable : true
            },  {
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/user/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="editIndustryEachFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/user/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="deleteIndustryEachFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.user-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#industryEachToolbar'
        });
    });
    
    function addIndustryEachFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 900,
            height : 600,
            href : '${path}/industryEach/addEachPage',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = industryEachDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#eachAddForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function deleteIndustryEachFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = industryEachDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            industryEachDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前数据？', function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/industryEach/delete', {
                    id : id
                }, function(result) {
                    result = $.parseJSON(result);
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        industryEachDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'text');
            }
        });
    }
    
    function editIndustryEachFun(id) {
        if (id == undefined) {
            var rows = industryEachDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            industryEachDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 900,
            height : 600,
            href : '${path}/industryEach/editEachPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = industryEachDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#eachEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function searchIndustryEachFun() {
        industryEachDataGrid.datagrid('load', $.serializeObject($('#searchIndustryEachForm')));
    }
    function cleanIndustryEachFun() {
        $('#searchIndustryEachForm input').val('');
        industryEachDataGrid.datagrid('load', {});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchIndustryEachForm">
            <table>
                <tr>
                    <th>题名:</th>
                    <td><input name="title" placeholder="请输入题名"/></td>
                    <th>创建时间:</th>
                    <td>
                        <input type="hidden" name="tableName" id="tableName" value=""/>
                        <input class="Wdate" name="createdateStart1" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至
                        <input class="Wdate" name="createdateEnd1" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-search',plain:true" onclick="searchIndustryEachFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-remove-circle',plain:true" onclick="cleanIndustryEachFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'产业库信息列表'" >
        <table id="industryEachDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'产业库'"  style="width:190px;overflow: hidden; ">
        <ul id="industryEachTree" style="width:200px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="industryEachToolbar" style="display: none;">
    <shiro:hasPermission name="/user/add">
        <a onclick="addIndustryEachFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>