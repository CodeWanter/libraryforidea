var ddsyntony = false;
var orderId = 0;
var orgs2 = "";
var title2 = "";
var query2 = "";
var stype2 = 0;
var postUrl = "http://webstads.sciinfo.cn/";

function recommend(div, data1, type) {
    //type为报告类型1.查机构 2.找专家 3.定主题
    //var data=eval('(' + data1 + ')').data;
    var html = "";
    var data = eval('(' + data1 + ')');
    if (type == 1) {
        for (var i = 0; i < data.length; i++) {
            html += "<a href='javascript:void(0)' onclick='order(\"" + data[i].hotname + "\",1,\"\",\"\",\"\",\"\",\"\",\"" + data[i].hotname + "\",false)'>";
            html += data[i].hotname + "</a>";
        }
    } else if (type == 2) {
        for (var i = 0; i < data.length; i++) {
            html += "<a href='javascript:void(0)' onclick='order(\"" + data[i].hotname + "\",2,\"" + data[i].hotname + "\",\"\",\"\",\"\",\"\",\"\",false)'>";
            html += data[i].hotname + "</a>";
        }
    } else if (type == 3) {
        for (var i = 0; i < data.length; i++) {
            html += "<a href='javascript:void(0)' onclick='order(\"" + data[i].hotname + "\",3,\"\",\"\",\"\",\"" + data[i].hotname + "\",\"\",\"\",false)'>";
            html += data[i].hotname + "</a>";
        }
    }
    div.html(html);
}
//获取推荐热词type为报告类型1.查机构 2.找专家 3.定主题
function getRecomend(div, type) {
    var url = postUrl + "/stads.do?getHotInfoList";
    $.ajax({
        url: url,
        type: 'post',
        data: {
            type: type
        },
        datatype: 'json',
        success: function (data) {
            recommend(div, data, type);
        }
    })
    //typeB后台用的报告类型1.专家 2.机构 3.主题
}
$(function () {
    getRecomend($("#hotExpert"), 2);
    getRecomend($("#hotOrg"), 1);
    getRecomend($("#hotCkey"), 3);
});
var timeSet = null;
//动态进度条
function timeAdd() {
    var i = 0;
    $(".charts d").text(i + "%");
    $(".charts").css("width", i + "%");
    timeSet = setInterval(function () {
        if (i < 89) {
            i = i + 10;
            $(".charts d").text(i + "%");
            $(".charts").css("width", i + "%");
        } else {
            window.clearInterval(timeSet);
        }
    }, 2000);
}

/*
 * 关闭支付页面*/
function closepay() {
    hideJqueryModalPlug("#demoModal2");
}

var indexQuery = "";
var indexStype = "";
var indexObject = {};
/**
 * 所有请求前访问
 * @param query 查询内容(文本框中输入的内容)
 * @param stype 请求类型 1.机构 2.专家 3.主题
 * @param name 人物姓名
 * @param orgs 机构名称
 * @param auIds 机构唯一编号
 * @param ckeys 检索关键词
 * @param type 类型
 * @param org 机构名称
 * @param newOpen 是否打开新窗口 true打开 false直接在本页面中打开
 */
function order(query, stype, name, orgs, auIds, ckeys, type, org, newOpen) {
    indexQuery = query;
    indexStype = stype;
    indexObject = {name: name, orgs: orgs, auIds: auIds, ckeys: ckeys, type: type, org: org, newOpen: newOpen};
    aaaaaaa(indexQuery, indexStype, indexObject);
}
/**
 * 所有请求前访问
 * @param query 查询内容(被保存到数据库信息生成订单信息)
 * @param stype 请求类型 1.机构 2.专家 3.主题
 * @param object 需要被保存的数据
 *           name:人物姓名
 *           orgs:机构名称
 *          auIds:机构唯一编号
 *          ckeys:检索关键词
 *           type:类型
 *            org:机构名称
 *        newOpen:是否打开新窗口 true打开 false直接在本页面中打开
 */
function aaaaaaa(query, stype, object) {
    var appid = getParam("appid");//获取appid
    $(".s_list").css("display", "none");//隐藏推荐机构
    //查询当前用户信息是否是vip
    $.ajax({
        url: postUrl + "/stads.do?vipIf",
        method: "post",
        async: false,
        data: {
            type: stype,
            appid: appid,
            query: query
        },
        success: function (result) {
            vipIfCallBack(result, query, stype, object);
        }
    });
}

