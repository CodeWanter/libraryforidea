<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${nav.title }</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css" />
    <link rel="stylesheet"
          href="${staticPath }/static/js/pagination_zh/lib/pagination.css" />
    <script charset="utf-8"
            src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>
    <style>
        em {
            font-style: normal;
        }
    </style>
</head>
<body class="LS2018_body">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
    <div class="LS2018_bd Z_clearfix">
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a>
            <span class="gt">&gt;</span>
            <a href="${staticPath}/forehead/industry/indusrtyList">特色专题库</a>
            <span class="gt">&gt;</span><a href="${staticPath}/forehead/industry/selectOneInfo/${nav.id }">${nav.title }</a>
            <span class="gt">&gt;</span><span class="tt_nav"></span>
        </div>
        <div class="LS2018_ZT_banner" style="height: 250px;width: 1000px;background-image:url(${staticPath}/static/lsportal/images/industry/${nav.fileName});background-size: 100% 100%;">
            <div class="tt">${nav.title}</div>
        </div>
        <div class="LS2018_Aleft">
            <div class="LS2018_module1">
                <div class="m_top Z_clearfix">
                    <span class="tt">类型</span>
                </div>
                <div class="m_middle">
                    <ul class="ul1" id="collect">
                        <li><a href="javascript:void(0)" tid="0" onclick="golist(0)">期刊</a></li>
                        <li><a href="javascript:void(0)" tid="1" onclick="golist(1)">论文</a></li>
                        <li><a href="javascript:void(0)" tid="2" onclick="golist(2)">专利</a></li>
                        <li><a href="javascript:void(0)" tid="3" onclick="golist(3)">项目信息</a></li>
                        <li><a href="javascript:void(0)" tid="4" onclick="golist(4)">资讯</a></li>
                        <li><a href="javascript:void(0)" tid="5" onclick="golist(5)">科技成果</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="LS2018_Aright">
            <div class="LS2018_module2">
                <div class="m_top">
                    <span class="tt tt_nav">期刊</span>
                </div>
                <div class="m_middle">
                    <ul class="LS2018_list1" id="List">

                    </ul>
                    <div id="Pagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/commons/footer.jsp" %>
