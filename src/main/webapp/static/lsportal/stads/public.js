var postUrl = "http://webstads.sciinfo.cn/";
var colors = ["#12a7bb", "#fdd7ad", "#72db99", "#f3bd52", "#f39352", "#1268bb", "#3ec3d5", "#7fece3", "#d1af10", "#7bb9f3"];
var app = isApp();
var appExport = ".zhuanjia";
var exports = ".zj";//保存是否为专家
function setThreeNumber(number) {
    localStorage.setItem("threeNumber", number);
}
function getThreeNumber() {
    return localStorage.getItem("threeNumber");
}

$(".disabled_bg").click(function () {
    return;
});

//添加专家输入框推荐机构事件
$(function () {
    //专家名表改变获取机构
    $("#expertInfo").keyup(function (e) {
        if (e.keyCode == 13) {
            heightSearch(2);
        }
        autoOrgs();
    })
    $(".dialogChildCenter input").keyup(function (e) {
        if (e.keyCode == 13) {
            $(this).next().click();
        }
    });
    //机构名联想
    $("#orgName").keyup(function (e) {
        if (e.keyCode == 13) {
            heightSearch(3);
        }
        var query = $("#orgName").val();
        var word = "org";
        var div = $("#orgNames");
        var div2 = $("#orgName");
        associate(query, word, div, div2, backOrg);
    })
    //主题词联想
    $("#ckeyName").keyup(function (e) {
        if (e.keyCode == 13) {
            heightSearch(1);
        }
        var query = $("#ckeyName").val();
        var word = "ckey";
        var div = $("#ckeyNames");
        var div2 = $("#ckeyName");
        associate(query, word, div, div2, backCkey);
    })
})
function showAssociate(div) {
    div.css("display", "block");
}
//隐藏推荐机构
function hideAssociate(div) {
    div.css("display", "none");
}
//点击后选取推荐值
function selectAssociate(title, div, div2) {
    var selects = title;
    div2.val(title);
    hideAssociate(div);
}
function backOrg(data, div, div2) {
    if (data.length > 0) {
        showAssociate(div);
        div.html(data);
        $("#orgNames li").click(function () {
            var title = $(this).find("a").html();
            selectAssociate(title, div, div2);
        });
    }
    else {
        hideAssociate(div)
    }
}
function backCkey(data, div, div2) {
    if (data.length > 0) {
        showAssociate(div);
        div.html(data);
        $("#ckeyNames li").click(function () {
            var title = $(this).find("a").html();
            selectAssociate(title, div, div2);
        });
    }
    else {
        hideAssociate(div)
    }
}
/**
 * 自动显示机构信息
 */
function autoOrgs() {
    var search = $("#expertInfo").val() || "";
    if (search == "") {
        $("#search_orgs").html("");
        $("#search_orgs").css("display", "none");
        return;
    }
    if (search.length < 1) {
        return;
    }
    if (isStrip(search)) {
        alert("对不起，检索词中包含非法字符！");
        return;
    }
    $("#select_orgs").html("");
    var url = $("#url").val() + "/stads.do?getOrg";
    $.ajax({
        url: url,
        type: "post",
        datatype: "json",
        data: {
            "search": search,
            "pageNo": 0,
            "pageSize": 10
        },
        success: function (data1) {
            $(".cxzs_name_Analysis").css({"z-index": "3"});
            var data = eval('(' + data1 + ')');
            if (data.length > 0) {
                $("#search_orgs").css("display", "block");
                $("#search_orgs").html(data);
                $("#search_orgs li").click(function () {
                    var check = $(this).find("a").attr("class");
                    if (check == "check") {
                        $(this).find("a").removeClass("check");
                        $(this).find("a").attr("name", "");
                    } else {
                        $(this).find("a").addClass("check");
                        $(this).find("a").attr("name", "ORgNameChoiced");
                    }
                });
            }
        }
    });
}

function associate(query, word, div, div2, callback) {
    if (query == "") {
        return;
    }
    if (query.length < 1) {
        return;
    }
    if (isStrip(query)) {
        alert("对不起，检索词中包含非法字符！");
        return;
    }
    div.html("");
    var url = $("#url").val() + "/stads.do?associate";
    $.ajax({
        url: url,
        type: "post",
        datatype: "json",
        data: {'query': query, 'word': word, pageNo: 0, pageSize: 10},
        success: function (data1) {
            var data = eval('(' + data1 + ')');
            callback(data, div, div2);
        },
        error: function () {
            hideAssociate(div);
        }
    });
    /*
     }*/
}
/**
 * 分页
 * @param pageNo 当前显示页数
 * @param pageSize 每页显示多少条数据
 * @param totalCount 一共有多少条数据
 */
function Page(pageNo, pageSize, totalCount) {
    this.pageNo = pageNo;
    this.pageSize = pageSize;
    this.totalCount = totalCount;
    this.totalPageCount = Math.ceil(totalCount / pageSize) - 1;
}
var page = {};
page.orgPage = new Page(0, 10, 0);//
page.ckeyPage = new Page(0, 10, 0);//
/**
 * ajax所有请求
 * @param me 接口名
 * @param data 所需要发送的数据
 * @param callback 回调函数
 */
function ajaxcall(me, data, callback) {
    $.ajax({
        url: url + me,
        data: data,
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        success: callback
    });
}
function ajaxPost(me, data, callback) {
    $.ajax({
        url: me,
        data: data,
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        success: callback
    });
}


/**
 * 直接传值姓名和机构
 * @param name
 * @param org
 */
function zjNameAndOrg(name, org) {
    var auIds = "";// name,  org, pageNo, pageSize, auIds, ckeys , type
    ajaxPost(postUrl + "/exportController.do?getExpertInfo", {
        name: encodeURI(name),
        org: encodeURI(org),
        pageNo: 0,
        pageSize: 1,
        auIds: "",
        ckeys: "",
        type: ""
    }, function (result) {
        result = JSON.parse(result);
        auIds = result._ID || "";
        if (result.hits != undefined && result.hits.hits != undefined && result.hits.hits[0] != undefined) {
            result = result.hits.hits[0];
            if (result._ID == undefined) {
                auIds = "";
            }
        } else {
            auIds = "";
        }
        order(name, 2, name, org, auIds, "", "", "", true);
    });
}
/**
 * 设置机构并进行跳转
 * @param orgs 机构名称
 */
function setOrgsLocation(orgs) {
    order(orgs, 1, "", "", "", "", "", orgs, true)
}
/**
 * 普通只有姓名的时候点击跳转
 * @param $this
 */
function zjLocation($this) {
    var name = $($this).text();
    order(name, 2, name, "", "", "", "", "", true);
}
/**
 * swiper插件点击姓名跳转
 * @param $this
 */
function zjSwiperLocation($this) {
    var name = $($this).text();
    var org = $($this).parent().next().next().text();
    var auid = $($this).parent().next().next().attr("data-auid") || "";
    if (org == "-") {
        org = "";
    }
    order(name, 2, name, org, auid, "", "", "", true);
}
/**
 * 普通表格点击姓名跳转
 * @param $this
 */
function zjTableLocation($this) {
    var name = $($this).text();
    var org = $($this).next().text();
    if (org == "-") {
        org = "";
    }
    var auid = $($this).next().attr('data-auid') || "";
    order(name, 2, name, org, auid, "", "", "", true);
}
/**
 * 点击主题关键词直接进行检索
 * @param ckeys 检索主题关键词
 */
function searchCkey(ckeys) {
    order(ckeys, 3, "", "", "", ckeys, "", "", true);
}

//调用二维码方法
function ewm(orgs, title, query, stype, ckeys, type) {
    if (app) {
        //hideJqueryModalPlug("#demoModal1");
        //hideJqueryModalPlug("#demoModal2");
        //showJqueryModalPlug("#demoModal4",{"top":"100","hide":true});
    } else {
        //hideJqueryModalPlug("#demoModal1");
        showJqueryModalPlug("#demoModal2", {"top": "100", "hide": true});
        $("#erweima").html("");
        weixinpay(orgs, title, query, stype, ckeys, type);
        ddsyntony = false;
        var timeSet = setInterval(function () {
            if (!ddsyntony) {
                syntony(orgs, title, query, stype);
            } else {
                window.clearInterval(timeSet);
            }
        }, 500);
    }
}


/**
 * 忽略直接提交
 */
