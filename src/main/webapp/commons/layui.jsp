<%--标签 --%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--ctxPath--%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<%--项目路径 --%>
<c:set var="path" value="${ctxPath}" />
<%--静态文件目录 --%>
<c:set var="staticPath" value="${ctxPath}" />
<link rel="stylesheet" type="text/css"
      href="${staticPath }/static/js/layui/css/layui.css" />
<script charset="utf-8"
        src="${staticPath }/static/js/pagination_zh/lib/jquery.min.js"></script>
<script type="text/javascript"
        src="${staticPath }/static/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    //layui初始化
    layui.use('layer', function () {
        var $ = layui.jquery, layer = layui.layer;
    });
    var basePath = "${staticPath }";
</script>