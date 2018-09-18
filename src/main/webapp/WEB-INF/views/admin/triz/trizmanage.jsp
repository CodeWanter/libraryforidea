<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<link rel="stylesheet" href="${staticPath }/static/js/zTree_v3/css/metroStyle/metroStyle.css" type="text/css">
<%--<script type="text/javascript" src="${staticPath }/static/js/zTree_v3/js/jquery-1.4.4.min.js"></script>--%>
<script type="text/javascript" src="${staticPath }/static/js/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${staticPath }/static/js/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${staticPath }/static/js/zTree_v3/js/jquery.ztree.exedit.js"></script>
<script type="text/javascript">
    var setting = {
        view: {
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            selectedMulti: false
        },
        async: {
            enable: true,
            url: "${staticPath }/trizback/trizTree",
            autoParam: [],
            contentType: "application/json",
            otherParam: {name: ""},
            dataFilter: filter //异步获取的数据filter 里面可以进行处理  filter 在下面
        },
        edit: {
            enable: true,
            editNameSelectAll: true,
            showRemoveBtn: showRemoveBtn
            //showRenameBtn: showRenameBtn
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeDrag: beforeDrag,
            beforeEditName: beforeEditName,
            beforeRemove: beforeRemove,
            beforeRename: beforeRename,
            onRemove: onRemove,
            onRename: onRename
        }
    };

    var log, className = "dark";
    function beforeDrag(treeId, treeNodes) {
        return false;
    }
    function beforeEditName(treeId, treeNode) {
        className = (className === "dark" ? "" : "dark");
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.selectNode(treeNode);
        setTimeout(function () {
            zTree.editName(treeNode);

        }, 0);
        return false;
    }
    //删除节点之前
    function beforeRemove(treeId, treeNode) {
        className = (className === "dark" ? "" : "dark");
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.selectNode(treeNode);
        if (treeNode.isParent) {
            alert("请先删除子节点！");
            return false;
        } else {
            return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
        }
    }
    //删除节点
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_" + treeNode.tId).unbind().remove();
    };
    //删除节点之后
    function onRemove(e, treeId, treeNode) {
        $.post("${staticPath }/trizback/delete", {"id": treeNode.id}, function (data) {
        });
    }
    function beforeRename(treeId, treeNode, newName, isCancel) {
        className = (className === "dark" ? "" : "dark");
        if (newName.length == 0) {
            setTimeout(function () {
                var zTree = $.fn.zTree.getZTreeObj("treeDemo");
                zTree.cancelEditName();
                alert("节点名称不能为空.");
            }, 0);
            return false;
        }
        return true;
    }
    // 编辑名称结束之后
    function onRename(e, treeId, treeNode, isCancel) {
        $.post("${staticPath }/trizback/edit", {
            "id": treeNode.id,
            "nodeName": treeNode.name,
            "parentId": treeNode.pId,
            "status": 1
        }, function (data) {
            $.messager.show({
                title: 'Tip',
                msg: data.msg,
                showType: 'show'
            }, 500);
        }, "json");
    }
    var newCount = 1;
    //添加节点
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='add node' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var btn = $("#addBtn_" + treeNode.tId);
        if (btn) btn.bind("click", function () {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            $.post("${staticPath }/trizback/save", {
                "nodeName": "new node",
                "parentId": treeNode.id,
                "status": 1
            }, function (data) {
                zTree.addNodes(treeNode, {id: data.obj.id, pId: treeNode.id, name: "new node" + (newCount++)});
                $.messager.show({
                    title: 'Tip',
                    msg: data.msg,
                    showType: 'show'
                }, 500);
            }, "json");

            return false;
        });
    };

    function selectAll() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.setting.edit.editNameSelectAll = $("#selectAll").attr("checked");

        alert()
    }


    //根节点不允许删除
    function showRemoveBtn(treeId, treeNode) {
        return treeNode.id != 1;
    }
    function filter(treeId, parentNode, childNodes) {
        if (!childNodes) return null;
        for (var i = 0, l = childNodes.length; i < l; i++) {
            childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
        }
        return childNodes;
    }
    $(document).ready(function () {
        var treeObj = $.fn.zTree.init($("#treeDemo"), setting);
        $("#selectAll").bind("click", selectAll);
    });
    function searchTreeFun() {
        $.post("${staticPath }/trizback/trizTree", {"name": $("#treename").val()}, function (data) {
            var treeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
        }, "json")
    }
    function cleanTreeFun() {
        $('#treename').val('');
        $.post("${staticPath }/trizback/trizTree", {"name": $("#treename").val()}, function (data) {
            var treeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
        }, "json")
    }
    $('#excelform').form({
        url: '${staticPath }/trizback/ajaxUpload',
        onSubmit: function (param) {
            progressLoad();
            var isValid = $(this).form('validate');
            if (!isValid) {
                progressClose();
            }
            return isValid;
        },
        success: function (result) {
            progressClose();
            console.log(result);
            result = $.parseJSON(result);
            $.messager.alert({
                title: 'Tip',
                msg: result.msg,
                fn: function () {
                    $.fn.zTree.init($("#treeDemo"), setting);
                }
            });
        }
    });
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form>
            <table>
                <tr>
                    <th>节点名:</th>
                    <td><input type="text" name="name" placeholder="请输入节点名:" id="treename"/></td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-search',plain:true" onclick="searchTreeFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'glyphicon-remove-circle',plain:true" onclick="cleanTreeFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'west',border:true,title:'TRIZ管理'" style="width:300px;overflow: hidden; ">
        <div title="TRIZ" style="width: 300px; padding: 1px;">
            <div class="well well-small">
                <ul id="treeDemo" class="ztree"></ul>
            </div>
        </div>
    </div>
    <div data-options="region:'center',border:true,title:'TRIZ管理流程介绍'" style="width:150px;overflow: hidden; ">
        <div style="margin: 80px 220px;">
            <p style="font-size:14px;text-indent: 20px;">我能做什么？</p>
            <ul style="line-height: 40px;height: 40px;">
                <li>基于TRIZ的知识关系的可视化展示，架构TRIZ专利知识树以及发明创造知识树，设置主题管理。</li>
                <li>在创新服务平台中对TRIZ知识树关联的专利数据进行展示。</li>
                <li>可添加多级节点保存TRIZ专利知识树。</li>
                <li>对任意一级的知识节点模糊查询。</li>
                <li>管理维护知识树节点。</li>
                <li>默认以节点名称为关键检索词进行专利查询。</li>
                <li>批量上传知识树。<a href="${staticPath }/static/lsportal/file/treeDemo.xls" style="color: #00b2ff">样例下载</a>
                </li>
                <form method="POST" enctype="multipart/form-data" id="excelform">
                    <table>
                        <tr>
                            <td>上传文件:</td>
                            <td><input id="upfile" name="upfile" data-options="required:true" class="easyui-filebox"
                                       data-options="prompt:'Choose a file...'"></td>
                            <td><input type="submit" value="提交" class="easyui-linkbutton"></td>
                        </tr>
                    </table>
                </form>
            </ul>
        </div>
    </div>
</div>