</div>
</div>
</body>
<script type="text/javascript">
    var pageIndex =1;
    var pageSize = 10;

    $(function () {
        var tid=getParam("tid");
        if(tid==0){
            $(".tt_nav").html("期刊");
            PaginationBaiduInit(pageIndex, pageSize);
        }else if(tid==1){
            $(".tt_nav").html("论文");
            PaginationBaidu2Init(pageIndex, pageSize);
        }else if(tid==2){
            $(".tt_nav").html("专利");
            ZLPaginationInit(pageIndex, pageSize);
        }else if(tid==3){
            $(".tt_nav").html("项目信息");
            PaginationInit(pageIndex, pageSize);
        }else if(tid==4){
            $(".tt_nav").html("资讯");
            PaginationInit(pageIndex, pageSize);
        }else if(tid==5){
            $(".tt_nav").html("科技成果");
            PaginationInit(pageIndex, pageSize);
        }
    });
    //初始化分页插件
    function PaginationInit(pageIndex, pageSize) {
        $.post("${path }/forehead/industry/listdata", {
            "id": getParam("id"),
            "tid": getParam("tid"),
            "sort":"createTime",
            "order":"desc",
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
        var index;
        $.ajax({
            type: "post",
            url: "${path }/forehead/industry/listdata",
            data: {
                "id": getParam("id"),
                "tid": getParam("tid"),
                "sort": "createTime",
                "order": "desc",
                "pageIndex": (pageIndex + 1),
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
                result = result.rows;
                $("#List").html("");
                $.each(result, function (i, item) {
                    var html = "";
                    html += '<li><a  href="${path }/forehead/industry/detail/'+ item.id +'/${nav.id }/'+item.type+'">' + (pageIndex*10+i+1)+'、'+ item.title + '</a><span style="float:right;"><i>' + item.createTime.substr(0,10) + '</i></span></li>';
                    $("#List").append(html);
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg('检索异常!');
            }
        });
    }

    function PaginationBaiduInit(pageIndex, pageSize) {
        $.get('http://115.29.2.102:7007/api/search?source=baidu&q=${nav.title}&returnFilter=true&filter=%7B"filter_type"%3A1%7D&page=' + pageIndex + '&pageSize=' + pageSize + '', {}, function (data) {
            data = JSON.parse(data);
            // 创建分页
            $("#Pagination").pagination(data.total, {
                num_edge_entries: 2, //边缘页数
                num_display_entries: 10, //主体页数
                callback: paginationBaiduCallback, //回调函数
                items_per_page: pageSize, //每页显示多少项
                prev_text: "<<上一页",
                next_text: "下一页>>"

            });
        });
    }

    function paginationBaiduCallback(pageIndex, jq) {
        var index;
        $.ajax({
            type: "post",
            url: 'http://115.29.2.102:7007/api/search?source=baidu&q=${nav.title}&returnFilter=true&filter=%7B"filter_type"%3A1%7D&page=' + (pageIndex + 1) + '&pageSize=' + pageSize + '',
            dataType: "json",
            async: true,
            beforeSend: function () {
                index = layer.load(1);
            },
            complete: function () {
                layer.close(index);
            },
            success: function (result) {
                result = result.items;
                $("#List").html("");
                $.each(result, function (i, item) {
                    var html = "";
                    html += '<li><a  href="http://115.29.2.102:7007' + item.url + '" target="_blank">' + (pageIndex * 10 + i + 1) + '、' + item.title + '</a></li>';
                    $("#List").append(html);
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg('检索异常!');
            }
        });
    }

    function PaginationBaidu2Init(pageIndex, pageSize) {
        $.get('http://115.29.2.102:7007/api/search?source=baidu&q=${nav.title}&returnFilter=true&filter=%7B"filter_type"%3A2%7D&page=' + pageIndex + '&pageSize=' + pageSize + '', {}, function (data) {
            data = JSON.parse(data);
            // 创建分页
            $("#Pagination").pagination(data.total, {
                num_edge_entries: 2, //边缘页数
                num_display_entries: 10, //主体页数
                callback: paginationBaidu2Callback, //回调函数
                items_per_page: pageSize, //每页显示多少项
                prev_text: "<<上一页",
                next_text: "下一页>>"

            });
        });
    }

    function paginationBaidu2Callback(pageIndex, jq) {
        var index;
        $.ajax({
            type: "post",
            url: 'http://115.29.2.102:7007/api/search?source=baidu&q=${nav.title}&returnFilter=true&filter=%7B"filter_type"%3A2%7D&page=' + pageIndex + 1 + '&pageSize=' + pageSize + '',
            dataType: "json",
            async: true,
            beforeSend: function () {
                index = layer.load(1);
            },
            complete: function () {
                layer.close(index);
            },
            success: function (result) {
                result = result.items;
                $("#List").html("");
                $.each(result, function (i, item) {
                    var html = "";
                    html += '<li><a  href="http://115.29.2.102:7007' + item.url + '" target="_blank">' + (pageIndex * 10 + i + 1) + '、' + item.title + '</a></li>';
                    $("#List").append(html);
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg('检索异常!');
            }
        });
    }
    //专利数据分页
    function ZLPaginationInit(pageIndex, pageSize) {
        $.get('http://115.29.2.102:7007/api/search?source=patent_lsnetlib&q=${nav.title}&page=' + pageIndex + '&pageSize=' + pageSize, {}, function (data) {
            data = JSON.parse(data);
            // 创建分页
            $("#Pagination").pagination(data.total, {
                num_edge_entries: 2, //边缘页数
                num_display_entries: 10, //主体页数
                callback: ZLpaginationCallback, //回调函数
                items_per_page: pageSize, //每页显示多少项
                prev_text: "<<上一页",
                next_text: "下一页>>"

            });
        });
    }
    //分页数据回调
    function ZLpaginationCallback(pageIndex, jq) {
        var index;
        $.ajax({
            type: "get",
            url: "http://115.29.2.102:7007/api/search?source=patent_lsnetlib&q=${nav.title}&page=" + (pageIndex + 1) + "&pageSize=" + pageSize,
            dataType: "json",
            async: true,
            beforeSend: function () {
                //index = layer.load(1);
            },
            complete: function () {
                //layer.close(index);
            },
            success: function (result) {
                result = result.items;
                $("#List").html("");
                $.each(result, function (i, item) {
                    var z = item.TI.indexOf("[ZH]");
                    var title = item.TI.substr(0, z);
                    var html = "";
                    html += '<li><a  href="http://patent.lsnetlib.com/patent/patent.html?docno=' + item.AN + '&trsdb=fmzl" target="_blank">' + (pageIndex * 10 + i + 1) + '、' + title + '</a></li>';
                    $("#List").append(html);
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg('数据接口异常，请刷新重试！');
            }
        });
    }
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

    function golist(tid){
        var id= getParam("id");
        window.location.href="${staticPath}/forehead/industry/list?id="+id+"&tid="+tid;
    }
</script>
</html>