/**
 * 当前用户信息
 * @param result 查询当前用户信息是否是vip返回结果
 * @param stype 请求类型 1.机构 2.专家 3.主题
 * @param object 需要被保存的数据
 *          name:人物姓名
 *          orgs:机构名称
 *         auIds:机构唯一编号
 *         ckeys:检索关键词
 *          type:类型
 *           org:机构名称
 *       newOpen:是否打开新窗口 true打开 false直接在本页面中打开
 */
function vipIfCallBack(result, query, stype, object) {
    object.query = query;
    object.stype = stype;
    var data = eval('(' + result + ')');
    //var count = data.count;
    var surplus = data.totalCount;//总报告份数
    //var sy = surplus-count;//
    //var totalCount = surplus+count;

    var vipif = data.vipIf || "";//记录用户是否是机构用户
    var userif = data.userIf || "";//记录用户是否登录
    console.log(result);
    //当前时间大于到期时间  则为到期
    if (data.userIf != undefined && data.userIf != "undefined" && data.userIf != null && data.userIf != "null" && data.userIf != 0) {
        if ((new Date()) > (new Date(Date.parse(data.valiDate)))) {
            $("#surplusDialog .surplusDialogMain .es").html("<p class='surplusNumber'>您到账户已过期，请联系客服。</p><p class='surplusNumber'>客服电话：010-58882692</p>");
            showSurplusDialog();
            return false;
        } else {
            if (surplus <= 0) {
                if (data.userType == "个人用户") {
                    var time = 3;
                    $("#surplusDialog .surplusDialogMain .es").html("<p class='surplusNumber'>您当前剩余报告总数为 <span class='number'>0</span> 份。</p><p class='surplusNumber'>3秒后显示支付，请稍后</p>");
                    showSurplusDialog();
                    var timeInterval = setInterval(function () {
                        time--;
                        $("#surplusDialog .surplusDialogMain .es").html("<p class='surplusNumber'>您当前剩余报告总数为 <span class='number'>0</span> 份。</p><p class='surplusNumber'>" + time + "秒后显示支付，请稍后</p>");
                    }, 1000);
                    var timeTimeout = setTimeout(function () {

                        if (isApp()) {//如果是手机端访问
                            showJqueryModalPlug("#demoModal4", {"top": "100", "hide": false});
                        } else {
                            hideJqueryModalPlug("#demoModal1");
                            showJqueryModalPlug("#demoModal2", {"top": "100", "hide": true});
                            //调用微信支付
                            wxpay(query, stype, object);
                            timeSet = setInterval(function () {
                                if (!ddsyntony) {
                                    ajaxPost(postUrl + "/stads.do?payIf", {orderId: orderId}, function (data) {
                                        syncOrder(data, query, stype, object);
                                    });
                                } else {
                                    window.clearInterval(timeSet);
                                }
                            }, 500);
                        }
                        hideSurplusDialog();
                        clearInterval(timeInterval);
                        clearTimeout(timeTimeout);
                    }, 3000);
                } else {
                    $("#surplusDialog .surplusDialogMain .es").html("<p class='surplusNumber'>您当前剩余报告总数为 <span class='number'>0</span> 份，请联系机构管理员或联系客服进行续费。</p><p class='surplusNumber'>客服电话：010-58882692</p>");
                    showSurplusDialog();
                    return false;
                }
            } else {
                if (vipif != "" && vipif == 1) {//如果是机构用户则不需要支付
                    if (data.payif == 0) {//是否已经支付过了
                        addOrder(query, stype, object);//添加订单信息
                    }
                    saveInfo(stype, object);//保存信息，并刷新页面
                    openNewPage(stype, object);//如果是机构用户则不需要支付并且打开新页面
                } else {
                    if (userif != "" && userif == 1) {
                        if (surplus > 0) {//如果有剩余报告数量
                            saveInfo(stype, object);//保存信息，并刷新页面
                            if (data.payif == 0) {
                                addOrder(query, stype, object);//添加订单信息
                            }
                            openNewPage(stype, object);//如果当前用户还有剩余报告分数则不需要支付并且打开新页面
                        } else {//如果没有报告数量，则需要调用支付
                            if (isApp()) {//如果是手机端访问
                                showJqueryModalPlug("#demoModal4", {"top": "100", "hide": false});
                            } else {
                                hideJqueryModalPlug("#demoModal1");
                                showJqueryModalPlug("#demoModal2", {"top": "100", "hide": true});
                                //调用微信支付
                                wxpay(query, stype, object);
                                timeSet = setInterval(function () {
                                    if (!ddsyntony) {
                                        ajaxPost(postUrl + "/stads.do?payIf", {orderId: orderId}, function (data) {
                                            syncOrder(data, query, stype, object);
                                        });
                                    } else {
                                        window.clearInterval(timeSet);
                                    }
                                }, 500);
                            }
                        }
                    } else {//如果用户没有登录则跳转到登录页面
                        window.location.href = postUrl + "/stads.do?tologin";
                    }
                }
            }
        }

    } else {
        window.location.href = postUrl + "/stads.do?tologin";
    }
}
/*function paysss(){
 var data ={type:"MWEB"};
 if(isApp()){
 if(isWeiXin()){
 data ={type:"JSAPI"};
 }
 }
 var url =  $("#url").val()+"/stadsa.do?weixinPay"
 $.ajax({
 url:url,
 datatype:"text",
 type:"post",
 data:data,
 success:function(data1){
 var data = JSON.parse(data1);
 orderId = data.orderId;
 window.location.href=data.url;
 }
 });
 }*/
