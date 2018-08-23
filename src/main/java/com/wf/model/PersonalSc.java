package com.wf.model;

import java.util.Date;

/**
 * Created by huangjunqing on 2018/8/23.
 * 个人收藏
 */
public class PersonalSc {
    private Long id;
    private Long userId;
    private String title;
    private String author;
    private Date time;
    private String source;
	private String abstractZY;
    private String url;
    
    public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getAbstractZY() {
		return abstractZY;
	}
	public void setAbstractZY(String abstractZY) {
		this.abstractZY = abstractZY;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
    
    
}
