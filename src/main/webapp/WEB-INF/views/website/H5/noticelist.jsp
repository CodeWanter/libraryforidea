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

<div class="LS2018_WX_title1">通知公告</div>

<ul class="LS2018_WX_list1" id="List">
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
        $.post("${path }/forehead/article/articlelistdata", {
            "title": title,
            "sort": "createTime",
            "order": "desc",
            "pageIndex": pageIndex,
            "pageSize": pageSize
        }, function (data) {
            data = JSON.parse(data);
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
        console.log(pageIndex);
        var title = '';
        var index;
        $.ajax({
            type: "post",
            url: "${path }/forehead/article/articlelistdata",
            data: {
                "title": title,
                "sort": "createTime",
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
                //layer.close(index);
            },
            success: function (result) {
                //layer.close(index);
                result = result.rows;
                $("#List").html("");
                $.each(result, function (i, item) {
                    var html = "";
                    html += '<li><a  href="${path }/forehead/article/noticedetail?id=' + item.id + '"> <span class="aa">' + item.title + '</span><span class="time"><i>' + item.createTime.substr(0, 10) + '</i></span></a></li>';
                    $("#List").append(html);
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