<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/commons/layui.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>机构中心</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css"/>
    <link rel="stylesheet" href="${staticPath }/static/js/pagination_zh/lib/pagination.css"/>
    <script charset="utf-8" src="${staticPath }/static/js/pagination_zh/lib/jquery.pagination.js"></script>

    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/newresourse.js"></script>
    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/mysc.js"></script>
    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/myrecomend.js"></script>
    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/myorder.js"></script>
    <script charset="utf-8" src="${staticPath }/static/lsportal/js/personal/mydeliver.js"></script>

    <script type="text/javascript">

        $("#centreID").trigger("click");
        function select(sel) {
            if ($("#personCentreID .current").html() != sel.value) {
                if (sel.id == "centreID") {
                    //个人资料选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#centreID").addClass("current");
                    //将body中其他模块不显示，只显示个人资料的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#centreDIVID").css({display: 'inline'});
                } else if (sel.id == "pswEditID") {
                    //密码修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#pswEditID").addClass("current");
                    //将body中其他模块不显示，只显示密码修改的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#pswEditDIVID").css({display: 'inline'});
                } else if (sel.id == "dYID") {
                    //我的订阅修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#dYID").addClass("current");
                    //将body中其他模块不显示，只显示我的订阅的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#dYDIVID").css({display: 'inline'});
                    servicePageInit();
                } else if (sel.id == "tJID") {
                    //我的推荐修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#tJID").addClass("current");
                    //将body中其他模块不显示，只显示我的推荐的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#tJDIVID").css({display: 'inline'});
                    personalRecommendInit();
                } else if (sel.id == "sCID") {
                    //我的收藏修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#sCID").addClass("current");
                    //将body中其他模块不显示，只显示我的收藏的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#sCDIVID").css({display: 'inline'});
                    personalScInit();
                } else if (sel.id == "dCID") {
                    //我的收藏修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#dCID").addClass("current");
                    //将body中其他模块不显示，只显示我的收藏的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#dCDIVID").css({display: 'inline'});
                    personalDeliverInit();
                } else if (sel.id == "ZXZY") {
                    //最新资源修改选中状态
                    $("#personCentreID .current").removeClass("current");
                    $("#ZXZY").addClass("current");
                    //将body中其他模块不显示，只显示我的收藏的模块
                    $(".LS2018_Aright").css({display: 'none'});
                    $("#newResource").css({display: 'inline'});
                    newResourseInit();
                }
            }
        }
        //修改个人资料
        function centre() {
            var logName = $("#centreLogNameID").val();
            var name = $("#centreNameID").val();
            var sex = $("#centreSexID option:selected").val();
            var age = $("#centreAgeID").val();
            var phone = $("#centrePhoneID").val();
            var email = $("#email").val();
            var industry = $("#industry1 option:selected").val() + "/" + $("#industry2 option:selected").val();
            var education = $("#educate option:selected").val();
            var professor = $("#professor").val();

            console.log(logName + "," + name + "," + sex + "," + age + "," + phone);
            $.ajax({
                type: "post",
                url: '${path}/forehead/personal/centerEdit',
                data: {
                    "logName": logName,
                    "name": name,
                    "sex": sex,
                    "age": age,
                    "phone": phone,
                    "email": email,
                    "industry": industry,
                    "education": education,
                    "professor": professor
                },
                async: true,
                dataType: "json",
                success: function (result) {
                    if (result.success) {
                        layer.msg(result.msg);
                    } else {
                        layer.msg(result.msg);
                        <%--layer.msg(result.msg,function(){--%>
                        <%--window.location.href="${path}/";--%>
                        <%--});--%>
                    }
                }
            });
        }
        //修改密码
        function pswEdit() {
            var oldPwd = $("[name='oldPwd']").val();
            var pwd = $("[name='pwd']").val();
            var rePwd = $("[name='rePwd']").val();
            if (oldPwd == "") {
                layer.msg("原密码不能为空!");
                return;
            }
            if (pwd == "") {
                layer.msg("新密码不能为空!");
                return;
            }
            if (pwd != rePwd) {
                if (pwd != "" && rePwd != "") {
                    layer.msg("两次密码输入不一致!");
                    return;
                } else if (pwd != "" && rePwd == "") {
                    layer.msg("请再次输入新密码!");
                    return;
                } else if (pwd == "" && rePwd != "") {
                    layer.msg("请输入新密码!");
                    return;
                }
            }
            if (pwd == oldPwd) {
                layer.msg("原密码和新密码相同！");
                return;
            }
            $.ajax({
                type: "post",
                url: '${path}/user/editUserPwd',
                data: {"oldPwd": oldPwd, "pwd": pwd},
                async: true,
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.success) {
                        layer.msg(result.msg);
                        $("[name='oldPwd']").val("");
                        $("[name='pwd']").val("");
                        $("[name='rePwd']").val("");
                    } else {
                        layer.msg(result.msg);
                    }
                }
            });
        }
        //编辑
        function edit() {
            var sss = confirm('重新编辑机构信息后需要再次进行审核，您确定要编辑吗？');
            if (sss) {
                $("#editOrgForm input[disabled='disabled']").removeAttr("disabled");
                $("#orgIntro").removeAttr("disabled");
                $("#shzt").hide()
                $("#bjbt").hide();
                $("#yyzzsc").show();
                $("#bcbt").show();
            }

        }
        function update() {
            var load = layer.load();
            $.ajax({
                type: "post",
                url: '${path }/intermedOrg/update',
                data: $("#editOrgForm").serialize(),

                success: function (result) {
                    layer.close(load);
                    result = eval("(" + result + ")");

                    if (result.success) {
                        layer.msg(result.msg)
                    } else {
                        layer.msg(result.msg);
                    }
                    window.location.reload();
                }
            });
        }

        var servicePage = 1;
        var servicePageSize = 10;
        var orgId = "";
        function servicePageInit() {
            orgId = $("#orgId").val();
            servicePaginationInit(servicePage, servicePageSize);
        }
        function servicePaginationInit(servicePage, servicePageSize) {
            $.get("${path }/orgService/myService?page=" + servicePage + "&rows=" + servicePageSize + "&orgId=" + orgId + "&sort=createTime&order=desc",
                {},
                function (data) {
                    data = JSON.parse(data);
                    var total = data.total;
                    if (data.total > 100) {
                        total = 100;
                    }
                    $("#servicePagination").pagination(total, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 10, //主体页数
                        callback: servicePaginationCallback, //回调函数
                        items_per_page: servicePageSize, //每页显示多少项
                        prev_text: "<<上一页",
                        next_text: "下一页>>"

                    });
                }
            );
        }
        function servicePaginationCallback(servicePage, jq) {
            var index;
            $.ajax({
                type: "post",
                url: "${path }/orgService/myService?page=" + servicePage + 1 + "&rows=" + servicePageSize + "&orgId=" + orgId + "&sort=createTime&order=desc",
                dataType: "json",
                async: true,
                beforeSend: function () {
                    index = layer.load(1);
                },
                complete: function () {
                    layer.close(index);
                },
                success: function (result) {
                    result = eval(result);
                    result = result.rows;


                    var html = "";
                    $.each(result, function (i, item) {
                        var shjg = "";
                        if (item.pubflag == '0') {
                            shjg = "未审核"
                        } else if (item.pubflag == '1') {
                            shjg = "审核通过"
                        } else if (item.pubflag == '2') {
                            shjg = "审核不通过"
                        }
                        html += "<tr>" +
                            "<td>" + item.serviceName + "</td>" +
                            "<td>" + shjg + "</td>" +
                            "<td>" + item.modifyTime + "</td>" +
                            "<td><a href='javascript:void(0)' onclick='editService(\"" + item.id + "\",\"" + item.pubflag + "\")'>编辑</a>" +
                            " | <a href='javascript:void(0)' onclick='delService(\"" + item.id + "\")'>删除</a></td>" +
                            "</tr>";

                    });
                    $("#serviceTab").html(html);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg('检索异常!');
                }
            });

        }
        //添加service
        function addService() {
            $(".LS2018_Aright").css({display: 'none'});
            $("#addService input[name='serviceName']").val("");
            $("#addService select[name='serviceType']").val("");
            $("#addService input[name='serviceContact']").val("");
            $("#addService input[name='contactWay']").val("");
            $("#addService textarea[name='serviceIntro']").val("");
            $("#addService input[name='serviceFee']").val("");
            $("#addService input[name='serviceGuideFile']").val("");
            $("#addService").show();
        }
        //添加service 保存
        function saveService() {
            if (checkService("addServiceForm")) {
                $.ajax({
                    type: "post",
                    async: true,
                    url: "${path }/orgService/myService/save",
                    data: $("#addServiceForm").serialize(),
                    success: function (result) {
                        result = eval("(" + result + ")");
                        layer.msg(result.msg);
                    }
                });
            }
        }

        //编辑service
        function editService(sId, pubflag) {
            var queding = true;
            if (pubflag == "1") {
                queding = confirm("编辑信息保存后需重新审核，您确定要编辑吗？")
            }
            if (queding) {
                $(".LS2018_Aright").css({display: 'none'});
                $("#editService").show();
                $.ajax({
                    type: "post",
                    async: true,
                    url: "${path }/orgService/detail?id=" + sId,
                    beforeSend: function () {
                        index = layer.load(1);
                    },
                    complete: function () {
                        layer.close(index);
                    },
                    success: function (result) {
                        if (result != null && result != "" && result != "[]") {
                            result = eval("(" + result + ")");
                            var serviceId = result.id;
                            var serviceOrgId = result.orgId;
                            var serviceName = result.serviceName;
                            var serviceType = result.serviceType;
                            var serviceContact = result.serviceContact;
                            var contactWay = result.contactWay;
                            var serviceIntro = result.serviceIntro;
                            var serviceGuide = result.serviceGuide;
                            var serviceFee = result.serviceFee;
                            $("#editServiceForm #serviceId").val(serviceId);
                            $("#editServiceForm #serviceOrgId").val(serviceOrgId);
                            $("#editServiceForm #serviceName").val(serviceName);
                            $("#editServiceForm #serviceType").val(serviceType);
                            $("#editServiceForm #serviceContact").val(serviceContact);
                            $("#editServiceForm #contactWay").val(contactWay);
                            $("#editServiceForm #serviceIntro").text(serviceIntro);
                            $("#editServiceForm #serviceFee").val(serviceFee);
                            if (serviceGuide != null && serviceGuide != "") {
                                var Astr = "<a href=" + serviceGuide + " download=''>查看已上传服务指南</a>"
                                $("#editServiceForm #yscfwzn").html(Astr);
                            }
                        }

                    }
                });
            }
        }
        //编辑service 保存
        function updateService() {
            var baocun = confirm("编辑信息保存后需重新审核，您确定要编辑吗？")
            if (baocun) {
                if (checkService("editServiceForm")) {
                    $.ajax({
                        type: "post",
                        async: true,
                        url: "${path }/orgService/myService/update",
                        data: $("#editServiceForm").serialize(),
                        success: function (result) {
                            result = eval("(" + result + ")");
                            layer.msg(result.msg);
                        }
                    });
                }
            }
        }
        function delService(sId) {
            alert(sId);
        }
        //添加保存前的校验
        function checkService(formid) {

            var msg = ""
            var serviceName = $("#" + formid + " input[name='serviceName']").val();
            var serviceType = $("#" + formid + " select[name='serviceType']").val();
            var serviceContact = $("#" + formid + " input[name='serviceContact']").val();
            var contactWay = $("#" + formid + " input[name='contactWay']").val();
            var serviceIntro = $("#" + formid + " textarea[name='serviceIntro']").val();
            var serviceFee = $("#" + formid + " input[name='serviceFee']").val();
            var serviceGuideFile = $("#" + formid + " input[name='serviceGuideFile']").val();

            if (formid == "addServiceForm") {
                if (serviceGuideFile == null || serviceGuideFile == "" || serviceGuideFile.trim == "") {
                    msg = "请上传服务指南！";
                }
            }
            if (serviceFee == null || serviceFee == "" || serviceFee.trim == "") {
                msg = "服务收费标准不能为空！";
            }
            if (serviceIntro == null || serviceIntro == "" || serviceIntro.trim == "") {
                msg = "服务介绍不能为空！";
            }
            if (contactWay == null || contactWay == "" || contactWay.trim == "") {
                msg = "联系方式不能为空！";
            }
            if (serviceContact == null || serviceContact == "" || serviceContact.trim == "") {
                msg = "服务联系人不能为空！";
            }
            if (serviceName == null || serviceName == "" || serviceName.trim == "") {
                msg = "服务名称不能为空！";
            }

            if (msg != "") {
                alert(msg);
                return false;
            } else {
                return true;
            }

        }
        //我的服务中的取消
        function cancelService() {
            $("#dYID").click();
        }
    </script>
    <style type="text/css">
        input[type="password"] {
            border: 1px #B3BDD0 solid;
            border-radius: 2px;
            width: 350px;
            height: 40px;
            padding: 0 5px;
            font-size: 15px;
        }

        em {
            font-style: normal;
        }

        .LS2018_GRZX_TB2 td {
            max-width: 300px;
            overflow: hidden;
            white-space: nowrap;
        }


    </style>
