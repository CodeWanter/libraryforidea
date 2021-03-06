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
        $("#OrderPagination").pagination(data.total, {
            num_edge_entries: 2, //边缘页数
            num_display_entries: 10, //主体页数
            callback: orderPaginationCallback, //回调函数
            items_per_page: pageSize, //每页显示多少项
            prev_text: "<<上一页",
            next_text: "下一页>>"

        });
    },"json");
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
                    html += '<li style="padding: 3px 10px 35px 10px;"><div class="aa">' + item.defineName + '<span style="float: right;margin-right: 10px;"><i>' + item.createTime.substr(0, 10) + '</i></span></div>';
                    html += '<div class="txt">' + item.abstractInfo + '</div>';
                    html += '<div class="txt" style="float: right;margin-right: 10px;"><a class="layui-btn layui-btn-xs layui-btn-normal" href="http://2018.lsnetlib.com:7007' + item.url + '" target="_blank"><i class="layui-icon"></i>检索</a>&nbsp&nbsp<a class="layui-btn layui-btn-xs layui-btn-danger" href="#" onclick="orderDel(' + item.id + ')"><i class="layui-icon"></i>删除</a></div></li>';
                });
                $("#personalOrderId").html(html);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert('error...状态文本值：' + textStatus + " 异常信息：" + errorThrown);
                layer.msg('检索异常!');
            }
        });
}

//删除订阅
function orderDel(id){
    layer.alert('',{
        icon:2,title:'删除确认',content:'您确定要删除这条记录吗？',closeBtn:1},function(index){
        //business logic
        $.post(getContextPath()+"/forehead/personal/orderdelete",{id:id},function(data){
            layer.msg(data.msg, {icon: 16,time: 300,shade : [0.5 , '#000' , true]},function(){
                OrderPaginationInit(pageIndex, pageSize);
            });
        },"json");
        layer.close(index);
    });

}