function paysss() {
    var data = {type: "MWEB"};
    if (isApp()) {
        if (isWeiXin()) {
            data = {type: "JSAPI"};
        }
    }
    var url = postUrl + "/stadsa.do?weixinPay"
    $.ajax({
        url: url,
        datatype: "text",
        type: "post",
        data: data,
        success: function (data1) {
            var data = JSON.parse(data1);
            orderId = data.orderId;
            indexObject.orderId = orderId;
            //addOrder(indexQuery,indexStype,indexObject);//添加订单信息
            timeSet = setInterval(function () {
                if (!ddsyntony) {
                    ajaxPost(postUrl + "/stads.do?payIf", {orderId: orderId}, function (data) {
                        syncOrder(data, indexQuery, indexStype, indexObject);
                    });
                } else {
                    window.clearInterval(timeSet);
                }
            }, 500);
            window.location.href = data.url;
        }
    });
}
/**
 * 查询当前订单支付状态
 * @param result 查询当前用户信息是否是vip返回结果
 * @param query 查询内容
 * @param stype 请求类型 1.机构 2.专家 3.主题
 * @param object 需要被保存的数据
 *          name:人物姓名
 *          orgs:机构名称
 *         auIds:机构唯一编号
 *         ckeys:检索关键词
 *          type:类型
 *           org:机构名称
 *       newOpen:是否打开新窗口 true打开 false直接在本页面中打开
 */
function syncOrder(result, query, stype, object) {
    if (result == 1) {
        saveInfo(stype, object);//支付成功后保存订单状态
        ddsyntony = true;
        hideJqueryModalPlug("#demoModal2");
        hideJqueryModalPlug("#demoModal4");
        openNewPage(stype, object);//打开新页面
    }
}

/**
 * 打开新页面
 * @param stype 请求类型 1.机构 2.专家 3.主题
 * @param object 需要被保存的数据
 *          name:人物姓名
 *          orgs:机构名称
 *         auIds:机构唯一编号
 *         ckeys:检索关键词
 *          type:类型
 *           org:机构名称
 *       newOpen:是否打开新窗口 true打开 false直接在本页面中打开
 */
function openNewPage(stype, object) {
    if (stype == 1) {
        if (object.newOpen == true) {
            window.location.replace(postUrl + "/orgController.do?toOrg");
        } else {
            window.location.replace(postUrl + "/orgController.do?toOrg");
//			window.open(postUrl+"/orgController.do?toOrg","_self");
        }
    } else if (stype == 2) {
        if (object.newOpen == true) {
            window.location.replace(postUrl + "/exportController.do?toExpert");
        } else {
            window.location.replace(postUrl + "/exportController.do?toExpert");
//			window.open(postUrl+"/exportController.do?toExpert","_self");
        }
    } else if (stype == 3) {
        if (object.newOpen == true) {
            window.location.replace(postUrl + "/ckeyController.do?toCkeyPage");
        } else {
            window.location.replace(postUrl + "/ckeyController.do?toCkeyPage");
//			window.open(postUrl+"/ckeyController.do?toCkeyPage","_self");
        }
    }
}

