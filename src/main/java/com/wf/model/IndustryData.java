package com.wf.model;

import com.wf.commons.utils.JsonUtils;
import org.springframework.web.util.HtmlUtils;

import java.io.Serializable;
import java.util.Date;

/*
 * 文章实体 by zhanghuaiyu 2018.08.01
 */
public class IndustryData implements Serializable{
	private static final long serialVersionUID = 1L;
	private Long id;
	private String title;
	private String type;
	private String content;
	private Date createTime;
	private Date editTime;
	private Integer tableName;//产业id
	private Integer auditing;

	public Integer getAuditing() {
		return auditing;
	}
	public void setAuditing(Integer auditing) {
		this.auditing = auditing;
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
        //return Industrys.getStr(type);
        return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		content = HtmlUtils.htmlUnescape(content);
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
	public Integer getTableName() {
		return tableName;
	}
	public void setTableName(Integer tableName) {
		this.tableName = tableName;
	}
	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
