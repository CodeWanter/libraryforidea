<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    function today() {
        var today = new Date();
        var h = today.getFullYear();
        var m = today.getMonth() + 1;
        var d = today.getDate();
        var hh = today.getHours();
        var mm = today.getMinutes();
        var ss = today.getSeconds();
        m = m < 10 ? "0" + m : m;
        d = d < 10 ? "0" + d : d;
        hh = hh < 10 ? "0" + hh : hh;
        mm = mm < 10 ? "0" + mm : mm;
        ss = ss < 10 ? "0" + ss : ss;
        return h + "-" + m + "-" + d + " " + hh + ":" + mm + ":" + ss;
    }
    function getmonthday() {
        var today = new Date();
        var h = today.getFullYear();
        var m = today.getMonth();
        var d = today.getDate();
        var hh = today.getHours();
        var mm = today.getMinutes();
        var ss = today.getSeconds();
        m = m < 10 ? "0" + m : m;
        d = d < 10 ? "0" + d : d;
        hh = hh < 10 ? "0" + hh : hh;
        mm = mm < 10 ? "0" + mm : mm;
        ss = ss < 10 ? "0" + ss : ss;
        return h + "-" + m + "-" + d + " " + hh + ":" + mm + ":" + ss;
    }
    var deliverDataGrid;
    $(document).ready(function () {
        document.getElementById("startTime").value = getmonthday();
        document.getElementById("endTime").value = today();
    });
    $(function () {
        deliverDataGrid = $('#deliverDataGrid').datagrid({
            url: '${path }/deliverback/dataGrid',
            fit: true,
            striped: true,
            rownumbers: true,
            pagination: true,
            singleSelect: true,
            idField: 'id',
            sortName: 't.create_time',
            sortOrder: 'desc',
            queryParams: {
                startTime: $("#startTime").val(),
                endTime: $("#endTime").val()
            },
            pageSize: 20,
            pageList: [10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
            columns: [[{
                width: '80',
                title: '申请人',
                field: 'loginName'
            }, {
                width: '350',
                title: '文献名',
                field: 'title'
            }, {
                width: '120',
                title: '作者',
                field: 'author'
            }, {
                width: '100',
                title: '发布时间',
                field: 'publishTime'
            }, {
                width: '100',
                title: '姓名',
                field: 'name'
            }, {
                width: '120',
                title: 'email',
                field: 'email'
            }, {
                width: '100',
                title: '联系方式',
                field: 'tel'
            }, {
                width: '150',
                title: '地址',
                field: 'address'
            }, {
                width: '80',
                title: '邮编',
                field: 'zCode'
            }, {
                width: '200',
                title: '留言',
                field: 'message'
            }, {
                width: '120',
                title: '申请时间',
                field: 'createTime'
            }]],
            toolbar: '#deliverToolbar'
        });
    });
    function searchUserFun() {
        deliverDataGrid.datagrid('load', $.serializeObject($('#searchdeliverForm')));
    }
    function cleanUserFun() {
        $('#searchlogForm input').val('');
        deliverDataGrid.datagrid('load', {});
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchdeliverForm">
            <table>
                <tr>
                    <th>文献标题:</th>
                    <td><input type="text" name="title" placeholder="请输入文献标题"/></td>
                    <th>申请时间:</th>
                    <td>
                        <input class="Wdate" name="startTime" id="startTime" placeholder="点击选择时间"
                               onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                               readonly="readonly"/>至
                        <input class="Wdate" name="endTime" id="endTime" placeholder="点击选择时间"
                               onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                               readonly="readonly"/>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-search',plain:true" onclick="searchUserFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-remove-circle',plain:true" onclick="cleanUserFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'原文传递列表'">
        <table id="deliverDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="deliverToolbar" style="display: none;">

</div>