/**
 * 显示微信支付二维码
 * @param query 查询内容
 * @param stype 类型 1.机构 2.专家 3.主题
 * @param object 需要被保存的数据
 *          name:人物姓名
 *          orgs:机构名称
 *         auIds:机构唯一编号
 *         ckeys:检索关键词
 *          type:类型
 *           org:机构名称
 *       newOpen:是否打开新窗口 true打开 false直接在本页面中打开
 */
function wxpay(query, stype, object) {
    $.ajax({
        url: postUrl + "/stads.do?weixinPay",
        method: "post",
        async: false,
        data: {
            orgs: encodeURI(object.orgs, "UTF-8"),
            title: encodeURI(object.query, "UTF-8"),
            query: encodeURI(object.query, "UTF-8"),
            ckeys: encodeURI(object.ckeys, "UTF-8"),
            type: encodeURI(object.type, "UTF-8")
        },
        success: function (result) {
            result = JSON.parse(result);
            var img = result.img;//图片内容(用于发送于微信扫描后的信息)
            orderId = result.orderId;
            object.orderId = result.orderId;//订单编号
            //addOrder(query,stype,object);//添加订单信息
            $("#erweima").html("");//重新清空二维码
            var qrcode = new QRCode("erweima", {//显示二维码
                text: img,
                width: 184,
                height: 184,
                colorDark: '#000',
                colorLight: '#fff',
                correctLevel: QRCode.CorrectLevel.H
            });
        }
    });
}

/**
 * 向数据库中添加信息
 * @param query 查询内容
 * @param stype 类型 1.机构 2.专家 3.主题
 * @param object 需要被保存的数据
 *       orderId:订单编号
 *          name:人物姓名
 *          orgs:机构名称
 *         auIds:机构唯一编号
 *         ckeys:检索关键词
 *          type:类型
 *           org:机构名称
 *         query:查询信息
 *       newOpen:是否打开新窗口 true打开 false直接在本页面中打开
 */
function addOrder(query, stype, object) {
    object.stype = stype;
    object.title = query;
    object.query = query;
    var appid = getParam("appid");
    if (object.query == undefined || object.query == null || object.query == "undefined" || object.query == "null" || object.query == "" || object.query == " ") object.query = "";
    if (object.title == undefined || object.title == null || object.title == "undefined" || object.title == "null" || object.title == "" || object.title == " ") object.title = "";
    if (object.name == undefined || object.name == null || object.name == "undefined" || object.name == "null" || object.name == "" || object.name == " ") object.name = "";
    if (object.orgs == undefined || object.orgs == null || object.orgs == "undefined" || object.orgs == "null" || object.orgs == "" || object.orgs == " ") object.orgs = "";
    if (object.ckeys == undefined || object.ckeys == null || object.ckeys == "undefined" || object.ckeys == "null" || object.ckeys == "" || object.ckeys == " ") object.ckeys = "";
    if (object.org == undefined || object.org == null || object.org == "undefined" || object.org == "null" || object.org == "" || object.org == " ") object.org = "";

    object.query = encodeURI(object.query, "UTF-8")
    object.title = encodeURI(object.title, "UTF-8")
    object.name = encodeURI(object.name, "UTF-8")
    object.orgs = encodeURI(object.orgs, "UTF-8")
    object.ckeys = encodeURI(object.ckeys, "UTF-8")
    object.org = encodeURI(object.org, "UTF-8")
    object.appid = appid;
    $.ajax({
        url: postUrl + "/stads.do?addOrderInfo",
        method: "post",
        data: object,
        async: false,
        success: function () {
            object.query = decodeURI(object.query, "UTF-8")
            object.title = decodeURI(object.title, "UTF-8")
            object.name = decodeURI(object.name, "UTF-8")
            object.orgs = decodeURI(object.orgs, "UTF-8")
            object.ckeys = decodeURI(object.ckeys, "UTF-8")
            object.org = decodeURI(object.org, "UTF-8")
            object.appid = appid;
        }
    })
}

/**
 * 支付成功后保存本地信息
 * @param result 查询当前用户信息是否是vip返回结果
 * @param stype 请求类型 1.机构 2.专家 3.主题
 * @param object 需要被保存的数据
 *          name:人物姓名
 *          orgs:机构名称
 *         auIds:机构唯一编号
 *         ckeys:检索关键词
 *          type:类型
 *           org:机构名称
 *       newOpen:是否打开新窗口 true打开 false直接在本页面中打开
 */
