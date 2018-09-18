package com.wf.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Mr_Wanter on 2018/9/17.
 */
public class AccessLog implements Serializable {
    private Long id;
    private String resType;
    private String dataStore;
    private Date createTime;
    private String userBrower;//浏览器
    private String url;//浏览地址
    private String userIp;//用户ip

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getResType() {
        return resType;
    }

    public void setResType(String resType) {
        this.resType = resType;
    }

    public String getDataStore() {
        return dataStore;
    }

    public void setDataStore(String dataStore) {
        this.dataStore = dataStore;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUserBrower() {
        return userBrower;
    }

    public void setUserBrower(String userBrower) {
        this.userBrower = userBrower;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUserIp() {
        return userIp;
    }

    public void setUserIp(String userIp) {
        this.userIp = userIp;
    }
}
