<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/layui.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>最新动态</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css" />
    <link rel="stylesheet"
	href="${staticPath }/static/js/pagination_zh/lib/pagination.css" />
<script charset="utf-8"
	src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>
</head>
<body class="LS2018_body">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
    <div class="LS2018_bd Z_clearfix">
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>最新动态
        </div>

        <div class="LS2018_Aleft">
            <div class="LS2018_module1">
                <div class="m_top Z_clearfix">
                    <span class="tt">每日更新</span>
                    <a class="more" href="${staticPath}/forehead/collect/collectlist">more &gt;</a>
                </div>
                <div class="m_middle">
                    <ul class="ul1" id="collect">

                    </ul>
                </div>
            </div>
            <div class="LS2018_module1">
                <div class="m_top Z_clearfix" id="a02">
                    <span class="tt">试用资源</span>
                </div>
                <div class="m_middle">
                    <ul class="ul1">
                        <li><a href="http://qikan.cqvip.com/">维普中文期刊服务平台</a></li>
                        <li><a href="http://zlf.cqvip.com/index.aspx?returnUrl=">智立方知识资源系统</a></li>
                        <li><a href="http://www.yjsexam.com/main">起点考研网</a></li>
                        <li><a href="http://yx.qdexam.com/main">起点医考网</a></li>
                        <li><a href="http://www.digitalmechanical.com.cn/">CIDP制造业数字资源平台</a></li>
                        <li><a href="http://www.epsnet.com.cn/">EPS数据平台</a></li>
                        <li><a href="http://ipub.exuezhe.com/index.html">中国人民大学复印报刊资料</a></li>
                        <li><a href="http://fdts.ideahome.com.cn/index.aspx">万文博硕士论文服务系统</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="LS2018_Aright">
            <div class="LS2018_module2">
                <div class="m_top">
                    <span class="tt">最新动态</span>
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
                <input type="search" id="searchText" autocomplete="off" name="title"
                       placeholder="请输入文章名称"
                       class="layui-input-inline layui-input" style="height:33px;" onblur="articleSearch()"/>
                <input type="hidden" id="queryString" value=""/>
            </div>


</body>
<script type="text/javascript">
var pageIndex =1;
var pageSize = 10;

$(function () {
    $("#searchText").val(getParam("title"));
    $("#queryString").val(getParam("title"));
    PaginationInit(pageIndex, pageSize);
    $.post(basePath + '/forehead/collect/topTenData',{"title":"","nowpage":1,"pageSize":5,"sort":"collect_time","order":"desc"},function(result){
        result = eval('(' + result + ')');
        var data = result.rows;
        $.each(result.rows, function (i, item) {
            var html = "";
            html += '<li><a href="'+item.url+'" target="_blank">' +item.title + '</a></li>';
            $("#collect").append(html);
        });
    });
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
            //layer.close(index);
        },
        success: function (result) {
            //layer.close(index);
            result = result.rows;
            $("#List").html("");
            $.each(result, function (i, item) {
                var html = "";
                html += '<li><a  href="${path }/forehead/article/detail?id='+ item.id +'">' + (pageIndex*10+i+1)+'、'+ item.title + '</a><span style="float:right;"><i>' + item.createTime.substr(0,10) + '</i></span></li>';
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