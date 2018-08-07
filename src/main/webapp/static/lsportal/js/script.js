$(function () {
    var tophtml = "<div id=\"izl_rmenu\" class=\"izl-rmenu\"><div class=\"btn btn-phone\"></div><div class=\"btn btn-top\"  ></div></div>";
    $("#top").html(tophtml);
    $("#izl_rmenu").each(function () {
        $(this).find(".btn-phone").mouseenter(function () {
            $(this).find(".phone").fadeIn("fast");
        });
        $(this).find(".btn-phone").mouseleave(function () {
            $(this).find(".phone").fadeOut("fast");
        });
    });

});