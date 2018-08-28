/**
 * Created by Mr_Wanter on 2018/8/28.
 */
var pageIndex = 1;
var pageSize = 6;
//获取当前上下文路径
function getContextPath() {
    return window.location.protocol + "//" + window.location.host+ "/library"
}
//初始化我的订阅
function personalOrderInit(){
    OrderPaginationInit(pageIndex, pageSize);
}
//我的订阅
var sort="createTime";
var order = "desc";
function personalOrder(sortName,obj) {
    sort = sortName;
    order = obj.options[obj.options.selectedIndex].value;
    OrderPaginationInit(pageIndex, pageSize);
}

function OrderPaginationInit(pageIndex, pageSize) {
    $.post(getContextPath()+"/forehead/personal/orderlistdata", {
        "sort":sort,
        "order":order,
        "pageIndex": pageIndex,
        "pageSize": pageSize
    }, function (data) {
        data = JSON.parse(data);
        $("#OrderPagination").pagination(data.total, {
            num_edge_entries: 2, //边缘页数
            num_display_entries: 10, //主体页数
            callback: orderPaginationCallback, //回调函数
            items_per_page: pageSize, //每页显示多少项
            prev_text: "<<上一页",
            next_text: "下一页>>"

        });
    });
}
//分页数据回调
function orderPaginationCallback(pageIndex, jq) {
        $.ajax({
            type: "post",
            url: getContextPath()+"/forehead/personal/orderlistdata",
            data: {"sort":sort,"order":order, "pageIndex": pageIndex+1, "pageSize": pageSize},
            dataType: "json",
            async: true,
            beforeSend: function () {
                //index = layer.load(1);
            },
            complete: function () {
            },
            success: function (result) {
                //layer.close(index);
                result = result.rows;
                $("#List").html("");
                var html = "";
                $.each(result, function (i, item) {
                    html += '<tr><td><a href="#">'+item.defineName+'</a></td><td>' + item.createTime.substr(0,10) + '</td><td>'+item.abstractInfo+'</td><td><a class="a1" href="' + item.url + '">检索</a><a class="a2" href="#">删除</a></td></tr>';
                });
                $("#personalOrderId").html(html);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert('error...状态文本值：' + textStatus + " 异常信息：" + errorThrown);
                layer.msg('检索异常!');
            }
        });
}
