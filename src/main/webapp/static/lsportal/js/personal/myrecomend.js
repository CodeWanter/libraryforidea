/**
 * Created by Mr_Wanter on 2018/8/28.
 */
var rpageIndex = 1;
var pageSize = 10;

//初始化我的订阅
function personalRecommendInit() {
    RecomendPaginationInit(rpageIndex, pageSize);
}
//我的订阅
function RecomendPaginationInit(rpageIndex, pageSize) {
    $.get("http://115.29.2.102:7007/api/search?source=baidu&q=" + $("#industry2 option:selected").val() + "&page=" + pageIndex + "&pageSize=" + pageSize + "", {}, function (data) {
        data = JSON.parse(data);
        var total = data.total;
        if (data.total > 100) {
            total = 100;
        }
        $("#RecomendPagination").pagination(total, {
            num_edge_entries: 2, //边缘页数
            num_display_entries: 10, //主体页数
            callback: recomendPaginationCallback, //回调函数
            items_per_page: pageSize, //每页显示多少项
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
        url: "http://115.29.2.102:7007/api/search?source=baidu&q=" + $("#industry2 option:selected").val() + "&page=" + rpageIndex + 1 + "&pageSize=" + pageSize + "",
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
                html += '<tr><td><a  href="http://115.29.2.102:7007' + item.url + '" target="_blank">' + item.title + '</a></td>';
                html += '<td>' + item.timeStr + '</td>';
                html += '<td>' + item.publisher + '</td>';
                html += '<td><div class="txt">' + item.desc + '</div></td>';
                html += '</tr>';
                $("#recomendList").append(html);
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.msg('检索异常!');
        }
    });
}

