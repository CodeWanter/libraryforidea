package com.wf.model.vo;

import java.io.Serializable;
import java.util.Date;
import com.wf.commons.utils.JsonUtils;

/**
 * @description：UserVo
 * @author：zhixuan.wang
 * @date：2015/10/1 14:51
 */
public class ResVo implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String title;
	private String name;
	private String type;
	private String content;
	private Date createTime;
	private Date editTime;
	private Date createdateStart1;
	private Date createdateEnd1;
	private Integer tableName;



	public Integer getTableName() {
		return tableName;
	}


	public void setTableName(Integer tableName) {
		this.tableName = tableName;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public Date getCreatedateStart1() {
		return createdateStart1;
	}


	public void setCreatedateStart1(Date createdateStart1) {
		this.createdateStart1 = createdateStart1;
	}


	public Date getCreatedateEnd1() {
		return createdateEnd1;
	}


	public void setCreatedateEnd1(Date createdateEnd1) {
		this.createdateEnd1 = createdateEnd1;
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


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public Date getCreateTime() {
		return createTime;
	}


	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


	public Date getEditTime() {
		return editTime;
	}


	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}


	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}