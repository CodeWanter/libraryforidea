package com.wf.model;


import java.io.Serializable;
@SuppressWarnings("serial")
public class ResInfo implements Serializable{

	private int resId;
	private String resName;
	private String resTblName;
	private String resDesc;
	
	public int getResId() {
		return resId;
	}

	public void setResId(int resId) {
		this.resId = resId;
	}

	public String getResName() {
		return resName;
	}

	public void setResName(String resName) {
		this.resName = resName;
	}

	public String getResTblName() {
		return resTblName;
	}

	public void setResTblName(String resTblName) {
		this.resTblName = resTblName;
	}

	public String getResDesc() {
		return resDesc;
	}

	public void setResDesc(String resDesc) {
		this.resDesc = resDesc;
	}
}
