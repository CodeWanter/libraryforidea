package com.wf.model;

import java.io.Serializable;
import java.util.Date;
import com.wf.commons.utils.JsonUtils;

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



	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
