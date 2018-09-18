<%--
  Created by IntelliJ IDEA.
  User: Mr_Wanter
  Date: 2018/9/3
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<input type="hidden" value="${startTime}" id="startTime"/>
<input type="hidden" value="${endTime}" id="endTime"/>
<div id="container" style="min-width:400px;height:400px"></div>

<script type="text/javascript">
    if (!$.fn.highcharts) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = "${staticPath }/static/js/highchart/highcharts.js";
        document.body.appendChild(script);
    }

    $(function () {
        progressLoad();
        $.post("${staticPath }/accesslog/getChartData", {
            startTime: $("#startTime").val(),
            endTime: $("#endTime").val()
        }, function (result) {
            var categories = result.categories;
            var data = result.result;
            var seriesdata = new Array();
            ;
            //设置柱状图数据
            $.each(data, function (key, val) {
                seriesdata.push({"name": val.name, "data": val.data});
            });
            console.log(seriesdata);
            var chart = new Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: '资源访问统计'
                },
                subtitle: {
                    text: '数据来源:丽水市网络图书馆'
                },
                xAxis: {
                    categories: categories,
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: '访问量 (人)'
                    }
                },
                tooltip: {
                    // head + 每个 point + footer 拼接成完整的 table
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y} 人</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        borderWidth: 0
                    }
                },
                series: seriesdata
            });
            progressClose();
        }, "json")
    });
</script>