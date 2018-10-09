$('.qikan').mouseover(function () {
    $(this).addClass('aui-current').siblings().removeClass('aui-current');
    $(".qikan-t").css("display", "block");
});
$(".qikan").mouseout(function () {
    $(".qikan-t").css("display", "none");
});