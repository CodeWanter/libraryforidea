<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/layui.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TRIZ知识组织</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css"/>
    <link rel="stylesheet"
          href="${staticPath }/static/js/pagination_zh/lib/pagination.css"/>
    <script charset="utf-8"
            src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>
    <link rel="stylesheet" href="${staticPath }/static/js/zTree_v3/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="${staticPath }/static/js/zTree_v3/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/zTree_v3/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="${staticPath }/static/js/zTree_v3/js/jquery.ztree.exedit.js"></script>
</head>
<body class="LS2018_body">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
    <div class="LS2018_bd Z_clearfix">
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>TRIZ知识组织
        </div>

        <div class="LS2018_Aleft">
            <div class="LS2018_module1">
                <div class="m_top Z_clearfix">
                    <span class="tt">TRIZ知识树</span>
                </div>
                <div class="m_middle">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>

        <div class="LS2018_Aright">
            <div class="LS2018_module2">
                <div class="m_top">
                    <div class="LS2018_New_search Z_clearfix">
                        <input type="search" id="searchTxt" placeholder="请输入专利检索词">
                        <input class="btn layui-btn-primary layui-btn-radiu layui-btn-xsmall" type="button" value="检 索"
                               onclick="Search()">
                    </div>
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
</body>
<script type="text/javascript">
    var pageIndex = 1;
    var pageSize = 10;
    var key = "专利";
    var setting = {
        view: {
            selectedMulti: false
        },
        async: {
            enable: true,
            url: "${staticPath }/trizback/trizTree",
            autoParam: [],
            contentType: "application/json",
            otherParam: {name: ""},
            dataFilter: filter //异步获取的数据filter 里面可以进行处理  filter 在下面
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
    };
    $(function () {
        var treeObj = $.fn.zTree.init($("#treeDemo"), setting);
        PaginationInit(pageIndex, pageSize);
    });
    function Search() {
        key = $("#searchTxt").val();
        if (key == "") {
            layer.msg('检索词不能为空!');
            return;
        }
        PaginationInit(pageIndex, pageSize);
    }
    //点击回调函数
    function zTreeOnClick(event, treeId, treeNode) {
        key = treeNode.name;
        if (treeNode.pId == null) {
            key = "专利";
        }
        PaginationInit(pageIndex, pageSize);
    };
    function filter(treeId, parentNode, childNodes) {
        if (!childNodes) return null;
        for (var i = 0, l = childNodes.length; i < l; i++) {
            childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
        }
        return childNodes;
    }
    //初始化分页插件
    function PaginationInit(pageIndex, pageSize) {
        var title = '';
        if ($("#searchText").val() != '') {
            title = $("#searchText").val();
        }
        $.get('http://115.29.2.102:7007/api/search?source=patent_lsnetlib&q=' + key + '&page=1', {}, function (data) {
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
        if ($("#searchText").val() != '') {
            title = $("#searchText").val();
        }
        $.ajax({
            type: "get",
            url: "http://115.29.2.102:7007/api/search?source=patent_lsnetlib&q=" + key + "&page=" + (pageIndex + 1),
            dataType: "json",
            async: false,
            beforeSend: function () {
                index = layer.load(1);
            },
            complete: function () {
                layer.close(index);
            },
            success: function (result) {
                layer.close(index);
                $("#List").html("");
                if (result.total == 0) {
                    $("#List").append("<div style='text-align: center'>暂无数据</div>");
                } else {
                    result = result.items;
                    $.each(result, function (i, item) {
                        var z = item.TI.indexOf("[ZH]");
                        var title = item.TI.substr(0, z);
                        var html = "";
                        html += '<li><a  href="http://patent.lsnetlib.com/patent/patent.html?docno=' + item.AN + '&trsdb=fmzl" target="_blank">' + title + '</a></li>';
                        $("#List").append(html);
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.close(index);
                layer.msg('检索异常!');
            }
        });
    }
</script>
</html>