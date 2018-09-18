package com.wf.model.vo;

import com.wf.commons.utils.JsonUtils;
import org.springframework.web.util.HtmlUtils;

import java.io.Serializable;
import java.util.Date;
/**
 * @description：UserVo
 * @author：zhixuan.wang
 * @date：2015/10/1 14:51
 */
public class IndustryEachVo implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Integer resId;
	private Integer auditing;
	private Integer tableName;
	private String title;
	private String type;
	private String content;
	private Date createTime;
	private Date editTime;
	
	public Integer getAuditing() {
		return auditing;
	}

	public void setAuditing(Integer auditing) {
		this.auditing = auditing;
	}
	
	public Integer getResId() {
		return resId;
	}

	public void setResId(Integer resId) {
		this.resId = resId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getTableName() {
		return tableName;
	}

	public void setTableName(Integer tableName) {
		this.tableName = tableName;
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

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}