function saveInfo(stype, object) {
    object.query = decodeURI(object.query)
    object.title = decodeURI(object.title)
    object.name = decodeURI(object.name)
    object.orgs = decodeURI(object.orgs)
    object.ckeys = decodeURI(object.ckeys)
    object.org = decodeURI(object.org)

    window.localStorage.clear();//清除当前缓存数据
    if (object.name != undefined && object.name != null && object.name != "undefined" && object.name != "null" && object.name != "" && object.name != " ") {
        window.localStorage.setItem("name", encodeURI(object.name, "UTF-8"));
    }
    if (object.orgs != undefined && object.orgs != null && object.orgs != "undefined" && object.orgs != "null" && object.orgs != "" && object.orgs != " ") {
        for (var j = 0; j < object.orgs.length; j++) {
            if (object.orgs.indexOf("(") == -1 && object.orgs.indexOf(")") == -1 && object.orgs.indexOf("（") == -1 && object.orgs.indexOf("）") == -1)break;
            object.orgs = object.orgs.replace(/[(]/, "");
            object.orgs = object.orgs.replace(/[)]/, "");
            object.orgs = object.orgs.replace(/[（]/, "");
            object.orgs = object.orgs.replace(/[）]/, "");
        }
        window.localStorage.setItem("orgs", encodeURI(object.orgs, "UTF-8"));
    }
    if (object.auIds != undefined && object.auIds != null && object.auIds != "undefined" && object.auIds != "null" && object.auIds != "" && object.auIds != " ")
        window.localStorage.setItem("auIds", encodeURI(object.auIds, "UTF-8"));
    if (object.ckeys != undefined && object.ckeys != null && object.ckeys != "undefined" && object.ckeys != "null" && object.ckeys != "" && object.ckeys != " ")
        window.localStorage.setItem("ckeys", encodeURI(object.ckeys, "UTF-8"));
    if (object.type != undefined && object.type != null && object.type != "undefined" && object.type != "null" && object.type != "" && object.type != " ")
        window.localStorage.setItem("type", encodeURI(object.type, "UTF-8"));
    if (object.org != undefined && object.org != null && object.org != "undefined" && object.org != "null" && object.org != "" && object.org != " ") {
        for (var j = 0; j < object.org.length; j++) {
            if (object.org.indexOf("(") == -1 && object.org.indexOf(")") == -1 && object.org.indexOf("（") == -1 && object.org.indexOf("）") == -1)break;
            object.org = object.org.replace(/[(]/, "");
            object.org = object.org.replace(/[)]/, "");
            object.org = object.org.replace(/[（]/, "");
            object.org = object.org.replace(/[）]/, "");
        }
        window.localStorage.setItem("org", encodeURI(object.org, "UTF-8"));
    }
}
//请求前访问控制
function doProduceReport(orgs, title, query, stype, ckeys, type) {
    window.clearInterval(timeSet);
    orgs2 = orgs;
    title2 = title;
    query2 = query;
    stype2 = stype;
    var appid = getParam("appid");
    var url = $("#url").val() + '/stads.do?vipIf';
    $(".s_list").css("display", "none");
    $("#reportinfo").html("报告生成中");
    //显示报告生成中模态框
    //showJqueryModalPlug("#demoModal1",{"top":"100","hide":false});
    $.ajax({
        url: url,
        type: 'get',
        datatype: 'json',
        data: {
            type: stype,
            appid: appid,
            query: query
        },
        success: function (data1) {
            var data = eval('(' + data1 + ')');
            var count = data.count;
            var surplus = data.totalCount;
            var sy = surplus - count;
            var totalCount = surplus + count;
            var vipif = data.vipIf;
            var userif = data.userIf;
            localStorage.clear();
            var postUrl = window.location.href.substring(0, window.location.href.substring(0, window.location.href.indexOf("?")).lastIndexOf("/"));
            if (vipif == 1) {
                if (stype == 1) {//机构
                    localStorage.setItem("org", query2);
                    window.location.href = postUrl + "/orgController.do?toOrg";
                } else if (stype == 2) {//专家
                    localStorage.setItem("name", query2);
                    localStorage.setItem("orgs", orgs2);
                    window.location.href = postUrl + "/exportController.do?toExpert";
                } else if (stype == 3) {//主题
                    localStorage.setItem("ckeys", query2);
                    window.location.href = postUrl + "/ckeyController.do?toCkeyPage";
                }
            } else {
                if (userif == 1) {
                    if (surplus > 0) {
                        if (stype == 1) {//机构
                            localStorage.setItem("org", query2);
                            window.location.href = postUrl + "/orgController.do?toOrg";
                        } else if (stype == 2) {//专家
                            localStorage.setItem("name", query2);
                            localStorage.setItem("orgs", orgs2);
                            window.location.href = postUrl + "/exportController.do?toExpert";
                        } else if (stype == 3) {//主题
                            localStorage.setItem("ckeys", query2);
                            window.location.href = postUrl + "/ckeyController.do?toCkeyPage";
                        }
                    } else {
                        //显示二维码
                        //判断当前是否是手机浏览器打开的页面
                        if (isApp()) {
                            hideJqueryModalPlug("#demoModal1");
                            hideJqueryModalPlug("#demoModal2");
                            showJqueryModalPlug("#demoModal4", {"top": "100", "hide": true});
                        } else {
                            hideJqueryModalPlug("#demoModal1");
                            showJqueryModalPlug("#demoModal2", {"top": "100", "hide": true});
                            $("#erweima").html("");
                            weixinpay(orgs, title, query, stype, ckeys, type);
                            ddsyntony = false;
                            if (stype == 1) {//机构
                                localStorage.setItem("org", query2);
                            } else if (stype == 2) {//专家
                                localStorage.setItem("name", query2);
                                localStorage.setItem("orgs", orgs2);
                            } else if (stype == 3) {//主题
                                localStorage.setItem("ckeys", query2);
                            }
                            timeSet = setInterval(function () {
                                if (!ddsyntony) {
                                    syntony(orgs, title, query, stype);
                                } else {
                                    window.clearInterval(timeSet);
                                }
                            }, 500);
                        }
                    }
                } else {
                    window.location.href = $("#url").val() + '/stads.do?tologin';
                }
            }
            showBg('CXZS2017_dialog', 'CXZS2017_dialog_content');
        }
    });
}


