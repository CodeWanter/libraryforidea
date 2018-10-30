<%--
  Created by IntelliJ IDEA.
  User: zhanghuaiyu
  Date: 2018/10/29
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="shior" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<html>
<head>
    <title>丽水市科技创新云服务平台</title>
    <link rel="stylesheet" type="text/css" href="${staticPath }/static/innovation/css/main.css"/>
</head>
<body>
<%@ include file="/commons/ihead.jsp" %>
<div class="LSKJ2018_bd">
    <table class="LSKJ2018_home_search">
        <tr>
            <td>
                <input id="txtKeyWord" name="txtKeyWord" type="text" value="请输入关键词"
                       onFocus="if (value =='请输入关键词'){value =''}" onBlur="if (value ==''){value='请输入关键词'}"
                       class="input1">
            </td>
            <td><input class="btn1" type="button" value="搜 索" onclick="lslibSearch();"/></td>
            <td class="hotwords" id="hotwords">
                热门搜索词：
                <a href="#" target="_blank">科技</a><a href="#" target="_blank">生态</a><a href="#" target="_blank">机械</a><a
                    href="#" target="_blank">钢材</a><a href="#" target="_blank">石雕</a>
            </td>
        </tr>
    </table>

    <div class="LSKJ2018_home_moduleL">
        <div class="top">
            <span class="tt">政策法规</span>
            <a class="more">更多&nbsp;&gt;</a>
        </div>
        <div class="middle">
            <ul id="policy6">

            </ul>
        </div>
    </div>

    <div class="LSKJ2018_home_moduleR">
        <div class="top">
            <span class="tt">通知公告</span>
            <a class="more">更多&nbsp;&gt;</a>
        </div>
        <div class="middle">
            <ul id="notice6">

            </ul>
        </div>
    </div>

    <div class="Z_clear"></div>


    <div class="LSKJ2018_home_title1">
        <div class="tt">中介服务展示</div>
    </div>

    <ul class="LSKJ2018_home_ZJFW Z_clearfix">
        <li class="Z_clearfix">
            <div class="left fw1"></div>
            <div class="right">
                <div class="top">
                    <a href="#">技术培训</a>
                </div>
                <div class="links Z_clearfix">
                    <label>· <a href="#" target="_blank">技术人才委培</a></label>
                    <label>· <a href="#" target="_blank">委培需求分析</a></label>
                    <label>· <a href="#" target="_blank">培训课程设计</a></label>
                    <label>· <a href="#" target="_blank">信息筛选</a></label>
                </div>
                <div class="price">
                    价格：<span class="money">1980</span>元起
                </div>
            </div>
        </li>
        <li class="Z_clearfix">
            <div class="left fw2"></div>
            <div class="right">
                <div class="top">
                    <a href="#">知识产权</a>
                </div>
                <div class="links Z_clearfix">
                    <label>· <a href="#" target="_blank">技术人才委培</a></label>
                    <label>· <a href="#" target="_blank">委培需求分析</a></label>
                    <label>· <a href="#" target="_blank">培训课程设计</a></label>
                    <label>· <a href="#" target="_blank">信息筛选</a></label>
                </div>
                <div class="price">
                    价格：<span class="money">1980</span>元起
                </div>
            </div>
        </li>
        <li class="Z_clearfix">
            <div class="left fw3"></div>
            <div class="right">
                <div class="top">
                    <a href="#">产学研合作</a>
                </div>
                <div class="links Z_clearfix">
                    <label>· <a href="#" target="_blank">技术人才委培</a></label>
                    <label>· <a href="#" target="_blank">委培需求分析</a></label>
                    <label>· <a href="#" target="_blank">培训课程设计</a></label>
                    <label>· <a href="#" target="_blank">信息筛选</a></label>
                </div>
                <div class="price">
                    价格：<span class="money">1980</span>元起
                </div>
            </div>
        </li>
        <li class="Z_clearfix">
            <div class="left fw4"></div>
            <div class="right">
                <div class="top">
                    <a href="#">项目申报</a>
                </div>
                <div class="links Z_clearfix">
                    <label>· <a href="#" target="_blank">技术人才委培</a></label>
                    <label>· <a href="#" target="_blank">委培需求分析</a></label>
                    <label>· <a href="#" target="_blank">培训课程设计</a></label>
                    <label>· <a href="#" target="_blank">信息筛选</a></label>
                </div>
                <div class="price">
                    价格：<span class="money">1980</span>元起
                </div>
            </div>
        </li>
        <li class="Z_clearfix">
            <div class="left fw5"></div>
            <div class="right">
                <div class="top">
                    <a href="#">查新鉴定</a>
                </div>
                <div class="links Z_clearfix">
                    <label>· <a href="#" target="_blank">技术人才委培</a></label>
                    <label>· <a href="#" target="_blank">委培需求分析</a></label>
                    <label>· <a href="#" target="_blank">培训课程设计</a></label>
                    <label>· <a href="#" target="_blank">信息筛选</a></label>
                </div>
                <div class="price">
                    价格：<span class="money">1980</span>元起
                </div>
            </div>
        </li>
        <li class="Z_clearfix">
            <div class="left fw6"></div>
            <div class="right">
                <div class="top">
                    <a href="#">政策咨询</a>
                </div>
                <div class="links Z_clearfix">
                    <label>· <a href="#" target="_blank">技术人才委培</a></label>
                    <label>· <a href="#" target="_blank">委培需求分析</a></label>
                    <label>· <a href="#" target="_blank">培训课程设计</a></label>
                    <label>· <a href="#" target="_blank">信息筛选</a></label>
                </div>
                <div class="price">
                    价格：<span class="money">1980</span>元起
                </div>
            </div>
        </li>
    </ul>


    <div class="LSKJ2018_home_title1">
        <div class="tt">
            <a href="#">专家人才展示</a>
        </div>
    </div>

    <div class="LSKJ2018_home_ZJRC">
        <ul class="Z_clearfix">
            <li>
                <div class="name"><a href="#" target="_blank">李汉美</a></div>
                <table class="TB1">
                    <tr>
                        <td colspan="2">工作单位：丽水市农业科学研究院</td>
                    </tr>
                    <tr>
                        <td>担任职务：高级农艺师</td>
                        <td>专业：蔬菜/旱粮</td>
                    </tr>
                </table>
            </li>
            <li>
                <div class="name"><a href="#" target="_blank">李汉美</a></div>
                <table class="TB1">
                    <tr>
                        <td colspan="2">工作单位：丽水市农业科学研究院</td>
                    </tr>
                    <tr>
                        <td>担任职务：高级农艺师</td>
                        <td>专业：蔬菜/旱粮</td>
                    </tr>
                </table>
            </li>
            <li>
                <div class="name"><a href="#" target="_blank">李汉美</a></div>
                <table class="TB1">
                    <tr>
                        <td colspan="2">工作单位：丽水市农业科学研究院</td>
                    </tr>
                    <tr>
                        <td>担任职务：高级农艺师</td>
                        <td>专业：蔬菜/旱粮</td>
                    </tr>
                </table>
            </li>
            <li>
                <div class="name"><a href="#" target="_blank">李汉美</a></div>
                <table class="TB1">
                    <tr>
                        <td colspan="2">工作单位：丽水市农业科学研究院</td>
                    </tr>
                    <tr>
                        <td>担任职务：高级农艺师</td>
                        <td>专业：蔬菜/旱粮</td>
                    </tr>
                </table>
            </li>
        </ul>
    </div>