function ignoreSubmits() {
    if (exports == ".zj") {
        var $name = $("#cxzs_search input[name='name']");//获取用户输入的信息，并显示到弹框中的 学者姓名后面
        if ($name.val() == "" || $name.val() == " ") {
            alert("请输入专家姓名！");
            return false;
        }
        var orgsCheck = $('*[name="ORgNameChoiced"]');//获取所有用户选中的机构名称
        var orgs = "";
        var auid = "";
        for (var i = 0; i < orgsCheck.length; i++) {//把用户选择的机构显示到已选中机构中
            orgs += $(orgsCheck[i]).text() + "|";
            if ($(orgsCheck[i]).attr("data-auid") != "") {
                auid += $(orgsCheck[i]).attr("data-auid") + "|";
            }
        }
        orgs = orgs.substring(0, orgs.length - 1);
        if (auid.length != 0) {
            auid = auid.substring(0, auid.length - 1);
        }
        order($name.val(), 2, $name.val(), orgs, auid, "", "", "", false)
    } else {
        var $org = $("#cxzs_search input[name='org']");
        order($org.val(), 1, "", "", "", "", "", $org.val(), false)
    }
}

/**
 * 获取当前已经选中的机构
 * @return 数组
 */
function getSelectOrgs() {
    var $orgsArr = $(exports + " .selectOrgs li");
    var orgs = [];
    if ($orgsArr.length != 0) {
        for (var i = 0; i < $orgsArr.length; i++) {
            orgs.push($($orgsArr[i]).text());
        }
    }
    return orgs;
}
/**
 * 推荐机构上一页下一页
 * 根据条件是 如果是知机构则根据选中机构进行检索
 *         如果是懂专家则根据学者姓名进行检索
 * @param prevNext 上一页按钮或下一页按钮
 */
function orgPagerPrevNext(prevNext) {
    var $namesArr = returnNames();
    if ($namesArr.length != 0) {
        var $names = "";
        for (var i = 0; i < $namesArr.length; i++) {
            $names += $namesArr[i] + "|";
        }
        $names = $names.substring(0, $names.length - 1);
        ajaxPost(postUrl + "/stads.do?nameOrCkey", {
            name: encodeURI($names),
            orgs: "",
            pageSize: page.orgPage.pageSize,
            pageNo: page.orgPage.pageNo
        }, function (result) {
            if (result.orgs != undefined && result.orgs.length != 0) {
                showOrg(result.orgs);//显示推荐机构
            } else {
                $(exports + " .onSelectOrgs").html("<li>暂无数据 </li>");
            }
        });//请求数据请求推荐机构和技术点
    } else {
        if (exports == ".jg") {
            var $orgs = getSelectOrgs();
            if ($orgs.length != 0) {
                var orgs = "";
                for (var i = 0; i < $orgs.length; i++)
                    orgs += orgs[i] + "|";
                orgs = orgs.substring(0, orgs.length - 1);
                ajaxPost(postUrl + "/stads.do?nameOrCkey", {
                    name: "",
                    orgs: encodeURI(orgs),
                    pageSize: page.orgPage.pageSize,
                    pageNo: page.orgPage.pageNo
                }, function (result) {
                    if (result.orgs != undefined && result.orgs.length != 0) showOrg(result.orgs);//显示推荐机构
                    else $(exports + " .onSelectOrgs").html("<li>暂无数据 </li>");
                });//请求数据请求推荐机构和技术点
            } else {
                alert("请选中机构!");
            }
        } else {
            alert("请输入专家姓名!");
        }
    }
    if (prevNext == "next") {
        if (page.orgPage.pageNo - 1 >= 0) $(exports + " .showOrg .page_public_right").css({"display": "block"});
        else $(exports + " .showOrg .page_public_right").css({"display": "none"});
    } else {
        if (page.orgPage.pageNo + 1 < page.orgPage.totalPageCount) $(exports + " .showOrg .page_public_left").css({"display": "block"});
        else $(exports + " .showOrg .page_public_left").css({"display": "none"});
    }
}

/**
 *
 * @param prevNext 上一页按钮或下一页按钮
 */
function ckeyPagerPrevNext(prevNext) {
    var orgs = "";
    var auids = "";
    //获取选中机构(知机构|懂专家)
    $(exports + " .orgRecommend li").each(function () {
        orgs += $(this).attr("data-text") + "|";
        if ($(this).attr("data-auid") != "") {
            auids += $(this).attr("data-auid") + "|";
        }
    });
    orgs = orgs.substring(0, orgs.length - 1);
    if (auids.length != 0) {
        auids = auids.substring(0, auids.length - 1);
    }
    var $names = returnNames();//获取所有学者名字
    var $name = "";//拼接学者姓名
    for (var i = 0; i < $names.length; i++) {
        $name += $names[i] + "|";
    }
    $(exports + " .onSelectSubjects").html("<li>加载中...</li>");
    if (exports == ".zj") {
        ajaxPost(postUrl + "/stads.do?nameOrCkey", {
            name: encodeURI($name.substring(0, $name.length - 1)),
            orgs: encodeURI(orgs),
            pageSize: page.ckeyPage.pageSize,
            pageNo: page.ckeyPage.pageNo
        }, function (result) {//请求数据请求推荐机构和技术点
            if (result.ckeys != undefined && result.ckeys.length != 0) {
                showCkey(result.ckeys);
            } else {
                $(exports + " .onSelectSubjects").html("<li>暂无数据</li>");
            }
        });
    } else {
        ajaxPost(postUrl + "/stads.do?nameOrCkey", {
            orgs: encodeURI(orgs),
            pageSize: page.ckeyPage.pageSize,
            pageNo: page.ckeyPage.pageNo
        }, function (result) {//请求数据请求推荐机构和技术点
            if (result.ckeys != undefined && result.ckeys.length != 0) {
                showCkey(result.ckeys);
            } else {
                $(exports + " .onSelectSubjects").html("<li>暂无数据</li>");
            }
        });
    }
    if (prevNext == "next") {
        if (page.orgPage.pageNo - 1 >= 0) {//给当前页-1
            $(exports + " .showCkey .page_public_right").css({"display": "block"});
        } else {
            $(exports + " .showCkey .page_public_right").css({"display": "none"});
        }
    } else {
        if (page.orgPage.pageNo + 1 < page.orgPage.totalPageCount) {
            $(exports + " .showCkey .page_public_left").css({"display": "block"});
        } else {
            $(exports + " .showCkey .page_public_left").css({"display": "none"});
        }
    }
}
/**
 * 点击上一页或者下一页
 * @param subjectOrg 点击机构还是技术点
 * @param prevNext 上一页还是下一页
 */
function orgSubjectPages(subjectOrg, prevNext) {
    if (subjectOrg == "org" && prevNext == "prev") {//如果是机构并且是上一页
        $(exports + " .onSelectOrgs").html("<li>加载中...</li>");
        page.orgPage.pageNo -= 1;
        if (page.orgPage.pageNo < 0) {//给当前页-1
            page.orgPage.pageNo = 0;
        }
        orgPagerPrevNext("prev");
    } else if (subjectOrg == "org" && prevNext == "next") {//如果是机构并且是下一页
        $(exports + " .onSelectOrgs").html("<li>加载中...</li>");
        page.orgPage.pageNo += 1;
        if (page.orgPage.pageNo > page.orgPage.totalPageCount) {
            page.orgPage.pageNo = page.orgPage.totalPageCount;
        }
        orgPagerPrevNext("next");
    } else if (subjectOrg == "subject" && prevNext == "prev") {//如果是技术点并且是上一页
        $(exports + " .onSelectSubjects").html("<li>加载中...</li>");
        page.ckeyPage.pageNo -= 1;
        if (page.ckeyPage.pageNo < 0) {//给当前页-1
            page.ckeyPage.pageNo = 0;
        }
        ckeyPagerPrevNext("prev");
    } else if (subjectOrg == "subject" && prevNext == "next") {//如果是技术点并且是下一页
        $(exports + " .onSelectSubjects").html("<li>加载中...</li>");
        page.ckeyPage.pageNo += 1;
        if (page.ckeyPage.pageNo > page.ckeyPage.totalPageCount) {
            page.ckeyPage.pageNo = page.ckeyPage.totalPageCount;
        }
        ckeyPagerPrevNext("next");
    }
}
/**
 * 询证显示高级检索
 */
