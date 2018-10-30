<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/layui.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath }/static/lsportal1/H5/css/main_WeiXin.css"/>
    <link rel="stylesheet"
          href="${staticPath }/static/js/pagination_zh/lib/pagination.css"/>
    <script charset="utf-8"
            src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>
</head>
<body class="LS2018_WX_body">

<div class="LS2018_WX_title2">每日推荐</div>

<ul class="LS2018_WX_list1" id="daily">
</ul>
<div id="Pagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
</body>
<script type="text/javascript">
    var pageIndex = 1;
    var pageSize = 10;

    $(function () {
        PaginationInit(pageIndex, pageSize);
    });
    //初始化分页插件
    function PaginationInit(pageIndex, pageSize) {
        var title = '';
        $.post("${path }/forehead/collect/collectlistdata", {
            "title": title,
            "sort": "collectTime",
            "order": "desc",
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
        var title = '';
        var index;
        $.ajax({
            type: "post",
            url: "${path }/forehead/collect/collectlistdata",
            data: {
                "title": title,
                "sort": "collectTime",
                "order": "desc",
                "pageIndex": pageIndex + 1,
                "pageSize": pageSize
            },
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
                $("#daily").html("");
                $.each(result, function (i, item) {
                    var html = "";
                    html += '<li><a  href="' + item.url + '" target="_blank"><span class="aa">' + item.title + '</span><span class="time"><i>' + item.collectTime.substr(0, 10) + '</i></span></a></li>';
                    $("#daily").append(html);
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert('error...状态文本值：' + textStatus + " 异常信息：" + errorThrown);
                layer.msg('检索异常!');
            }
        });
    }
</script>
</html>