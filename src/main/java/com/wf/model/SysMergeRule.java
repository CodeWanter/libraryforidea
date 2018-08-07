package com.wf.model;

import java.io.Serializable;

public class SysMergeRule implements Serializable{
	
	private static final long serialVersionUID = 1L;
	/** 主键ID*/
	private int id;
	/** 资源分类id*/
	private int resourceId;
	/** 所属馆ID*/
	private int libId;
	/** 资源库id*/
	private int tableId;
	/** 标准字段id*/
	private int normalFiledId;
	/** 实际字段*/
	private String actualFiled;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getResourceId() {
		return resourceId;
	}
	public void setResourceId(int resourceId) {
		this.resourceId = resourceId;
	}
	public int getLibId() {
		return libId;
	}
	public void setLibId(int libId) {
		this.libId = libId;
	}
	public int getTableId() {
		return tableId;
	}
	public void setTableId(int tableId) {
		this.tableId = tableId;
	}
	public int getNormalFiledId() {
		return normalFiledId;
	}
	public void setNormalFiledId(int normalFiledId) {
		this.normalFiledId = normalFiledId;
	}
	public String getActualFiled() {
		return actualFiled;
	}
	public void setActualFiled(String actualFiled) {
		this.actualFiled = actualFiled;
	}
}