function heightSearch(number) {
    $("#dialog").css({
        "height": document.body.scrollHeight
    });
    userIf();
    if (number == 1) {
        var $ckey = $("#cxzs_search input[name='ckey']");
        if ($ckey.val().length == 0 || $ckey.val() == " ") {
            alert("请输入技术关键词,然后进行搜索！");
            return false;
        } else {
            order($ckey.val(), 3, "", "", "", $ckey.val(), "", "", false)
        }
    }
    if (app) {
        if (number == 2) {
            var names = $("#cxzs_search input[name='name']");
            if (names.val().length == 0 || names.val() == " ") {
                alert("专家名不能为空！");
                return false;
            } else {
                appExport = ".zhuanjia";
                exports = ".zj";
                showExportDialog();
            }
        } else if (number == 3) {
            var $org = $("#cxzs_search input[name='org']");
            if ($org.val().length == 0 || $org.val() == " ") {
                alert("机构名称不能为空！");
                return false;
            } else {
                appExport = ".jigou";
                exports = ".jg";
                showOrgDialog();
            }
        }
    } else {
        if (number == 2) {
            var names = $("#cxzs_search input[name='name']");
            if (names.val().length == 0 || names.val() == " ") {
                alert("专家名不能为空！");
                return false;
            } else {
                appExport = ".zhuanjia";
                exports = ".zj";
                showExportDialog();
            }
        } else if (number == 3) {
            var $org = $("#cxzs_search input[name='org']");
            if ($org.val().length == 0 || $org.val() == " ") {
                alert("机构名称不能为空！");
                return false;
            } else {
                appExport = ".jigou";
                exports = ".jg";
                showOrgDialog();
            }
        }
    }
}

/**
 * 询证提交事件
 * @param choose
 * @param flag true表示按照高级检索搜索   false按照正常用户输入和选择进行检索
 */
function submits() {
    var orgs = "", auids = "", subjects = "", types = "", names = "";
    if (app) {
        //获取选中机构(知机构|懂专家)
        /*$(appExport+" .appOrgs li.appActiveReCommend").each(function(){
         orgs+=$(this).attr("data-text")+"|";
         if($(this).attr("data-auid")!=""){
         auids+=$(this).attr("data-auid")+"|";
         }
         });
         orgs=orgs.substring(0,orgs.length-1);//去除最后一个|
         if(auids.length!=0){
         auids=auids.substring(0,auids.length-1);
         }*/
        //获取选中技术点(知机构|懂专家)
        var selectOrg = sessionStorage.getItem("selectOrg");
        var selectCkey = sessionStorage.getItem("selectCkey");
        if (appExport == ".zhuanjia") {
            //获取姓名
            $(appExport + " .names span").each(function () {
                names += $(this).text() + "|";
            });
            names = names.substring(0, names.length - 1);
            order(names, 2, names, selectOrg, sessionStorage.getItem("selectAuids"), selectCkey, types, "", false)
        } else {
            order(selectOrg, 1, "", "", "", selectCkey, types, selectOrg, false)
        }
    } else {
        //获取选中机构(知机构|懂专家)
        $(exports + " .orgRecommend li").each(function () {
            orgs += $(this).attr("data-text") + "|";
            if ($(this).attr("data-auid") != "") {
                auids += $(this).attr("data-auid") + "|";
            }
        });
        orgs = orgs.substring(0, orgs.length - 1);//去除最后一个|
        if (auids.length != 0) {
            auids = auids.substring(0, auids.length - 1);
        }
        //获取选中技术点(知机构|懂专家)
        $(exports + " .subjectRecommend li").each(function () {
            subjects += $(this).attr("data-text") + "|";
        });
        subjects = subjects.substring(0, subjects.length - 1);
        //获取技术类型(知机构)
        $(exports + " input[name='sub']").each(function () {
            if ($(this).is(':checked') == true) {
                types += $(this).val();
            }
        });

        if (exports == ".zj") {
            //获取姓名
            $(exports + " .names span").each(function () {
                names += $(this).text() + "|";
            });
            names = names.substring(0, names.length - 1);
            //显示订单信息
            order(names, 2, names, orgs, auids, subjects, "", "", false)
        } else {
            order(orgs, 1, "", "", "", subjects, "", orgs, false)
        }
    }
}

/**
 * 显示专家高级检索窗口
 */
function showDialog() {
    if (app) {
        $("#appDialog").css({"display": "block", "z-index": "11"}).animate({
            "opacity": "1"
        }, 500);
    } else {
        $("#dialog").css({"display": "block", "z-index": "11"}).animate({
            "opacity": "1"
        }, 500);
    }
}

/**
 * 隐藏专家高级检索窗口
 */
function closeDiaLog() {
    if (app) {
        $("#appDialog").animate({
            "opacity": "0"
        }, 500, function () {
            $("#appDialog").css({"display": "none", "z-index": "0"});
        });
    } else {
        $("#dialog").animate({
            "opacity": "0"
        }, 500, function () {
            $("#dialog").css({"display": "none", "z-index": "0"});
        });
    }
}

/**
 * 显示专家高级检索窗口
 */
function showExportDialog() {
    clearSubmits();//清空dialog里面的内容
    var $name = $("#cxzs_search input[name='name']");//获取用户输入的信息，并显示到弹框中的 学者姓名后面
    if ($name.val() == "" || $name.val() == " ") {
        alert("请输入专家姓名！");
        return false;
    }
    showNames($name.val());//把当前用户输入的信息显示到页面中
    var $names = returnNames();//获取所有学者名字

    var nameStr = "";//nameStr格式:吴广印|甘大广
    for (var i = 0; i < $names.length; i++) {
        nameStr += $names[i] + "|";
    }

    var orgsCheck = $('*[name="ORgNameChoiced"]');//获取所有用户选中的机构名称
    var str = "";
    var orgs = "";
    var auids = "";

    //把用户选择的机构显示到已选中机构中
    for (var i = 0; i < orgsCheck.length; i++) {
        var text = $(orgsCheck[i]).text();
        orgs += text + "|";
        if (text.length > 15) {
            text = text.substring(0, 15) + "...";
        }
        var auid = $(orgsCheck[i]).attr("data-auid") || "";
        if (auid != "") {
            auids += auid + "|";
        }
        str += "<li data-auid='" + auid + "' data-text='" + $(orgsCheck[i]).text() + "'>" + text + "<img src='static/images/closeRemove.png' onclick='closeOrg(this)' alt=''></li>"
    }
    if (!app) {
        $("#selectOrgs").html(str);
    }
    auids.substring(0, auids.length - 1);
    orgs = orgs.substring(0, orgs.length - 1);
    sessionStorage.setItem("selectOrg", orgs);//把当前已经选中的机构保存到会话
    sessionStorage.setItem("selectAuids", auids);//把当前已经选中的机构保存到会话
    nameStr = nameStr.substring(0, nameStr.length - 1);


    ajaxPost(postUrl + "/stads.do?nameOrCkey", {
        name: encodeURI(nameStr),
        orgs: encodeURI(sessionStorage.getItem("selectOrg")),
        auIds: encodeURI(sessionStorage.getItem("selectAuids")),
        pageSize: page.ckeyPage.pageSize,
        pageNo: page.ckeyPage.pageNo
    }, showExportDialogInfo);//请求数据请求推荐机构和技术点
    //$(".names").html("<span>"+$name.val()+"<img src='static/images/closesmall.png' onclick='closeName(this)'/></span>");//把当前用户输入的信息显示到页面中
    showDialog();//显示dialog
    if (app) {
        $(".zhuanjia").css({
            "display": "block"
        });
        $(".jigou").css({
            "display": "none"
        });
    } else {
        $(".zj").css({
            "display": "block"
        });
        $(".jg").css({
            "display": "none"
        });
    }
}
/**
 * 清除所有高级检索内容
 */
function clearSubmits() {
    if (app) {
        $(".appCkeys").html("<li>正在加载数据...</li>");
        $(".appOrgs").html("<li>正在加载数据...</li>");
        sessionStorage.setItem("selectOrg", "");
        sessionStorage.setItem("selectAuids", "");
        sessionStorage.setItem("selectCkey", "");
    } else {
        $(".onActive").html("");
        $(".onSubActive").html("");
        $(".recommend").html("");
        $(".names").html("");
        $("input[name='sub']").prop("checked", false);
    }
}
/**
 * 获取学者名字的所有名字
 * @return arr 返回所有名字
 */
function returnNames() {
    var $names;
    if (app) {
        $names = $(appExport + " .names span");
    } else {
        $names = $(exports + " .names span");
    }
    var namesArr = [];
    for (var i = 0; i < $names.length; i++) {
        namesArr.push($($names[i]).text());
    }
    return namesArr;
}
/**
 * 关闭学者名字
 * @param $this
 */
function closeName($this) {
    $this = $($this);
    $this.parent().remove();
    addOrRemoveName();
}
/**
 * 添加或者移除学者姓名
 */
