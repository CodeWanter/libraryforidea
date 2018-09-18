package com.wf.model;

import java.io.Serializable;

/**
 * Created by Mr_Wanter on 2018/9/12.
 * TRIZ模块实体模型
 */
public class TRIZ implements Serializable {

    private Integer id;//id
    private String nodeName;//节点名称
    private Integer parentId;//父节点
    private Integer status;//开启状态 0 禁用 1开启

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "TRIZ{" +
                "id=" + id +
                ", nodeName='" + nodeName + '\'' +
                ", parentId=" + parentId +
                '}';
    }
}
