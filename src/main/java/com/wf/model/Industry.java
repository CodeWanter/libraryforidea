package com.wf.model;

import com.wf.commons.utils.JsonUtils;

import java.io.Serializable;
import java.util.Date;

/*
 * 产业库 by huangjunqing 2018.08.08
 */
public class Industry implements Serializable{
	private static final long serialVersionUID = 1L;
	//主键id	
	private Long id;
	//产业库名称
	private String title;
	//产业库名称
	private String fileName;
	//创建时间
	private Date createTime;
	//修改时间
	private Date modifyTime;
	//描述
	private String infomation;
	//点击量
	private Integer clickCount;
    //主题词
    private String topicKey;

	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
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
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public String getInfomation() {
		return infomation;
	}
	public void setInfomation(String infomation) {
		this.infomation = infomation;
	}
	public Integer getClickCount() {
		return clickCount;
	}
	public void setClickCount(Integer clickCount) {
		this.clickCount = clickCount;
	}

    public String getTopicKey() {
        return topicKey;
    }

    public void setTopicKey(String topicKey) {
        this.topicKey = topicKey;
    }

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