function addOrRemoveName() {
    var $names = returnNames();//获取所有学者名字
    var $name = "";//拼接学者姓名
    for (var i = 0; i < $names.length; i++) {
        $name += $names[i] + "|";
    }
    $(exports + " .onSelectOrgs").html("<li>加载中...</li>");
    $(exports + " .onSelectSubjects").html("<li>加载中...</li>");
    ajaxPost(postUrl + "/stads.do?nameOrCkey", {
        name: encodeURI($name.substring(0, $name.length - 1)),
        orgs: encodeURI(''),
        pageSize: page.ckeyPage.pageSize,
        pageNo: page.ckeyPage.pageNo
    }, showExportDialogInfo);//请求数据请求推荐机构和技术点
}
/**
 * 向学者名字中添加名字
 */
function pushNames() {
    var $pushNames = $(".pushNames input[name='pushNames']");
    if ($pushNames.val() != "" && $pushNames.val() != undefined && $pushNames.val() != null && $pushNames.val() != "null" && $pushNames.val() != "undefined") {
        var names = returnNames();
        var flag = true;//默认没有重复可以添加
        for (var i = 0; i < names.length; i++) {
            if (names[i] == $pushNames.val()) flag = false;
        }
        if (flag) {
            showNames($pushNames.val());
            $pushNames.val("");
        } else {
            alert("不可以重复添加姓名!");
        }
    } else {
        alert("添加姓名不能为空!");
        return;
    }
}
/**
 * 显示学者名字，推荐英文
 * @param name 用戶輸入的姓名
 * @param ele 需要显示到的位置(手机端和pc端显示的父容器不一样)
 */
function showNames(name) {
    var nameArr = name.split(" OR ");
    for (var i = 0; i < nameArr.length; i++) {
        $.ajax({
            url: postUrl + "/exportController.do?NameToEn",
            method: "post",
            async: false,
            data: {
                name: encodeURI(nameArr[i])
            },
            success: function (result) {
                result = JSON.parse(result);
                var str = "";
                if (result != undefined && result.length != 0) {
                    for (var i = 0; i < result.length; i++) {
                        str += "<span>" + result[i] + "<img src='static/images/closesmall.png' alt='' onclick='closeName(this)'></span>";
                    }
                } else {
                    str += "<span>" + name + "<img src='static/images/closesmall.png' alt='' onclick='closeName(this)'></span>";
                }
                if (app) {
                    $(appExport + " .names").append(str);
                } else {
                    $(exports + " .names").append(str);
                }
            }
        });
        addOrRemoveName();//添加学者姓名刷新推荐机构和技术点
    }
}
/**
 * 删除姓名栏目
 * @param $this
 */
function closeParent($this) {
    $this = $($this).parent();
    $this.parent().parent().prev().prev().find("ul").append("<li data-text='" + $this.attr("data-text") + "' data-auid='" + $this.attr("data-auid") + "' ondblclick='pushReCommends(this)' onclick='activeReCommends(this)'>" + $this.attr("data-text") + "</li>");
    $this.remove();
}

/**
 * 显示推荐机构
 * @param result 推荐机构数组
 */
function showOrg(result) {
    if (result.length != 0) {
        var str = "";
        var selectOrgs;
        if (app) {
            selectOrgs = sessionStorage.getItem("selectOrg").split("|");
        } else {
            selectOrgs = $(exports + " .orgRecommend li");
        }
        for (var i = 0; i < result.length; i++) {
            var auid = result[i].auid || '';
            var orgName = result[i].orgName;
            if (app) {
                var a = false;
                for (var j = 0; j < selectOrgs.length; j++) {
                    var t = selectOrgs[j];
                    if (t == orgName) {
                        a = true;
                        break;
                    }
                }
                if (a == true) {
                    str += "<li data-text='" + orgName + "' data-switchs='org' onclick='appRemoveReCommends(this)' data-auid='" + auid + "' class='appActiveReCommend'>" + orgName + "</li>";
                } else {
                    str += "<li data-text='" + orgName + "' data-switchs='org' onclick='appActiveReCommends(this)' data-auid='" + auid + "'>" + orgName + "</li>";
                }
            } else {
                var flag = false;//表示允许添加
                for (var j = 0; j < selectOrgs.length; j++) {
                    if ($(selectOrgs[j]).attr("data-text") == orgName) flag = true
                }
                if (flag == false) str += "<li data-text='" + orgName + "' data-switchs='org' ondblclick='pushReCommends(this)' onclick='activeReCommends(this)' data-auid='" + auid + "'>" + orgName + "</li>";
            }
        }
        app ? $(appExport + " .appOrgs").html(str) : $(exports + " .onSelectOrgs").html(str)
    } else {
        app ? $(appExport + " .appOrgs").html("<li>暂无数据</li>") : $(exports + " .onSelectOrgs").html("<li>暂无数据</li>")
    }
}
/**
 * 显示推荐技术点信息
 * @param result 推荐技术点
 */
function showCkey(result) {
    if (result.length != 0) {
        var str = "";
        if (app) {
            for (var i = 0; i < result.length; i++) {
                str += "<li  data-text='" + result[i] + "' data-switchs='ckey'  onclick='appActiveReCommends(this,\"ckey\")'>" + result[i] + "</li>";
            }
            $(appExport + " .appCkeys").html(str);
        } else {
            for (var i = 0; i < result.length; i++) {
                str += "<li  data-text='" + result[i] + "' data-switchs='ckey' ondblclick='pushReCommends(this)'  onclick='activeReCommends(this)'>" + result[i] + "</li>";
            }
            $(exports + " .onSelectSubjects").html(str);
        }
    } else {
        app ? $(appExport + " .appCkeys").html("<li>暂无数据</li>") : $(exports + " .onSelectSubjects").html("<li>暂无数据</li>")
    }
}
/**
 * 展示机构和技术点信息
 */
function showExportDialogInfo(result) {
    if (result != undefined && result.orgs != undefined && result.subjects != undefined) {
        page.orgPage = new Page(0, 10, result.orgTotalCount);//
        page.ckeyPage = new Page(0, 10, result.ckeyTotalCount);//
        showOrg(result.orgs);
        showCkey(result.subjects);
    } else {
        if (app) {
            $(appExport + " .appOrgs").html("<li>暂无数据 </li>");
            $(appExport + " .appCkeys").html("<li>暂无数据</li>");
        } else {
            $(exports + " .onSelectOrgs").html("<li>暂无数据 </li>");
            $(exports + " .onSelectSubjects").html("<li>暂无数据</li>");
        }
    }
}
/**
 * 显示机构高级检索窗口
 */
function showOrgDialog() {
    clearSubmits();
    var $org = $("#cxzs_search input[name='org']");
    if ($org.val() == "") {
        alert("请输入机构名称！");
        return false;
    }
    var text = $org.val();
    if (text.length > 15) {
        text = text.substring(0, 15) + "...";
    }
    //把用户输入的内容显示到选中机构中
    if (app) {
        $(".jigou").css({
            "display": "block"
        });
        $(".zhuanjia").css({
            "display": "none"
        });
        sessionStorage.setItem("selectOrg", $org.val());//把用户输入信息保存到session中
    } else {
        $(".jg").css({
            "display": "block"
        });
        $(".zj").css({
            "display": "none"
        });
        $("#selectOrgjg").html("<li data-auid='' data-switchs='org' data-text='" + $org.val() + "'>" + text + "<img src='static/images/closeRemove.png' onclick='closeOrg(this)' alt=''></li>");
    }
    ajaxPost(postUrl + "/stads.do?orgOrCkey", {
        name: "",
        org: encodeURI($org.val()),
        pageSize: page.ckeyPage.pageSize,
        pageNo: page.ckeyPage.pageNo
    }, showExportDialogInfo);
    showDialog();
}

/**
 * 手机端吧用户输入内容添加到选中内容
 * @param $this 添加按钮
 */
function appPushReCommend($this) {
    $this = $($this);
    var $inputCommend = $this.prev();//获取按钮前面这个输入框
    var inputText = $inputCommend.val();
    if (inputText != undefined && inputText != null && inputText != "" && inputText != "null" && inputText != "undefined") {
        var reCommendArr = getReCommend($this);
        var flag = true;//默认允许添加
        for (var i = 0; i < reCommendArr.length; i++) {
            if (reCommendArr[i] == inputText) {
                flag = false;
                break;
            }
        }
        if (flag == true) {
            showNames(inputText);//翻译英文名
            $inputCommend.val("");
        } else {
            //error不能重复添加
        }
    } else {
        //error不能为空
    }
}

/**
 * 把用户输入内容添加到选中内容
 * @param $this 添加按钮
 */
