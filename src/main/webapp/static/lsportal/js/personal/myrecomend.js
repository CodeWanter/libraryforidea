/**
 * Created by Mr_Wanter on 2018/8/28.
 */
var rpageIndex = 1;
var pageSizeRecomend = 5;

//初始化我的订阅
function personalRecommendInit() {
    RecomendPaginationInit(rpageIndex, pageSizeRecomend);
}
//我的订阅
function RecomendPaginationInit(rpageIndex, pageSizeRecomend) {
    $.get("http://115.29.2.102:7007/api/search?source=baidu&q=" + $("#industry2 option:selected").val() + "&page=" + pageIndex + "&pageSize=" + pageSizeRecomend + "", {}, function (data) {
        data = JSON.parse(data);
        var total = data.total;
        if (data.total > 100) {
            total = 100;
        }
        $("#RecomendPagination").pagination(total, {
            num_edge_entries: 2, //边缘页数
            num_display_entries: 10, //主体页数
            callback: recomendPaginationCallback, //回调函数
            items_per_page: pageSizeRecomend, //每页显示多少项
            prev_text: "<<上一页",
            next_text: "下一页>>"

        });
    });
}
//分页数据回调
function recomendPaginationCallback(rpageIndex, jq) {
    var index;
    $.ajax({
        type: "post",
        url: "http://115.29.2.102:7007/api/search?source=baidu&q=" + $("#industry2 option:selected").val() + "&page=" + rpageIndex + 1 + "&pageSize=" + pageSizeRecomend + "",
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
            $("#recomendList").html("");
            $.each(result, function (i, item) {
                var html = "";
                html += '<li><div class="aa"><a href="http://2018.lsnetlib.com:7007' + item.url + '" target="_blank">' + item.title + '</a></div>';
                html += '<div class="txt"><label><span class="t1">时间：</span>' + item.timeStr + '</label><label><span class="t1">来源：</span>' + item.publisher + '</label></div>';
                html += '<div class="txt">' + item.desc + '</div>';
                html += '</li>';
                $("#recomendList").append(html);
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg('检索异常!');
        }
    });
}