/**
 * 判断当前是首页浏览还是pc浏览
 * true 手机浏览
 * false pc浏览
 */
var isApp = function () {
    var browser = {
        versions: function () {
            var u = navigator.userAgent, app = navigator.appVersion;
            return {
                trident: u.indexOf('Trident') > -1, //IE内核
                presto: u.indexOf('Presto') > -1, //opera内核
                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
                mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
                webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
            };
        }()
    }
    if (browser.versions.ios || browser.versions.android || browser.versions.iPhone || browser.versions.iPad) {
        app = true;
        return true;
    }
    else {
        app = false;
        return false;
    }
};

/*
 * 判断当前页面是否是微信浏览器打开
 * true 是
 * false 不是
 */
function isWeiXin() {
    var ua = window.navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == 'micromessenger') {
        return true;
    } else {
        return false;
    }
}


//*************************************************************************************************************************
function weixinpay(orgs, title, query, stype, ckeys, type) {
    var url = window.location.href.substring(0, window.location.href.substring(0, window.location.href.indexOf("?")).lastIndexOf("/")) + '/stads.do?weixinPay';
    $.ajax({
        url: url,
        type: 'get',
        datatype: 'json',
        success: function (data1) {
            var data = JSON.parse(data1);
            var img = data.img;
            orderId = data.orderId;
            addOrderInfo(orderId, orgs, title, query, stype, null, ckeys, type);
            $("#erweima").html("");
            // 设置参数方式
            var qrcode = new QRCode('erweima', {
                text: img,
                width: 184,
                height: 184,
                colorDark: '#000000',
                colorLight: '#ffffff',
                correctLevel: QRCode.CorrectLevel.H
            });
        }
    })
}
function addOrderInfo(orderId, orgs, title, query, stype, location, ckeys, type) {
    var url = window.location.href.substring(0, window.location.href.substring(0, window.location.href.indexOf("?")).lastIndexOf("/")) + '/stads.do?addOrderInfo';
    var para = {
        orderId: orderId,
        orgs: orgs,
        title: title,
        query: query,
        stype: stype,
        ckeys: ckeys,
        type: type
    };
    $.ajax({
        url: url,
        datatype: "json",
        data: para,
        type: "post",
        success: function () {
            if (location != null && location != "" && location != undefined) {
                windown.location.href = location;
            }
        }
    });
}
function syntony(orgs, title, query, stype) {
    var url = window.location.href.substring(0, window.location.href.substring(0, window.location.href.indexOf("?")).lastIndexOf("/")) + '/stads.do?payIf';
    $.ajax({
        url: url,
        type: 'get',
        data: {orderId: orderId},
        datatype: 'json',
        success: function (data) {
            if (data == 1) {
                ddsyntony = true;
                hideJqueryModalPlug("#demoModal2");//隐藏第二个模态框
                $("#reportinfo").html("报告生成中");
                hideJqueryModalPlug("#demoModal2");
                hideJqueryModalPlug("#demoModal4");
                //showJqueryModalPlug("#demoModal4",{"top":"100","hide":false});
                var postUrl = window.location.href.substring(0, window.location.href.substring(0, window.location.href.indexOf("?")).lastIndexOf("/"));
                if (stype == 1) {//机构
                    //localStorage.setItem("org",query);
                    window.location.href = postUrl + "/orgController.do?toOrg";
                } else if (stype == 2) {//专家
                    //localStorage.setItem("name",query);
                    //localStorage.setItem("orgs",orgs);
                    window.location.href = postUrl + "/exportController.do?toExpert";
                } else if (stype == 3) {//主题
                    //localStorage.setItem("ckeys",query);
                    window.location.href = postUrl + "/ckeyController.do?toCkeyPage";
                }
            }
        }
    })
}
//*************************************************************************************************************************
//提交机构信息获取报告
function getOrgReport() {
    var title = $("#orgName").val();
    if (title == "") {
        return;
    }
    if (isStrip(title)) {
        alert("对不起，检索词中包含非法字符！");
        return;
    }
    var query = $("#orgName").val();  //检索的关键词
    var stype = 1;   // 1.查机构 2.找专家 3.定主题
    doProduceReport("", title, query, stype, "", type);
}
//*************************************************************************************************************************
//提交主题信息获取报告
function getCkeyReport() {
    var title = $("#ckeyName").val();
    if (title == "") {
        return;
    }
    if (isStrip(title)) {
        alert("对不起，检索词中包含非法字符！");
        return;
    }
    var query = $("#ckeyName").val();  //检索的关键词
    var stype = 3;   // 1.查机构 2.找专家 3.定主题
    doProduceReport("", title, query, stype, "", "");
}
//*************************************************************************************************************************
//提交专家信息获取报告
function getExpertReport() {
    var title = $("#expertName").val();
    if (title == "") {
        return;
    }
    if (isStrip(title)) {
        alert("对不起，检索词中包含非法字符！");
        return;
    }
    var query = $("#expertName").val();  //检索的关键词
    //var orgs = $("#orgsChoice li a").html(); //机构名称 可以为空
    var orgs = "";
    var auIds = "";
    $('*[name="ORgNameChoiced"]').each(function () {
        orgs = orgs + "|" + $(this).html();
        auIds = auIds + "|" + $(this).attr("data-auId");
    })
    orgs = orgs.replace("|", "");
    auIds = auIds.replace("|", "");
    localStorage.clear();
    localStorage.setItem("name", title);
    localStorage.setItem("orgs", orgs);
    localStorage.setItem("auIds", auIds);
    var stype = 2;   // 1.查机构 2.找专家 3.定主题
    doProduceReport(orgs, title, query, stype, ckeys, type);
}