function pushReCommend($this) {
    $this = $($this);
    var $inputCommend = $this.prev();//获取按钮前面这个输入框
    var inputText = $inputCommend.val();
    if (inputText != undefined && inputText != null && inputText != "" && inputText != "null" && inputText != "undefined") {
        var reCommendArr = getReCommend($this);
        var flag = true;//默认允许添加
        for (var i = 0; i < reCommendArr.length; i++) {
            if (reCommendArr[i] == inputText) {
                flag = false;
                break;
            }
        }
        if (flag == true) {
            var switchs = $this.attr("data-switchs");
            if (exports == ".jg") {
                if (switchs == "org") {
                    $this.parent().parent().find(".recommend").append("<li data-text='" + $inputCommend.val() + "'  data-switchs='org' data-auid=''>" + $inputCommend.val() + "<img src='static/images/closeRemove.png' onclick='closeOrg(this)' alt=''></li>");
                    addOrRemoveOrg();
                } else {
                    $this.parent().parent().find(".recommend").append("<li data-text='" + $inputCommend.val() + "' data-auid=''>" + $inputCommend.val() + "<img src='static/images/closeRemove.png' onclick='closeParent(this)' alt=''></li>");
                }
                $inputCommend.val("");
            } else {
                if (switchs == "org") {
                    var returnName = returnNames();
                    if (returnName.length == 0) {
                        alert("请先输入检索人姓名");
                        return;
                    }
                    var name = "";
                    for (var i = 0; i < returnName.length; i++) {
                        name += returnName[i] + "|";
                    }
                    name = name.substring(0, name.length - 1);
                    $.ajax({
                        url: postUrl + "/exportController.do?getExpertInfo",
                        method: "post",
                        async: false,
                        data: {
                            name: encodeURI(name),
                            org: encodeURI(inputText),
                            pageNo: 0,
                            pageSize: 1,
                            auIds: "",
                            ckeys: "",
                            type: ""
                        },
                        success: function (result) {
                            result = JSON.parse(result);
                            var auids = "";
                            if (result.hits != undefined && result.hits.hits != undefined && result.hits.hits[0] != undefined && result.hits.hits[0]._ID != undefined) {
                                auids = result.hits.hits[0]._ID || "";
                            }
                            $this.parent().parent().find(".recommend").append("<li data-text='" + $inputCommend.val() + "'  data-switchs='org' data-auid='" + auids + "'>" + $inputCommend.val() + "<img src='static/images/closeRemove.png' onclick='closeOrg(this)' alt=''></li>");
                            addOrRemoveOrg();
                        }
                    });
                } else {
                    $this.parent().parent().find(".recommend").append("<li data-text='" + $inputCommend.val() + "' data-auid=''>" + $inputCommend.val() + "<img src='static/images/closeRemove.png' onclick='closeParent(this)' alt=''></li>");
                }
                $inputCommend.val("");
            }
        } else {
            alert($inputCommend.val() + "已添加,不能重复添加!");
            return;
        }
    } else {
        alert($inputCommend.attr("placeholder"));
    }
}
/**
 * 获取当前按钮前面的选中内容中的所有文本
 * @param $this 当前按钮
 * @returns {Array} 选中内容的所有文本
 */
function getReCommend($this, type) {
    var $recommend = $this.parent().parent().parent().find(".recommend").find("li");
    if (type == true) {
        $recommend = $this.parent().next().find(".recommend").find("li");
    }
    var recommendArr = [];
    for (var i = 0; i < $recommend.length; i++) {
        recommendArr.push($($recommend[i]).text());
    }
    return recommendArr;
}
/**
 * 把选中机构移除
 */
function closeOrg($this) {
    $this = $($this).parent();
    $this.parent().parent().prev().prev().find("ul").append("<li data-text='" + $this.attr("data-text") + "'   data-switchs='" + $this.attr("data-switchs") + "' data-auid='" + $this.attr("data-auid") + "' ondblclick='pushReCommends(this)' onclick='activeReCommends(this)'>" + $this.attr("data-text") + "</li>");
    $this.remove();
    addOrRemoveOrg();
}
/**
 * 把推荐信息添加到选中信息中
 * @param $this
 */
function pushReCommends($this) {
    $this = $($this);
    var $recommend = $this.parent().parent().next().next().find(".recommend");
    var flag = true;//默认允许添加
    var reCommendArr = getReCommend($this);
    for (var i = 0; i < reCommendArr.length; i++) {
        if (reCommendArr[i] == $($this).text()) {
            flag = false;
            break;
        }
    }
    if (flag == true) {
        var text = $($this).attr("data-text");
        if (text.length > 15) {
            text = text.substring(0, 15) + "...";
        }
        if ($($this).attr("data-switchs") == "org") {
            $recommend.append("<li data-text='" + $($this).attr("data-text") + "'   data-switchs='" + $($this).attr("data-switchs") + "' data-auid=\"" + $($this).attr("data-auid") + "\">" + text + "<img src='static/images/closeRemove.png' onclick='closeOrg(this)' alt=''></li>");
            addOrRemoveOrg();
        } else {
            $recommend.append("<li data-text='" + $($this).attr("data-text") + "'   data-switchs='" + $($this).attr("data-switchs") + "' data-auid=\"" + $($this).attr("data-auid") + "\">" + text + "<img src='static/images/closeRemove.png' onclick='closeParent(this)' alt=''></li>");
        }
        $($this).remove();
    } else {
        alert($($this).text() + " 已添加,不能重复添加!");
        return;
    }
}
/**
 * 添加或删除选中机构
 */
function addOrRemoveOrg() {
    var orgs = "";
    var auids = "";
    //获取选中机构(知机构|懂专家)
    $(exports + " .orgRecommend li").each(function () {
        orgs += $(this).attr("data-text") + "|";
        if ($(this).attr("data-auid") != "") {
            auids += $(this).attr("data-auid") + "|";
        }
    });
    orgs = orgs.substring(0, orgs.length - 1);
    if (auids.length != 0) {
        auids = auids.substring(0, auids.length - 1);
    }
    var $names = returnNames();//获取所有学者名字
    var $name = "";//拼接学者姓名
    for (var i = 0; i < $names.length; i++) {
        $name += $names[i] + "|";
    }

    if (app) {
        orgs = sessionStorage.getItem("selectOrg");
        auids = sessionStorage.getItem("selectAuids");
        $(appExport + " .appCkeys").html("<li>加载中...</li>");
        if (appExport == ".zhuanjia") {
            ajaxPost(postUrl + "/stads.do?nameOrCkey", {
                name: encodeURI($name.substring(0, $name.length - 1)),
                auIds: auids,
                orgs: encodeURI(orgs),
                pageSize: page.ckeyPage.pageSize,
                pageNo: page.ckeyPage.pageNo
            }, showCkeys);//请求数据请求推荐机构和技术点
        } else {
            ajaxPost(postUrl + "/stads.do?orgOrCkey", {
                org: encodeURI(orgs),
                pageSize: page.ckeyPage.pageSize,
                pageNo: page.ckeyPage.pageNo
            }, showCkeys);//请求数据请求推荐机构和技术点
        }
    } else {
        $(exports + " .onSelectSubjects").html("<li>加载中...</li>");
        if (exports == ".zj") {
            ajaxPost(postUrl + "/stads.do?nameOrCkey", {
                name: encodeURI($name.substring(0, $name.length - 1)),
                orgs: encodeURI(orgs),
                pageSize: page.ckeyPage.pageSize,
                pageNo: page.ckeyPage.pageNo
            }, showCkeys);//请求数据请求推荐机构和技术点
        } else {
            ajaxPost(postUrl + "/stads.do?orgOrCkey", {
                org: encodeURI(orgs),
                pageSize: page.ckeyPage.pageSize,
                pageNo: page.ckeyPage.pageNo
            }, showCkeys);//请求数据请求推荐机构和技术点
        }
    }
}
/**
 * 显示推荐技术点信息
 * @param result
 */
function showCkeys(result) {
    if (result.subjects != undefined && result.subjects.length != 0) {
        page.orgPage = new Page(0, 10, result.orgTotalCodunt);//
        page.ckeyPage = new Page(0, 10, result.ckeyTotalCount);//
        var str = "";
        for (var i = 0; i < result.subjects.length; i++) {
            str += "<li data-text='" + result.subjects[i] + "' ondblclick='pushReCommends(this)' onclick='activeReCommends(this)'>" + result.subjects[i] + "</li>";
        }
        if (app) {
            $(appExport + " .appCkeys").html(str);
        } else {
            $(exports + " .onSelectSubjects").html(str);
        }
    } else {
        if (app) {
            $(appExport + " .appCkeys").html("<li>暂无数据</li>");
        } else {
            $(exports + " .onSelectSubjects").html("<li>暂无数据</li>");
        }

    }
}

