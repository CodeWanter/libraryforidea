/**
 * Created by huangjunqing on 2018/8/28.
 */
//获取当前上下文路径
function getContextPath() {
    return window.location.protocol + "//" + window.location.host + "/library"
}
//初始化最新资源
function newResourseInit() {
    $.ajax({
        type: "post",
        url: getContextPath() + "/forehead/personal/getNewResourse",
        dataType: "json",
        async: true,
        success: function (data) {
            $("#newResourceId").html("");
            $.each(data, function (i, item) {
                var html = "";
                html += '<li><div class="aa"><a href="http://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=' + item.DBCode + '&dbname=' + item.DBName + '&filename=' + item.FileName + '" target="_blank">' + item.FileTitle + '</a></div>';
                html += '<div class="txt"><label><span class="t1">时间：</span>' + item.UpdateDate + '</label><label><span class="t1">来源：</span>《' + item.JournalName + '》</label></div>';
                html += '<div class="txt">' + item.Summary + '</div>';
                html += '</li>';
                $("#newResourceId").append(html);
            });
        }
    });
}

