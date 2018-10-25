package com.wf.model;

import com.baomidou.mybatisplus.annotations.TableField;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Mr_Wanter on 2018/9/3.
 * 用户行为统计实体
 */
public class LogStatistics implements Serializable {

    private Long id;//id
    private Long userId;//用户id
    private String userIp;//用户ip
    @TableField(exist=false)
    private String userName;//用户名
    private Date accessTime;//访问时间
    private String accessType;//访问类型   资源浏览/下载/借阅/新闻浏览/专题浏览
    private String userBrower;//浏览器
    private String url;//浏览地址
    private String keyWord;//检索词
    private String industry;

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

    public String getUserIp() {
        return userIp;
    }

    public void setUserIp(String userIp) {
        this.userIp = userIp;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getAccessTime() {
        return accessTime;
    }

    public void setAccessTime(Date accessTime) {
        this.accessTime = accessTime;
    }

    public String getAccessType() {
        return accessType;
    }

    public void setAccessType(String accessType) {
        this.accessType = accessType;
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

    public String getKeyWord() {
        return keyWord;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }
}
