package com.wf.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Mr_Wanter on 2018/8/28.
 * 我的订阅实体类
 */
public class PersonalOrder implements Serializable{
    private Long id;
    private Long userId;
    private String defineName;//自定义订阅名称
    private String abstractInfo;//摘要
    private Date createTime;//创建时间
    private String url;//订阅链接

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getDefineName() {
        return defineName;
    }

    public void setDefineName(String defineName) {
        this.defineName = defineName;
    }

    public String getAbstractInfo() {
        return abstractInfo;
    }

    public void setAbstractInfo(String abstractInfo) {
        this.abstractInfo = abstractInfo;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "PersonalOrder{" +
                "id=" + id +
                ", defineName='" + defineName + '\'' +
                ", abstractInfo='" + abstractInfo + '\'' +
                ", createTime=" + createTime +
                ", url='" + url + '\'' +
                '}';
    }
}
