/**
 * Created by huangjunqing on 2018/8/28.
 */
var pageIndex = 1;
var pageSize = 6;
var sortcd = "create_time";
var ordercd = "";
//获取当前上下文路径
function getContextPath() {
    return window.location.protocol + "//" + window.location.host + "/library"
}
//初始化我的收藏
function personalDeliverInit() {
    DeliverPaginationInit(pageIndex, pageSize);
}
//初始化分页插件
function DeliverPaginationInit(pageIndex, pageSize) {
    $.post(getContextPath() + "/forehead/personal/deliverlistdata", {
        "sort": sortcd,
        "order": ordercd,
        "pageIndex": pageIndex,
        "pageSize": pageSize
    }, function (data) {
        data = JSON.parse(data);
        $("#DeliverPagination").pagination(data.total, {
            num_edge_entries: 2, //边缘页数
            num_display_entries: 10, //主体页数
            callback: DeliverPaginationCallback, //回调函数
            items_per_page: pageSize, //每页显示多少项
            prev_text: "<<上一页",
            next_text: "下一页>>"

        });
    });
}
//分页数据回调
function DeliverPaginationCallback(pageIndex, jq) {
    $.ajax({
        type: "post",
        url: getContextPath() + "/forehead/personal/deliverlistdata",
        data: {"sort": sortcd, "order": ordercd, "pageIndex": pageIndex + 1, "pageSize": pageSize},
        dataType: "json",
        async: true,
        success: function (result) {
            result = result.rows;
            $("#personalDeliverId").html("");
            var html = "";
            $.each(result, function (i, item) {
                html += '<li><div class="aa">' + item.title + '</div>';
                html += '<div class="txt"><label><span class="t1"></span>' + item.author + '</label><label><span class="t1"></span>' + item.publishTime + '</label>';
                html += '<label><span class="t1"></span>' + item.email + '</label><label><span class="t1"></span>' + item.name + '</label>';
                html += '<label><span class="t1"></span>' + item.tel + '</label><label><span class="t1"></span>' + item.address + '</label>';
                html += '<label><span class="t1"></span>' + item.zCode + '</label></div>';
                if (item.message != "") {
                    html += '<div class="txt"><span class="t1">留言：</span>' + item.message + '';
                }
                html += '</div></li>';
            });
            $("#personalDeliverId").append(html);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert('error...状态文本值：' + textStatus + " 异常信息：" + errorThrown);
            layer.msg('检索异常!');
        }
    });
}