/**
 * 手机点击推荐则显示为选中
 * @param $this
 */
function appActiveReCommends($this, str) {
    $this = $($this);
    if (str == "ckey") {
        var selectCkey = sessionStorage.getItem("selectCkey") + "|" + $this.attr("data-text");
        if (selectCkey.indexOf("|") == 0) {
            selectCkey = selectCkey.substring(1, selectCkey.length);
        }
        sessionStorage.setItem("selectCkey", selectCkey);
        $this.addClass("appActiveReCommend").attr("onclick", "appRemoveReCommends(this,'ckey')");
    } else {
        var selectOrg = sessionStorage.getItem("selectOrg") + "|" + $this.attr("data-text");
        var selectAuids = sessionStorage.getItem("selectAuids") + "|" + $this.attr("data-auid");
        if (selectOrg.indexOf("|") == 0) {
            selectOrg = selectOrg.substring(1, selectOrg.length);
        }
        if (selectAuids.indexOf("|") == 0) {
            selectAuids = selectAuids.substring(1, selectAuids.length);
        }
        sessionStorage.setItem("selectOrg", selectOrg);
        sessionStorage.setItem("selectAuids", selectAuids);
        $this.addClass("appActiveReCommend").attr("onclick", "appRemoveReCommends(this)");
        addOrRemoveOrg();
    }
}
/**
 * 手机第二次点击推荐则显示为未选中
 * @param $this
 */
function appRemoveReCommends($this, str) {
    $this = $($this);
    if (str == "ckey") {
        sessionStorage.setItem("selectCkey", subStringVertical(sessionStorage.getItem("selectCkey"), $this.attr("data-text")))
        $this.removeClass("appActiveReCommend").attr("onclick", "appActiveReCommends(this,'ckey')");
    } else {
        sessionStorage.setItem("selectOrg", subStringVertical(sessionStorage.getItem("selectOrg"), $this.attr("data-text")))
        sessionStorage.setItem("selectAuids", subStringVertical(sessionStorage.getItem("selectAuids"), $this.attr("data-auid")))
        $this.removeClass("appActiveReCommend").attr("onclick", "appActiveReCommends(this)");
        addOrRemoveOrg();
    }
}
/**
 * 剪切字符+竖线
 */
function subStringVertical(str, s) {
    if (str.indexOf(s) != -1) {
        var a, b;
        if (str.charAt(str.indexOf(s) - 1) == "|") {
            a = str.substring(0, str.indexOf(s) - 1);
            b = str.substring(str.indexOf(s) + s.length, str.length);
            str = a + b;
        } else if (str.charAt(str.indexOf(s) + s.length) == "|") {
            str = str.substring(str.indexOf(s) + s.length + 1, str.length);
        }
    }
    return str;
}
/**
 * 点击推荐则显示为选中
 * @param $this
 */
function activeReCommends($this) {
    $this = $($this);
    $this.addClass("activeReCommend").attr("onclick", "removeReCommends(this)");
}
/**
 * 第二次点击推荐则显示为未选中
 * @param $this
 */
function removeReCommends($this) {
    $this = $($this);
    $this.removeClass("activeReCommend").attr("onclick", "activeReCommends(this)");
}
/**
 * 点击箭头一键添加到选中状态
 * @param $this
 */
function pushsReCommends($this, str) {
    $this = $($this);
    var recommend = $this.parent().prev().find(".activeReCommend");

    var f = true;//如果有重复的则不进行添加
    for (var i = 0; i < recommend.length; i++) {
        var reCommendArr = getReCommend($this, true);
        var flag = true;//默认允许添加
        for (var j = 0; j < reCommendArr.length; j++) {
            if (reCommendArr[j] == $(recommend[i]).text()) {
                flag = false;
                f = false;
                break;
            }
        }
        var auid = $(recommend[i]).attr("data-auid") || '';
        var text = $(recommend[i]).attr("data-text");
        var switchs = $(recommend[i]).attr("data-switchs") || '';
        if (text.length > 15) {
            text = text.substring(0, 15) + "...";
        }
        if (flag == true) $this.parent().next().find(".recommend").append("<li data-auid='" + auid + "'   data-switchs='" + switchs + "' data-text='"
            + $(recommend[i]).attr("data-text") + "'>" + text + "<img src='static/images/closeRemove.png' onclick='closeParent(this)' alt=''></li>");
    }
    recommend.remove();
    if (f == false) alert("选中内容已有重复，重复已覆盖!");
    if (str == "org") {
        addOrRemoveOrg();
    }
}
$(".appName").keyup(function (e) {
    if (e.keyCode == 13) {
        $(this).next().click();
    }
});
$("body").on({
    "touchend": function (e) {
        moveEndX = e.originalEvent.changedTouches[0].pageX,
            moveEndY = e.originalEvent.changedTouches[0].pageY,
            X = moveEndX - startX,
            Y = moveEndY - startY;
        //下滑
        if (Y > 0) {
            var t = $(".CXZSZJBG_main_name").offset().top - $(window).scrollTop();
            var fixed = $(".cxzs_name_Analysis_info").offset().top - $(window).scrollTop();
            if (fixed > 45) {
                $(".cxzs_name_Analysis_phone").removeAttr("style")
                $("#cxzs_search").css({
                    "display": "block"
                });
            }
        }
        //上滑
        else if (Y < 0) {
            var f = $(".CXZSZJBG_main_name").offset().top - $(window).scrollTop();
            var fixed = $(".cxzs_name_Analysis_phone").offset().top - $(window).scrollTop();
            if (fixed < 0) {
                $(".cxzs_name_Analysis_phone").css({
                    "position": "fixed",
                    "top": "45px",
                    "z-index": "4",
                    "background": "#ffffff"
                })
                $("#cxzs_search").css({
                    "display": "none"
                });
            }
        }
    },
    "touchstart": function (e) {
        startX = e.originalEvent.changedTouches[0].pageX,
            startY = e.originalEvent.changedTouches[0].pageY;
    }
});
$("#expertInfo").focus(function () {
    userIf();
});
$("#orgName").focus(function () {
    userIf();
});
$("#ckeyName").focus(function () {
    userIf();
});
/**
 * 点击文档任意地方隐藏懂专家搜索的机构
 */
$(document).click(function () {
    $(".s_list").css({"display": "none"});
    $(".cxzs_name_Analysis").css({"z-index": "4"});
})
$("#search_orgs").click(function (e) {
    $(".cxzs_name_Analysis").css({"z-index": "3"});
    e.stopPropagation();
})


/**
 * tab切换
 */
function tabs_search(number) {
    if (number == 2) {
        $("#dzj").css({
            "display": "block"
        });
        $("#szt").css({
            "display": "none"
        });
        $("#zjg").css({
            "display": "none"
        });
        setThreeNumber(2);
    } else if (number == 1) {
        $("#dzj").css({
            "display": "none"
        });
        $("#szt").css({
            "display": "block"
        });
        $("#zjg").css({
            "display": "none"
        });
        setThreeNumber(1);
    } else if (number == 3) {
        $("#dzj").css({
            "display": "none"
        });
        $("#szt").css({
            "display": "none"
        });
        $("#zjg").css({
            "display": "block"
        });
        setThreeNumber(3);
    }
    $(".s_list").html("");
    $(".cxzs_search_top a:nth-of-type(" + number + ")").addClass("cxzs_search_top_a_active").siblings().removeClass("cxzs_search_top_a_active");
}
//获取参数的方法
function getParam(paramName) {
    paramValue = "", isFound = !1;
    if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=") > 1) {
        arrSource = unescape(this.location.search).substring(1, this.location.search.length).split("&"), i = 0;
        while (i < arrSource.length && !isFound) arrSource[i].indexOf("=") > 0 && arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase() && (paramValue = arrSource[i].split("=")[1], isFound = !0), i++
    }
    return paramValue == "" && (paramValue = null), paramValue
}

/**
 * 验证当前输入文本是否是合法文本
 * @param str 输入的文本
 * @returns {Boolean} true为合法 false为不合法
 */
function isStrip(str) {
    var pattern = new RegExp("[`~!@#$^&*={}:\\[\\]<>/?~！@#￥……&*（）——{}【】‘；：”“。，、？]");
    if (pattern.test(str)) {
        return true;
    } else {
        return false;
    }
}
/**
 * 导航鼠标悬浮和离开事件
 */
