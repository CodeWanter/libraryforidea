package com.wf.model;

import java.util.Date;

/**
 * Created by Mr_Wanter on 2018/8/6.
 * 数据采集模型
 */
public class CollectData {
    private Long id;
    private String title;
    private String url;
    private Date collectTime;
    private Integer isShow=0;//是否显示，默认显示，也可以理解为审核; 0 --显示 1--不显示
    private String orignFrom;//来源

    public String getOrignForm() {
        return orignFrom;
    }

    public void setOrignForm(String orignFrom) {
        this.orignFrom = orignFrom;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Date getCollectTime() {
        return collectTime;
    }

    public void setCollectTime(Date collectTime) {
        this.collectTime = collectTime;
    }

    public Integer getIsShow() {
        return isShow;
    }

    public void setIsShow(Integer isShow) {
        this.isShow = isShow;
    }
}