function showBg(ct, content) {
    timeAdd();
    var bH = $("body").height();
    var bW = $("body").width() + 16;
    var objWH = getObjWh(ct);
    $("#fullbg").css({width: bW, height: bH, display: "block"});
    var tbT = objWH.split("|")[0] + "px";
    var tbL = objWH.split("|")[1] + "px";
    $("#" + ct).css({top: tbT, left: tbL, display: "block"});
    $(window).scroll(function () {
        resetBg()
    });
    $(window).resize(function () {
        resetBg()
    });
}

function getObjWh(obj) {
    var st = document.documentElement.scrollTop;//滚动条距顶部的距离
    var sl = document.documentElement.scrollLeft;//滚动条距左边的距离
    var ch = document.documentElement.clientHeight;//屏幕的高度
    var cw = document.documentElement.clientWidth;//屏幕的宽度
    var objH = $("#" + obj).height();//浮动对象的高度
    var objW = $("#" + obj).width();//浮动对象的宽度
    var winH = window.screen.height; //窗口的高度
    var objT = Number(st) + (Number(winH) - Number(objH) * 2) / 2;
    var objL = Number(sl) + (Number(cw) - Number(objW)) / 2;
    return objT + "|" + objL;
}

function resetBg() {
    var fullbg = $("#fullbg").css("display");
    if (fullbg == "block") {
        var bH2 = $("body").height();
        var bW2 = $("body").width() + 16;
        $("#fullbg").css({width: bW2, height: bH2});
        var objV = getObjWh("CXZS2017_dialog");
        var tbT = objV.split("|")[0] + "px";
        var tbL = objV.split("|")[1] + "px";
        $("#CXZS2017_dialog").css({top: "100px", left: tbL});
    }
}