$(".cxzs_name_Analysis_firstChildUl li").on({
    "mouseover": function () {
        $(this).find(".cxzs_name_Analysis_firstChildUl_title").css({
            "background": "#ffffff",
            "border-bottom": "none",
            "border-top": "2px solid #266CBB"
        });
    },
    "mouseout": function () {
        $(this).find(".cxzs_name_Analysis_firstChildUl_title").css({
            "background": "#fafafa",
            "border-bottom": "1px solid #eeeeee",
            "border-top": "none",
            "border-right": "1px solid #eeeeee"
        });
    }
});
var zl_echarts_bing,
    kjcg_echarts_bing,
    gjjcyj_echarts_bing,
    cxzs_sbss,
    cxzs_kjcg,
    cxzs_zlcc,
    cyfz_echarts, kjcg_echarts, zllx_echarts, zl_echarts_qu;
/**
 * 返回饼状图
 * @param a echarts名称
 * @param b 需要移除的父容器
 * @param c 需要置灰的href名称
 * @param d json数据
 */
function returnPie(a, b, c, result) {
    if (result != undefined && result.length != 0) {
        var obj = {
            data: [],//数据
            dataName: []//图例
        };
        var colorNumber = 0;
        for (var key in result) {
            obj.dataName.push(key);
            obj.data.push({
                value: result[key],
                name: key,
                itemStyle: {
                    normal: {
                        color: colors[colorNumber++]
                    }
                }
            });
        }
        if (colorNumber != 0) {
            var kjcg_echarts_bing_option = {
                backgroundColor: '#f3f3f3',//背景颜色
                tooltip: {
                    trigger: 'item',
                    formatter: "{b} : {c} ({d}%)"
                },
                legend: {
                    top: "3%",
                    left: '3%',
                    orient: 'vertical',
                    data: obj.dataName
                },
                series: [
                    {
                        type: 'pie',
                        radius: '65%',
                        center: ['75%', '50%'],
                        selectedMode: 'single',
                        data: obj.data,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        },
                        labelLine: {
                            normal: {
                                show: true
                            }
                        }
                    }
                ]
            };
            if (app) {
                kjcg_echarts_bing_option.series[0].center = ["50%", "50%"];
                kjcg_echarts_bing_option.series[0].radius = "50%";
                kjcg_echarts_bing_option.legend = {};
            }
            var bing = echarts.init(document.getElementById(a));
            bing.setOption(kjcg_echarts_bing_option);
            if (a == "zl_echarts_bing") {
                zl_echarts_bing = bing;
            } else if (a == "kjcg_echarts_bing") {
                kjcg_echarts_bing = bing;
            } else if (a == "gjjcyj_echarts_bing") {
                gjjcyj_echarts_bing = bing;
            } else if (a == "cxzs_kjcg") {
                cxzs_kjcg = bing;
            } else if (a == "kjcg_echarts") {
                kjcg_echarts = bing;
            }
        } else {
            $("#" + b).remove();
            $("a[href='#" + c + "']").removeClass("cxzs_name_Analysis_firstChildUl_have").addClass("cxzs_name_Analysis_firstChildUl_none");
        }
    } else {
        $("#" + b).remove();
        $("a[href='#" + c + "']").removeClass("cxzs_name_Analysis_firstChildUl_have").addClass("cxzs_name_Analysis_firstChildUl_none");
    }
}
/**
 * 返回柱状图和折线图
 * @param a echarts的id
 * @param b 需要移除父容器的id名称
 * @param c 需要置灰导航的链接名称
 */
function reutrnColumnLine(a, b, c, result) {
    result = JSON.parse(result);
    if (result != undefined) {
        /**
         * 返回曲线关键图鉴
         * @param result json格式数据
         */
        function returnLine(result) {
            var obj = {
                dataName: [],//图例
                dataX: [],//X轴数据
                dataColumn: [],//柱状图数据
                dataLine: [],//折线图数据
                colorsNumber: 0
            };
            var colorsNumber = 0;
            for (var key in result) {
                var resultKey = result[key];
                if (resultKey != undefined && resultKey.key != undefined && resultKey.count != undefined) {
                    key = key.toUpperCase();
                    obj.dataName.push(key);
                    obj.dataX = resultKey.key;//X轴
                    obj.dataColumn.push({
                        name: key,
                        type: 'bar',
                        stack: '专利产出',
                        itemStyle: {
                            normal: {
                                color: colors[obj.colorsNumber++]
                            }
                        },
                        data: resultKey.count
                    });
                    obj.dataLine.push({
                        name: key + "总数",
                        type: 'line',
                        data: (function () {
                            var arr = [];
                            var dataCount = 0;
                            for (var i = 0; i < resultKey.count.length; i++) {
                                dataCount += parseInt(resultKey.count[i]);
                                arr.push(dataCount);
                            }
                            return arr;
                        })(),
                        itemStyle: {
                            normal: {
                                color: colors[obj.colorsNumber++]
                            }
                        }
                    });
                }
            }
            var dataNameLength = obj.dataName.length;
            for (var i = 0; i < dataNameLength; i++) obj.dataName.push(obj.dataName[i] + "总数");
            return obj;
        }

        var obj = returnLine(result);
        if (obj.colorsNumber != undefined && obj.colorsNumber != 0) {
            var zllx_echarts_option = {
                backgroundColor: '#f3f3f3',//背景颜色
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: "shadow",//当前鼠标悬浮的状态
                        label: {
                            formatter: function (params) {
                                var str = params.value + "\n";
                                return str;
                            }
                        }
                    }
                },
                grid: {
                    left: '6%', //距离左侧距离
                    right: '4%',
                    bottom: '8%',
                    top: "20%",
                    containLabel: true
                },
                legend: {
                    right: "12%",
                    data: obj.dataName
                },
                xAxis: [
                    {
                        type: 'category',
                        data: obj.dataX
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: obj.dataColumn.concat(obj.dataLine)
            };
            if (app) {
                zllx_echarts_option.legend.right = "20%";
                zllx_echarts_option.xAxis[0].axisLabel = {rotate: 40}
            }
            var columnLine = echarts.init(document.getElementById(a));
            columnLine.setOption(zllx_echarts_option);
            if (a == "cxzs_sbss") {
                cxzs_sbss = columnLine;
            } else if (a == "cxzs_zlcc") {
                cxzs_zlcc = columnLine;
            } else if (a == "cyfz_echarts") {
                cyfz_echarts = columnLine;
            } else if (a == "zllx_echarts") {
                zllx_echarts = columnLine;
            } else if (a == "zl_echarts_qu") {
                zl_echarts_qu = columnLine;
            }
        } else {
            $("#" + b).remove();
            $("a[href='#" + c + "']").removeClass("cxzs_name_Analysis_firstChildUl_have").addClass("cxzs_name_Analysis_firstChildUl_none");
        }
    } else {
        $("#" + b).remove();
        $("a[href='#" + c + "']").removeClass("cxzs_name_Analysis_firstChildUl_have").addClass("cxzs_name_Analysis_firstChildUl_none");
    }
}
/**
 * echarts全屏显示
 * @param ele
 */
function fullScreen(ele) {
    $("#" + ele).parent().addClass("fullScreenCanvas").children("button").text("关闭").attr("onclick", "closeFullScreen(\"" + ele + "\")");
    echartsResize(ele);
}
/**
 * 关闭echarts全屏显示
 * @param ele
 */
function closeFullScreen(ele) {
    $("#" + ele).parent().removeClass("fullScreenCanvas").children("button").text("全屏查看").attr("onclick", "fullScreen(\"" + ele + "\")");
    echartsResize(ele);
}
/**
 * 重新设置echarts的大小
 * @param ele
 */