</div>


<div class="LSKJ2018_ft">
    <div class="main Z_clearfix">
        <div class="left">
            <a href="#">关于我们</a>|<a href="#">版权声明</a>|<a href="#">免责声明</a>|<a href="#">联系我们</a>
        </div>

        <div class="right">
            版权所有：丽水市科技信息中心&nbsp;&nbsp;&nbsp;&nbsp;技术支持：北京万方数据股份有限公司
        </div>
    </div>
</div>

</body>
</html>
<script type="application/javascript">

    $(function () {
        //热门检索词
        $.ajax({
            type: "get",
            url: "${staticPath }/forehead/keyword/getTopSixKeyWordLog",
            dataType: "json",
            async: false,
            success: function (result) {
                $.each(result, function (i, item) {
                    $("#hotwords").append("<a onclick='tagSearch(\"" + item + "\");' href='javascript:void(0)' target='_blank'>" + item + "</a>")
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg('加载异常!');
            }
        });
        //通知公告
        $.post('${staticPath }/forehead/article/topTenData', {
            "title": "",
            "type": 1,
            "nowpage": 1,
            "pageSize": 6,
            "sort": "create_time",
            "order": "desc"
        }, function (result) {
            result = eval('(' + result + ')');
            var data = result.rows;
            var htmll = "";
            var htmlr = "";
            $.each(result.rows, function (i, item) {
                htmll += '<li><a href="${path }/forehead/article/detail?id=' + item.id + '">' + item.title + '</a><span class="time">' + item.createTime.substr(0, 10) + '</span></li>';
            });
            $("#notice6").append(htmll);
        });
        //政策法规
        $.post('${staticPath }/forehead/policy/topTenData', {
            "title": "",
            "nowpage": 1,
            "pageSize": 6,
            "sort": "create_time",
            "order": "desc"
        }, function (result) {
            result = eval('(' + result + ')');
            var data = result.rows;
            var htmll = "";
            var htmlr = "";
            $.each(result.rows, function (i, item) {
                htmll += '<li><a href="${path }/forehead/article/detail?id=' + item.id + '">' + item.title + '</a><span class="time">' + item.createTime.substr(0, 10) + '</span></li>';
            });
            $("#policy6").append(htmll);
        });

    });
    function tagSearch(str) {
        window.open("http://2018.lsnetlib.com:7007/search?source=baidu&q=" + str + "&returnFilter=true&sid=" + sid)
    }
    //洄图检索
    function lslibSearch() {
        var val = document.getElementById('txtKeyWord').value;
        var sid = $("#sid").val();
        sessionStorage.setItem("indName", "123");
        var searchUrl = "http://2018.lsnetlib.com:7007/search?&sid=" + sid + "&q=";
        searchUrl = searchUrl + encodeURI(document.getElementById("txtKeyWord").value);
        window.open(searchUrl);
    }
</script>