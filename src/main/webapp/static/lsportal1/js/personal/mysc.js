/**
 * Created by huangjunqing on 2018/8/28.
 */
var pageIndex = 1;
var pageSize = 6;
//获取当前上下文路径
function getContextPath() {
    return window.location.protocol + "//" + window.location.host + "/library"
}
//初始化我的收藏
function personalScInit() {
    ScPaginationInit(pageIndex, pageSize);
}
//我的收藏
var sortsc = "time";
var ordersc = "desc";
function personalSC(sortName, obj) {
    sortsc = sortName;
    ordersc = obj.options[obj.options.selectedIndex].value;
    ScPaginationInit(pageIndex, pageSize);
}
//初始化分页插件
function ScPaginationInit(pageIndex, pageSize) {
    $.post(getContextPath() + "/forehead/personal/topSixData", {
        "sort": sortsc,
        "order": ordersc,
        "pageIndex": pageIndex,
        "pageSize": pageSize
    }, function (data) {
        data = JSON.parse(data);
        $("#Pagination").pagination(data.total, {
            num_edge_entries: 2, //边缘页数
            num_display_entries: 10, //主体页数
            callback: ScPaginationCallback, //回调函数
            items_per_page: pageSize, //每页显示多少项
            prev_text: "<<上一页",
            next_text: "下一页>>"

        });
    });
}
//分页数据回调
function ScPaginationCallback(pageIndex, jq) {
    $.ajax({
        type: "post",
        url: getContextPath() + "/forehead/personal/topSixData",
        data: {"sort": sortsc, "order": ordersc, "pageIndex": pageIndex + 1, "pageSize": pageSize},
        dataType: "json",
        async: true,
        success: function (result) {
            result = result.rows;
            $("#personalSCId").html("");
            var html = "";
            $.each(result, function (i, item) {
                html += '<li style="padding: 3px 10px 35px 10px;"><div class="aa"><a href="' + item.url + '" target="_blank">' + item.title + '</a></div>';
                html += '<div class="txt"><label><span class="t1">作者：</span>' + item.author + '</label><label><span class="t1">时间：</span>' + item.time + '</label><label><span class="t1">来源：</span>' + item.source + '</label></div>';
                html += '<div class="txt">' + item.abstractZY + '</div>';
                html += '<div class="txt" style="float: right;margin-right: 10px;"><a class="layui-btn layui-btn-xs layui-btn-danger" href="#" onclick="scDel(' + item.id + ')"><i class="layui-icon"></i>删除</a></div></li>';
                html += '</li>';
            });
            $("#personalSCId").append(html);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert('error...状态文本值：' + textStatus + " 异常信息：" + errorThrown);
            layer.msg('检索异常!');
        }
    });
}
//删除收藏
function scDel(id) {
    layer.alert('', {
        icon: 2, title: '删除确认', content: '您确定要删除这条记录吗？', closeBtn: 1
    }, function (index) {
        //business logic
        $.post(getContextPath() + "/forehead/personal/scdelete", {id: id}, function (data) {
            layer.msg(data.msg, {icon: 16, time: 300, shade: [0.5, '#000', true]}, function () {
                ScPaginationInit(pageIndex, pageSize);
            });
        }, "json");
        layer.close(index);
    });
}
