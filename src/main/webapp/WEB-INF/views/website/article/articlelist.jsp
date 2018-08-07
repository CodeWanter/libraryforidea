<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>通知公告</title>

<link rel="stylesheet"
	href="${staticPath }/static/js/pagination_zh/lib/pagination.css" />
<script charset="utf-8"
	src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>

</head>
<body>
<div class="layui-input-block" style="float:right;">
                <input type="search" id="searchText" autocomplete="off" name="title"
                       placeholder="请输入文章名称"
                       class="layui-input-inline layui-input" style="height:33px;" onblur="articleSearch()"/>
                <input type="hidden" id="queryString" value=""/>
            </div>
            <hr class="layui-bg-red">
            <table class="layui-table">
                <thead>
                <tr>
                 	<td>id</td>
                    <td>标题</td>
                    <td>创建时间</td>
                </tr>
                </thead>
                <tbody id="List"></tbody>
            </table>
            <div id="Pagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
</body>
<script type="text/javascript">
var pageIndex =1;
var pageSize = 10;

$(function () {
    $("#searchText").val(getParam("title"));
    $("#queryString").val(getParam("title"));
    PaginationInit(pageIndex, pageSize);
});
//截取url数据方法
var getParam = function (name) {
    var search = document.location.search;
    var pattern = new RegExp("[?&]" + name + "\=([^&]+)", "g");
    var matcher = pattern.exec(search);
    var items = null;
    if (null != matcher) {
        try {
            items = decodeURIComponent(decodeURIComponent(matcher[1]));
        } catch (e) {
            try {
                items = decodeURIComponent(matcher[1]);
            } catch (e) {
                items = matcher[1];
            }
        }
    }
    return items;
};
//初始化分页插件
function PaginationInit(pageIndex, pageSize) {
    var title='';
    if($("#searchText").val()!=''){
    	title = $("#searchText").val();
    }
    $.post("${path }/forehead/article/articlelistdata", {
        "title": title,
        "sort":"createTime",
        "order":"desc",
        "pageIndex": pageIndex,
        "pageSize": pageSize
    }, function (data) {
    	data = JSON.parse(data);
    	console.log(data);
        // 创建分页
        $("#Pagination").pagination(data.total, {
            num_edge_entries: 2, //边缘页数
            num_display_entries: 10, //主体页数
            callback: paginationCallback, //回调函数
            items_per_page: pageSize, //每页显示多少项
            prev_text: "<<上一页",
            next_text: "下一页>>"

        });
    });
}
//分页数据回调
function paginationCallback(pageIndex, jq) {
    var title='';
    var index;
    if($("#searchText").val()!=''){
    	title = $("#searchText").val();
    }
    $.ajax({
        type: "post",
        url: "${path }/forehead/article/articlelistdata",
        data: {"title":title, "sort":"createTime","order":"desc", "pageIndex": pageIndex+1, "pageSize": pageSize},
        dataType: "json",
        async: true,
        beforeSend: function () {
            //index = layer.load(1);
        },
        complete: function () {
        },
        success: function (result) {
            //layer.close(index);
            console.log(result);
            result = result.rows;
            $("#List").html("");
            $.each(result, function (i, item) {
                var html = "";
                html += '<tr>';
                html += '<td class="tdNumClass"><i>' + item.id + '</i></td>';
                html += '<td class="tdClass"><i><a  href="${path }/forehead/article/detail?id='+ item.id +'">' + item.title + '</a></i></td>';
                html += '<td class="tdClass"><i>' + item.createTime + '</i></td>';
                html += '</tr>';
                $("#List").append(html);
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert('error...状态文本值：' + textStatus + " 异常信息：" + errorThrown);
            layer.msg('检索异常!');
        }
    });
}
function articleSearch(){
	var searchText = $("#searchText").val();
    window.location.href = "${path }/forehead/article/articlelist?title=" + searchText;
}
</script>
</html>