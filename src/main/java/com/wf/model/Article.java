package com.wf.model;

import java.io.Serializable;
import java.util.Date;

import com.wf.commons.utils.JsonUtils;
import org.springframework.web.util.HtmlUtils;

/*
 * 文章实体 by zhanghuaiyu 2018.08.01
 */
public class Article implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//主键id	
	private Long id;
	//文章标题
	private String title;
	//文章内容
	private String content;
	//文章类型
	private Integer articleType;//1--推荐类 2--公告类
	//创建时间
	private Date createTime;
	//修改时间
	private Date modifyTime;
	
	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
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

	public String getContent() {
		//由于后台文章添加时控制器继承了baseController，预防xss代码，所以取出后需要转义回来,此处也体现出public属性与get、set封装的区别
		content = HtmlUtils.htmlUnescape(content);
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getArticleType() {
		return articleType;
	}

	public void setArticleType(Integer type) {
		this.articleType = type;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
