<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>注册</title>
    <%@ include file="/commons/basejs.jsp" %>
    <title>用户注册</title>
    <link rel="stylesheet" type="text/css"
          href="${staticPath }/static/js/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/static/lsportal/css/main.css"/>
    <link rel="stylesheet" type="text/css" href="${staticPath }/static/innovation/css/main.css"/>
</head>
<body>
<%@ include file="/commons/ihead.jsp" %>
<div class="LS2018_main">
    <div class="LS2018_bd Z_clearfix">
        <div class="LS2018_MBX">
            当前位置：&nbsp;<a href="${staticPath}/innovation/index">首 页</a><span class="gt">&gt;</span>用户注册
        </div>

        <div class="LS2018_Aleft" style="width:510px;">
            <form method="post" id="registform" class="layui-form">
                <input type="hidden" name="userType" value="1"/>
                <input type="hidden" name="status" value="0"/>
                <input type="hidden" name="roleIds" value=""/>
                <input type="hidden" name="name" value=""/>
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名:</label>
                    <div class="layui-input-block">
                        <input type="text" id="loginName" name="loginName"
                               lay-verify="loginName" autocomplete="off"
                               placeholder="请输入用户名" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">姓名:</label>
                    <div class="layui-input-block">
                        <input type="text" id="name" name="name"
                               lay-verify="name" autocomplete="off"
                               placeholder="请输入姓名" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密 码：</label>
                    <div class="layui-input-block">
                        <input type="password" id="password" name="password"
                               lay-verify="password" lay-verify="title" autocomplete="off"
                               placeholder="请输入密码" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">确认密码：</label>
                    <div class="layui-input-block">
                        <input type="password" id="comfimPassword"
                               lay-verify="comfimPassword" autocomplete="off"
                               placeholder="请输入密码" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">电话:</label>
                    <div class="layui-input-block">
                        <input type="text" id="phone" name="phone"
                               lay-verify="required|phone" autocomplete="off"
                               placeholder="请输入联系电话" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">Email:</label>
                    <div class="layui-input-block">
                        <input type="text" id="email" name="email"
                               lay-verify="email" autocomplete="off"
                               placeholder="请输入Email" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">行业:</label>
                    <div class="layui-input-inline">
                        <select name="industry1" lay-verify="industry1" lay-filter="industry" id="industry1"
                                class="industry1" lay-search>
                            <option value="">请选择行业</option>
                        </select>
                    </div>
                    <div class="layui-input-inline">
                        <select name="industry2" id="industry2" lay-verify="industry2" lay-search>
                            <option value="">请选择详细行业</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">学历:</label>
                    <div class="layui-input-block">
                        <select name="education">
                            <option value="" selected="">请选择学历</option>
                            <option value="小学">小学</option>
                            <option value="中学">中学</option>
                            <option value="高级中学">高级中学</option>
                            <option value="专科">专科</option>
                            <option value="本科">本科</option>
                            <option value="硕士研究生">硕士研究生</option>
                            <option value="博士研究生">博士研究生</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">职称:</label>
                    <div class="layui-input-block">
                        <input type="text" id="professor" name="professor"
                               lay-verify="professor" autocomplete="off"
                               placeholder="请输入职称" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">验证码:</label>
                    <div class="layui-input-block">
                        <P style="padding: 10px 0px 10px; position: relative;">
                            <input class="captcha layui-input" type="text" name="captcha"
                                   placeholder="请输入验证码"/> </br><img id="captcha" alt="验证码"
                                                                    src="${path }/captcha.jpg"
                                                                    data-src="${path }/captcha.jpg?t="
                                                                    style="vertical-align: middle; border-radius: 4px; width: 94.5px; height: 35px; cursor: pointer;">
                        </P>
                    </div>
                </div>
                <hr class="layui-bg-red">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <label for="accept-terms">我已阅读并同意 <a href="${staticPath }/static/html/protocol.html"
                                                             target="_blank">用户协议</a></label>
                        <div style="display: inline-block;vertical-align: middle;margin-top: -10px;">
                            <input type="checkbox" id="accept-terms" name="acceptprotocol" lay-skin="switch"
                                   lay-text="ON|OFF">
                        </div>
                        <%--<input type="checkbox" lay-skin="primary">--%>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="demo1"
                        >注册
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <div class="LS2018_Aright" style="width: 400px;margin-top: 80px;">
            <img src="${path }/static/lsportal/image/New_login_back.png"/>
        </div>
    </div>
</div>
</div>
<%@ include file="/commons/ifooter.jsp" %>
</body>
<script type="text/javascript"
        src="${staticPath }/static/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use(['form'], function () {
        var form = layui.form, layer = layui.layer;
        //自定义验证规则
        form.verify({
            loginName: function (value) {
                if (value.length < 5) {
                    return '用户名至少6个字符';
                }
                if (new RegExp("[\u4e00-\u9fa5]").test(value)) {
                    return '用户名不能是汉字';
                }
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '用户名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '用户名首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '用户名不能全为数字';
                }
            },
            password: [/(.+){4,12}$/, '密码必须4到12位'],
            comfimPassword: function (value) {
                if ($('#comfimPassword').val() !== value)
                    return '两次密码输入不一致！';
            },
            industry1: function (value) {
                if (value == "")
                    return '请选择行业！';
            },
            industry2: function (value) {
                if (value == "")
                    return '请选择详细行业！';
            }
        });
    });

    layui.use(['layer', 'jquery', 'form'], function () {
        $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;

        $.get("${staticPath }/static/lsportal/json/industry.json", function (data) {
            var proHtml = '';
            for (var i = 0; i < data.length; i++) {
                proHtml += '<option value="' + data[i].industry + '">' + data[i].industry + '</option>';
            }
            //初始化省数据
            $("select[name=industry1]").append(proHtml);
            form.render();
        }, "json")


        form.on('select(industry)', function (data) {
            $("select[name=industry2]").empty();
            form.render();
            $.get("${staticPath }/static/lsportal/json/industry.json", function (msg) {
                var cityHtml = '';
                cityHtml += '<option value="">请选择详细行业</option>';
                for (var i = 0; i < msg.length; i++) {
                    if (msg[i].industry == data.value) {
                        for (var j = 0; j < msg[i].city.length; j++) {
                            cityHtml += '<option value="' + msg[i].city[j].city_name + '">' + msg[i].city[j].city_name + '</option>';
                        }
                        break;
                    }
                }
                //初始化省数据
                $("select[name=industry2]").append(cityHtml);
                form.render();
            }, "json")
        });


    });

    // 注册
    $('#registform').form({
        url: basePath + '/add',
        onSubmit: function (param) {
            param.industry = $("#industry1 option:selected").val() + "/" + $("#industry2 option:selected").val();
            var isValid = $(this).form('validate');
            if (!isValid) {
                progressClose();
            }
            return isValid;
        },
        success: function (result) {
            result = $.parseJSON(result);
            if (result.success) {
                layer.msg("注册成功");
                window.location.href = basePath + '/forehead/index';
            } else {
                // 刷新验证码
                $("#captcha")[0].click();
                layer.msg(result.msg);
            }
        }
    });

    // 验证码
    $("#captcha").click(function () {
        var $this = $(this);
        var url = $this.data("src") + new Date().getTime();
        $this.attr("src", url);
    });
</script>
</html>