//关闭灰色JS遮罩层和操作窗口 
function closeBg() {
    $("#fullbg").css("display", "none");
    $("#CXZS2017_dialog").css("display", "none");
}
function closeBg2() {
    closeBg();
    stopIf = false;
    window.clearInterval(timeSet);
}

$(document).ready(function () {
    if (window.orderId != null && window.orderId != "" && window.orderId != 0) {
        showJqueryModalPlug("#demoModal5", {"top": "100", "hide": true});
        orderId = 0;
    }
});


function syntony2(orgs1, title1, query1, stype1) {
    var url = postUrl + '/stads.do?payIf';
    $.ajax({
        url: url,
        type: 'get',
        data: {orderId: orderId},
        datatype: 'json',
        success: function (data) {
            if (data == 1) {
                ddsyntony = true;
                hideJqueryModalPlug("#demoModal5");//隐藏第5个模态框
                $("#reportinfo").html("报告生成中");
                hideJqueryModalPlug("#demoModal4");
                syncOrder(data, indexQuery, indexStype, indexObject);
                //showJqueryModalPlug("#demoModal1",100,false);//显示第一个模态框
                //doProduceReport2(orgs1, title1, query1, stype1);
            } else {
                showJqueryModalPlug("#demoModal6", {"top": "100", "hide": true});
            }
        }
    });
}

$(function () {
    $("#demoModal4 div button").click(function (e) {
        e.preventDefault();
        hideJqueryModalPlug("#demoModal4");
    });
    $("#payNo").click(function () {
        hideJqueryModalPlug("#demoModal5");
    });
    $("#payYes").click(function () {
        syntony2(orgs2, title2, query2, stype2);
        hideJqueryModalPlug("#demoModal5");
    });
    $("#demoModal4").submit(function (e) {
        e.preventDefault();
        setTimeout(function () {
            showJqueryModalPlug("#demoModal5", {"top": "100", "hide": false});
        }, 1000);
        hideJqueryModalPlug("#demoModal4");
        paysss();//显示微信支付页面
    });
    $("#demoModal4>span").click(function () {
        hideJqueryModalPlug("#demoModal4");
    });
});


function testdemo() {
    showJqueryModalPlug("#demoModal4", {"top": "100", "hide": false});
}

function is_weixn() {
    var ua = navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == "micromessenger") {
        return true;
    } else {
        return false;
    }
}
function getParam(paramName) {
    paramValue = "", isFound = !1;
    if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=") > 1) {
        arrSource = unescape(this.location.search).substring(1, this.location.search.length).split("&"), i = 0;
        while (i < arrSource.length && !isFound) arrSource[i].indexOf("=") > 0 && arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase() && (paramValue = arrSource[i].split("=")[1], isFound = !0), i++
    }
    return paramValue == "" && (paramValue = null), paramValue
}
function userIf() {
    var url = window.location.href.substring(0, window.location.href.substring(0, window.location.href.indexOf("?")).lastIndexOf("/")) + '/stads.do?userIf';
    $.ajax({
        url: url,
        datatype: "json",
        type: "post",
        async: false,
        success: function (data) {
            if (data == 0) {
                window.location.href = window.location.href.substring(0, window.location.href.substring(0, window.location.href.indexOf("?")).lastIndexOf("/")) + '/stads.do?tologin';
            }
        }
    });
}
