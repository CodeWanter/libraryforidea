<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    function today(){
        var today=new Date();
        var h=today.getFullYear();
        var m=today.getMonth()+1;
        var d=today.getDate();
        var hh=today.getHours();
        var mm=today.getMinutes();
        var ss=today.getSeconds();
        m= m<10?"0"+m:m;
        d= d<10?"0"+d:d;
        hh = hh < 10 ? "0" + hh:hh;
        mm = mm < 10 ? "0" +  mm:mm;
        ss = ss < 10 ? "0" + ss:ss;
        return h+"-"+m+"-"+d+" "+hh+":"+mm+":"+ss;
    }
    function getmonthday(){
        var today=new Date();
        var h=today.getFullYear();
        var m=today.getMonth();
        var d=today.getDate();
        var hh=today.getHours();
        var mm=today.getMinutes();
        var ss=today.getSeconds();
        m= m<10?"0"+m:m;
        d= d<10?"0"+d:d;
        hh = hh < 10 ? "0" + hh:hh;
        mm = mm < 10 ? "0" +  mm:mm;
        ss = ss < 10 ? "0" + ss:ss;
        return h+"-"+m+"-"+d+" "+hh+":"+mm+":"+ss;
    }
    var logDataGrid;
    $(document).ready(function() {
        document.getElementById("startTime").value = getmonthday();
        document.getElementById("endTime").value = today();
    });
    $(function() {
        logDataGrid = $('#logDataGrid').datagrid({
            url : '${path }/logmanage/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'access_time',
            sortOrder : 'desc',
            queryParams: {
                startTime: $("#startTime").val(),
                endTime:$("#endTime").val()
            },
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '80',
                title : '用户名',
                field : 'userName'
            }, {
                width : '110',
                title : 'IP',
                field : 'userIp'
            },{
                width : '80',
                title : '浏览内容',
                field : 'accessType'
            },{
                width : '200',
                title : '操作系统&浏览器',
                field : 'userBrower'
            },{
                width : '350',
                title : 'URL',
                field : 'url'
            }, {
                width: '350',
                title: '检索词',
                field: 'keyWord'
            },{
                width : '120',
                title : '浏览时间',
                field : 'accessTime'
            }]],
            toolbar : '#logToolbar'
        });
    });
    function searchUserFun() {
        logDataGrid.datagrid('load', $.serializeObject($('#searchlogForm')));
    }
    function cleanUserFun() {
        $('#searchlogForm input').val('');
        logDataGrid.datagrid('load', {});
    }
    function getCharFun() {
        parent.$.modalDialog({
            title : '统计图',
            width : 800,
            height : 500,
            href : '${path }/logmanage/getChart',
            queryParams: { startTime:$("#startTime").val(),endTime:$("#endTime").val() }
        });
    }
    function  excelExportFun() {
        window.open("${path }/logmanage/excelExport?startTime="+$("#startTime").val()+"&endTime="+$("#endTime").val());
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchlogForm">
            <table>
                <tr>
                    <th>时间:</th>
                    <td>
                        <input class="Wdate" name="startTime" id="startTime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至
                        <input class="Wdate" name="endTime" id="endTime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-search',plain:true" onclick="searchUserFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'glyphicon-remove-circle',plain:true" onclick="cleanUserFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'日志列表'" >
        <table id="logDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="logToolbar" style="display: none;">
    <%--<shiro:hasPermission name="/logmanage/getChart">--%>
        <a onclick="getCharFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-signal icon-blue'">查看统计图表</a>
        <a onclick="excelExportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-floppy-save icon-blue'">excel导出</a>
    <%--</shiro:hasPermission>--%>
</div>