function echartsResize(ele) {
    if (ele == "kyfb_echarts") {
        kyfb_echarts.resize();
    } else if (ele == "xkstx_echarts") {
        xkstx_echarts.resize();
    } else if (ele == "jczj_echarts") {
        jczj_echarts.resize();
    } else if (ele == "gnjcyj_echarts") {
        gnjcyj_echarts.resize();
    } else if (ele == "zl_echarts_zhu") {
        zl_echarts_zhu.resize();
    } else if (ele == "zl_echarts_qu") {
        zl_echarts_qu.resize();
    } else if (ele == "jjxm_echarts_bing") {
        jjxm_echarts_bing.resize();
    } else if (ele == "jjxm_echarts_zhe") {
        jjxm_echarts_zhe.resize();
    } else if (ele == "kjcg_echarts_qu") {
        kjcg_echarts_qu.resize();
    } else if (ele == "sbds_echarts") {
        sbds_echarts.resize();
    } else if (ele == "gjjcyj_echarts_qu") {
        gjjcyj_echarts_qu.resize();
    } else if (ele == "zl_echarts_bing") {
        zl_echarts_bing.resize();
    } else if (ele == "kjcg_echarts_bing") {
        kjcg_echarts_bing.resize();
    } else if (ele == "gjjcyj_echarts_bing") {
        gjjcyj_echarts_bing.resize();
    } else if (ele == "cxzs_ztfb") {
        cxzs_ztfb.resize();
    } else if (ele == "cxzs_kyhyd") {
        cxzs_kyhyd.resize();
    } else if (ele == "cxzs_kxstx") {
        cxzs_kxstx.resize();
    } else if (ele == "cxzs_kygzd") {
        cxzs_kygzd.resize();
    } else if (ele == "cxzs_jjxm") {
        cxzs_jjxm.resize();
    } else if (ele == "cxzs_sbss") {
        cxzs_sbss.resize();
    } else if (ele == "cxzs_kjcg") {
        cxzs_kjcg.resize();
    } else if (ele == "cxzs_zlcc") {
        cxzs_zlcc.resize();
    } else if (ele == "qyfz_echarts") {
        qyfz_echarts.resize();
    } else if (ele == "cyfz_echarts") {
        cyfz_echarts.resize();
    } else if (ele == "jcyj_echarts") {
        jcyj_echarts.resize();
    } else if (ele == "qycp_echarts") {
        qycp_echarts.resize();
    } else if (ele == "xkstx_echarts") {
        xkstx_echarts.resize();
    } else if (ele == "IPC_echarts") {
        IPC_echarts.resize();
    } else if (ele == "jsxgd_echarts") {
        jsxgd_echarts.resize();
    } else if (ele == "kjcg_echarts") {
        kjcg_echarts.resize();
    } else if (ele == "jjxm_echarts") {
        jjxm_echarts.resize();
    } else if (ele == "zllx_echarts") {
        zllx_echarts.resize();
    } else if (ele == "zl_echarts_qu") {
        zl_echarts_qu.resize();
    }
}
/**
 * 锚链接滑动效果
 */
$('a[href^="#"]').click(function (e) {
    e.preventDefault();
    var hr = $(this).attr("href");
    var anh = $("[name=" + hr.substring(1, hr.length) + "]").offset().top;
    if ($(document).scrollTop() < 180) {
        $("html,body").stop().animate({scrollTop: anh - 180}, 500);
    } else {
        $("html,body").stop().animate({scrollTop: anh - 130}, 500);
    }
    if (app) {
        $("#cxzs_search").css({
            "opacity": "0",
            "display": "none"
        });
    }
});

/**
 * 移除节点
 * @param arr [{ele:"#zjbg","title":"zhuanjiabaogao"}]
 */
function removeElement(arr) {
    for (var i = 0; i < arr.length; i++) {
        $(arr[i].ele).remove();
        $("a[href='#" + arr[i].title + "']").removeClass("cxzs_name_Analysis_firstChildUl_have").addClass("cxzs_name_Analysis_firstChildUl_none");
    }
}

/**
 * 关闭下载选择框
 */
function closeAppDownLoadMain() {
    $("#appDownLoad").animate({
        "opacity": "0"
    }, 300, function () {
        $(this).css({"display": "none", "z-index": "0"});
    });
}

function changeDownLoadMain() {
    $("#downLoad").css({"background": "rgb(18,167,187)"}).find("a").css({
        "color": "#ffffff",
        "cursor": "pointer"
    }).attr("onclick", "downLoadpdf()");
}
/**
 * 打开下载选择框
 */
function showAppDownLoadMain() {
    if (window.navigator.userAgent.indexOf("Chrome") != -1) {
        var number = window.navigator.userAgent.substring(window.navigator.userAgent.indexOf("Chrome") + 7, window.navigator.userAgent.indexOf("Chrome") + 10);
        if (number < 68) {
            $("#appDownLoad .appDownLoadMain .png div").html("您当前浏览器版本为Chrome " + number + "+，请更新为最新版本浏览器尝试下载！");
        } else {
            $("#appDownLoad .appDownLoadMain .png").addClass("appDownLoadMainActive").find("div").html("可以下载，如果下载失败请联系管理员！").prev().attr("onclick", "downLoadPng()");
        }
    } else {
        $("#appDownLoad .appDownLoadMain .png div").html("您当前浏览器不支持png格式下载，请切换Chrome最新版本进行下载！");
    }

    $("#appDownLoad").css({"display": "block", "z-index": "11"}).animate({
        "opacity": "1"
    }, 300);
}

/**
 * 下载png格式
 *
 String stype, String search, String title,String jgname
 */
function downLoadPng() {
    var threeNumber = getThreeNumber();
    var subject = "";
    var object = {"stype": threeNumber};
    if (threeNumber == "1") {
        subject = decodeURI(localStorage.getItem("ckeys"));
    } else if (threeNumber == "2") {
        subject = decodeURI(localStorage.getItem("name"));
        object.jgname = decodeURI(localStorage.getItem("orgs"));
    } else if (threeNumber == "3") {
        subject = decodeURI(localStorage.getItem("org"));
        object.jgname = subject;
    }
    object.search = subject + "_png格式报告下载";
    object.title = subject;
    html2canvas($(".CXZSZJBG_main"), {
        onrendered: function (canvas) {
            var uri = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");
            var a = document.createElement("a");
            a.href = uri;
            a.download = getNowTime() + subject + ".png";
            a.click();
            addLog(object);//添加下载日志
        }
    });
}

function downLoadpdf() {
    var threeNumber = getThreeNumber();
    var subject = "";
    var object = {"stype": threeNumber};
    if (threeNumber == "1") {
        subject = decodeURI(localStorage.getItem("ckeys"));
    } else if (threeNumber == "2") {
        subject = decodeURI(localStorage.getItem("name"));
        object.jgname = decodeURI(localStorage.getItem("orgs"));
    } else if (threeNumber == "3") {
        subject = decodeURI(localStorage.getItem("org"));
        object.jgname = subject;
    }
    object.search = subject + "_pdf格式报告下载";
    object.title = subject;
    html2canvas($(".CXZSZJBG_main"), {
        onrendered: function (canvas) {
            var contentWidth = canvas.width;
            var contentHeight = canvas.height;

            //一页pdf显示html页面生成的canvas高度;
            var pageHeight = contentWidth / 592.28 * 841.89;
            //未生成pdf的html页面高度
            var leftHeight = contentHeight;
            //菜刀f页面偏移
            var position = 0;
            //回头ml页面生成的canvas在pdf中图片的宽高（a4纸的尺寸[595.28,841.89]）
            var imgWidth = 595.28;
            var imgHeight = 592.28 / contentWidth * contentHeight;

            var pageData = canvas.toDataURL('image/jpeg', 1.0);
            var pdf = new jsPDF('', 'pt', 'a4');
            //有两个高度需要区分，一个是html页面的实际高度，和生成pdf的页面高度(841.89)
            //当内容未超过pdf一页显示的范围，无需分页
            if (leftHeight < pageHeight) {
                pdf.addImage(pageData, 'JPEG', 0, 0, imgWidth, imgHeight);
            } else {
                while (leftHeight > 0) {
                    pdf.addImage(pageData, 'JPEG', 0, position, imgWidth, imgHeight)
                    leftHeight -= pageHeight;
                    position -= 841.89;
                    //避免添加空白页
                    if (leftHeight > 0) {
                        pdf.addPage();
                    }
                }
            }
            pdf.save(getNowTime() + subject + ".pdf");

            addLog(object);//添加下载日志
        }
    });
}

/**
 * 返回当前时间  年月日
 */
function getNowTime() {
    var myDate = new Date();//获取系统当前时间
    var yyyy = myDate.getFullYear();
    var MM = myDate.getMonth() + 1;
    var dd = myDate.getDate();
    if (MM < 10) {
        MM = "0" + MM;
    }
    if (dd < 10) {
        dd = "0" + dd;
    }
    return yyyy + MM + dd;
}
/**
 * 显示余量对话框
 * @param number
 */
function showSurplusDialog(number) {
    //closeDiaLog();
    var marginLeft = (($(".surplusDialogMain").outerWidth(true)) / 2);
    $("#surplusDialog").css({
        "display": "block",
        "z-index": "11"
    }).animate({
        "opacity": "1"
    }, 300);
}
/**
 * 隐藏余量对话框
 */
function hideSurplusDialog() {
    //clearInterval(timeInterval);
    $("#surplusDialog").animate({
        "opacity": "0"
    }, 300, function () {
        $(this).css({
            "display": "none",
            "z-index": "0"
        });
    });
}