</head>

<body class="LS2018_body" onload="select($('#centreID'));">
<div class="LS2018_main">
    <%@ include file="/commons/head.jsp" %>
    <div class="LS2018_bd Z_clearfix">
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/">首 页</a><span class="gt">&gt;</span>机构中心
        </div>
        <div class="LS2018_GRZX2 Z_clearfix">
            <div class="LS2018_Aleft">

                <div class="LS2018_GRZX_lefttop">机构中心</div>
                <ul class="LS2018_GRZX_left_list" id="personCentreID">

                    <li><span>机构设置</span>
                        <ul>
                            <li><a id="centreID" value="机构资料" onclick="select(this);" class="current"
                                   style="cursor: pointer;">机构资料</a></li>
                            <li><a id="pswEditID" value="密码修改" onclick="select(this);" style="cursor: pointer;">密码修改</a>
                            </li>
                        </ul>
                    </li>
                    <li><a id="dYID" value="我的服务" onclick="select(this);" style="cursor: pointer;">我的服务</a></li>

                </ul>
            </div>
            <div class="LS2018_Aright" id="newResource" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 最新资源</h2></span>
                    <span style="float:right;margin-right: 10px;">
						</span>
                </div>
                <ul class="LS2018_List2" id="newResourceId">
                    数据整合中……
                </ul>
                <div id="newRPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
            </div>
            <%--个人资料--%>
            <div class="LS2018_Aright" id="centreDIVID" style="display: inline;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 机构资料</h2></span>
                    <span style="float:right;margin-right: 10px;">
						</span>
                </div>
                <form method="post" id="editOrgForm" class="layui-form">
                    <input type="hidden" name="id" id="orgId" value="${intermedOrg.id}"/>
                    <input type="hidden" name="pubflag" id="pubflag" value="0"/>
                    <table class="LS2018_GRZX_TB1">
                        <tr>
                            <td class="td1" style="width: 150px;">机构名称：</td>
                            <td><input type="text" id="orgName" name="orgName" value="${intermedOrg.orgName}"
                                       disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">机构联系人：</td>
                            <td><input placeholder="请输入姓名" type="text" id="contactName" name="contactName"
                                       value="${intermedOrg.contactName}" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">联系人电话：</td>
                            <td><input placeholder="请输入联系人电话" lay-verify="required|phone" type="text" id="contactTel"
                                       name="contactTel" value="${intermedOrg.contactTel}" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">联系人email：</td>
                            <td><input placeholder="请输入联系人email" lay-verify="required|email" type="text"
                                       id="contactEmail" name="contactEmail" value="${intermedOrg.contactEmail}"
                                       disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">机构代码：</td>
                            <td><input placeholder="请输入机构代码" type="text" id="orgCode" name="orgCode"
                                       value="${intermedOrg.orgCode}" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">机构介绍：</td>
                            <td><textarea placeholder="请输入机构介绍" type="text" id="orgIntro" name="orgIntro"
                                          disabled="disabled"
                                          style="width: 349px; height: 117px;resize: none;">${intermedOrg.orgIntro}
                            </textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">营业执照：</td>
                            <td>
                                <c:if test="${intermedOrg.businessLicense!=null && intermedOrg.businessLicense!=''}">
                                    <a href="${intermedOrg.businessLicense}" download="">查看已上传营业执照</a>
                                </c:if>
                                <input type="hidden" name="businessLicense" id="businessLicense"
                                       value="${intermedOrg.businessLicense}"/>

                                <input type="file" id="yyzzsc" name="businessLicenseFile" disabled="disabled"
                                       style="display:none;"/>
                            </td>
                        </tr>


                    </table>
                    <div class="LS2018_GRZX_btns">
						<span id="shzt">
						<c:if test="${intermedOrg.pubflag=='0'}">
                            <input class="btn1" type="button" value="未审核" style="background:#d2cd1e;"/>
                        </c:if>
						<c:if test="${intermedOrg.pubflag=='1'}">
                            <input class="btn1" type="button" value="已审核" style="background:#0cb247;"/>
                        </c:if>
						<c:if test="${intermedOrg.pubflag=='2'}">
                            <input class="btn1" type="button" value="审核不通过" style="background: #d21e1ee0;"/>
                        </c:if>
						</span>
                        <input class="btn1" type="button" value="编 辑" onclick="edit();" id="bjbt"/>
                        <input class="btn2" type="button" value="保 存" onclick="update()" style="display:none;"
                               id="bcbt"/>
                    </div>
                </form>
            </div>
            <!-- 密码修改 -->
            <div class="LS2018_Aright" id="pswEditDIVID" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 密码修改</h2></span>
                    <span style="float:right;margin-right: 10px;">
						</span>
                </div>
                <table class="LS2018_GRZX_TB1">
                    <tr>
                        <td class="td1" style="width: 150px;">用户名：</td>
                        <td><input type="text" disabled="disabled" value="<shiro:principal></shiro:principal>"/></td>
                    </tr>
                    <tr>
                        <td class="td1">原密码：</td>
                        <td><input type="password" name="oldPwd" value="" placeholder="请输入原密码"
                                   data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td class="td1">新密码：</td>
                        <td><input type="password" name="pwd" value="" placeholder="请输入新密码"
                                   data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td class="td1">确认密码：</td>
                        <td><input type="password" name="rePwd" value="" placeholder="请再次输入新密码"
                                   data-options="required:true"/></td>
                    </tr>
                </table>

                <div class="LS2018_GRZX_btns">
                    <input class="btn1" type="button" value="确 定" onclick="pswEdit();"/>
                    <input class="btn2" type="button" value="取 消" onclick="history.go('-1');"/>
                </div>
            </div>
            <!-- 我的服务 -->
            <div class="LS2018_Aright" id="dYDIVID" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 我的服务</h2></span>
                    <c:if test="${intermedOrg.pubflag=='1'}">
                        <div class="LS2018_GRZX_btns" style="float:left;height:40px;text-algin:left;padding:0px;">
                            <input style="height:30px;padding:0 14px;" class="btn1" type="button" value="添加服务"
                                   onclick="addService();"/>
                        </div>
                    </c:if>
                </div>
                <table class="LS2018_GRZX_TB2">
                    <tr>
                        <th style="width: 170px">服务名称

                        </th>
                        <th style="width: 90px">审核状态

                        </th>
                        <th style="min-width: 120px;">修改时间</th>
                        <th>操作</th>
                    </tr>
                    <tbody id="serviceTab">
                    </tbody>
                </table>
                <div id="servicePagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
            </div>
            <!-- 添加服务 -->
            <div class="LS2018_Aright" id="addService" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 服务添加</h2></span>
                    <span style="float:right;margin-right: 10px;">
						</span>
                </div>
                <form method="post" id="addServiceForm" onsubmit="checkSave()">
                    <input type="hidden" name="id"/>
                    <input type="hidden" name="orgId" value="${intermedOrg.id}"/>
                    <input type="hidden" name="pubflag" value="0"/>
                    <table class="LS2018_GRZX_TB1">
                        <tr>
                            <td class="td1" style="width: 150px;">服务名称：</td>
                            <td><input type="text" name="serviceName"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务类型：</td>
                            <td><select name="serviceType">
                                <option value="技术培训">技术培训</option>
                                <option value="知识产权">知识产权</option>
                                <option value="产学研合作">产学研合作</option>
                                <option value="项目申报">项目申报</option>
                                <option value="查新鉴定">查新鉴定</option>
                                <option value="政策咨询">政策咨询</option>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务联系人：</td>
                            <td><input type="text" name="serviceContact"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">联系方式：</td>
                            <td><input type="text" name="contactWay"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务介绍：</td>
                            <td><textarea name="serviceIntro" class="xt_textarea"
                                          style="width: 349px; height: 117px;resize: none;"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">收费标准：</td>
                            <td><input type="text" name="serviceFee"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务指南：</td>
                            <td>

                                <input type="file" name="serviceGuideFile"/>
                            </td>
                        </tr>

                    </table>

                    <div class="LS2018_GRZX_btns">
                        <input class="btn1" type="button" value="保 存" onclick="saveService();"/>
                        <input class="btn2" type="button" value="取 消" onclick="cancelService();"/>
                    </div>
                </form>
            </div>
            <!-- 服务修改 -->
            <div class="LS2018_Aright" id="editService" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 服务编辑</h2></span>
                    <span style="float:right;margin-right: 10px;">
						</span>
                </div>
                <form method="post" id="editServiceForm">
                    <input type="hidden" id="serviceId" name="id"/>
                    <input type="hidden" id="serviceOrgId" name="orgId"/>
                    <input type="hidden" id="servicePubflag" name="pubflag" value="0"/>
                    <table class="LS2018_GRZX_TB1">
                        <tr>
                            <td class="td1" style="width: 150px;">服务名称：</td>
                            <td><input type="text" id="serviceName" name="serviceName"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务类型：</td>
                            <td><select id="serviceType" name="serviceType">
                                <option value="技术培训">技术培训</option>
                                <option value="知识产权">知识产权</option>
                                <option value="产学研合作">产学研合作</option>
                                <option value="项目申报">项目申报</option>
                                <option value="查新鉴定">查新鉴定</option>
                                <option value="政策咨询">政策咨询</option>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务联系人：</td>
                            <td><input type="text" id="serviceContact" name="serviceContact"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">联系方式：</td>
                            <td><input type="text" id="contactWay" name="contactWay"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务介绍：</td>
                            <td><textarea name="serviceIntro" id="serviceIntro" class="xt_textarea"
                                          style="width: 349px; height: 117px;resize: none;"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">收费标准：</td>
                            <td><input type="text" id="serviceFee" name="serviceFee"/></td>
                        </tr>
                        <tr>
                            <td class="td1" style="width: 150px;">服务指南：</td>
                            <td>
                                <span id="yscfwzn"></span>
                                <input type="hidden" name="serviceGuide" id="serviceGuide"/>
                                <input type="file" id="serviceGuideFile" name="serviceGuideFile"/>
                            </td>
                        </tr>

                    </table>

                    <div class="LS2018_GRZX_btns">
                        <input class="btn1" type="button" value="保 存" onclick="updateService();"/>
                        <input class="btn2" type="button" value="取 消" onclick="cancelService();"/>
                    </div>
                </form>
            </div>


            <!-- 我的推荐 -->
            <div class="LS2018_Aright" id="tJDIVID" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 我的推荐</h2></span>
                    <span style="float:right;margin-right: 10px;">
						</span>
                </div>
                <ul class="LS2018_List2" id="recomendList">
                </ul>
                <div id="RecomendPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
            </div>
            <!-- 我的收藏 -->
            <div class="LS2018_Aright" id="sCDIVID" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 我的收藏</h2></span>
                    <span style="float:right;margin-right: 10px;">
							标题
					<select id="titleSelectID" onchange="personalSC('title',this)">
						<option value="desc">降序</option>
						<option value="asc">升序</option>
					</select>
					作者
					<select id="authorSelectID" onchange="personalSC('author',this)">
						<option value="desc">降序</option>
						<option value="asc">升序</option>
					</select>
					时间
					<select id="timeSelectID" onchange="personalSC('time',this)">
						<option value="desc">降序</option>
						<option value="asc">升序</option>
					</select>
						</span>
                </div>
                <ul class="LS2018_List2" id="personalSCId">
                </ul>
                <div id="Pagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
            </div>
            <%--原文传递--%>
            <div class="LS2018_Aright" id="dCDIVID" style="display: none;">
                <div style="border-bottom:solid 1px tomato;height: 45px;margin-bottom: 10px;">
                    <span style="float:left;"><h2><i class="layui-icon layui-icon-app"></i>&nbsp 原文传递</h2></span>
                    <span style="float:right;margin-right: 10px;">
						</span>
                </div>
                <ul class="LS2018_List2" id="personalDeliverId">
                </ul>
                <div id="DeliverPagination" class="dataTables_paginate paging_bootstrap pagination center"></div>
            </div>
        </div>
    </div>
    <%@ include file="/commons/footer.jsp" %>
</div>
<%
    String id = request.getSession().getId();
%>
<input type="hidden" id="sid" value="<%=id%>"/>
</body>
</html>
<script type="text/javascript">


    layui.use(['layer', 'form'], function () {
        var form = layui.form
            , layer = layui.layer;
        //自定义验证规则
        form.verify({});


    });
</script>