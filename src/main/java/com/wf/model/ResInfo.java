package com.wf.model;


import java.io.Serializable;
import java.util.Date;
public class ResInfo implements Serializable{

	private int resId;
	private String resName;
	private String resTblName;
	private String resDesc;
	private Integer resFlow;
	private Date resDate;
	private String resType;
	private String resTemplate;
	private String showTemp;
	private Integer resAccount;
	private Date resUpdateTime;
	private Double resBalance;
	public Double getResBalance() {
		return resBalance;
	}
	public void setResBalance(Double resBalance) {
		this.resBalance = resBalance;
	}

	public Integer getResAccount() {
		return resAccount;
	}

	public void setResAccount(Integer resAccount) {
		this.resAccount = resAccount;
	}

	public Date getResUpdateTime() {
		return resUpdateTime;
	}

	public void setResUpdateTime(Date resUpdateTime) {
		this.resUpdateTime = resUpdateTime;
	}

	public String getShowTemp() {
		return showTemp;
	}

	public void setShowTemp(String showTemp) {
		this.showTemp = showTemp;
	}

	public String getResTemplate() {
		return resTemplate;
	}

	public void setResTemplate(String resTemplate) {
		this.resTemplate = resTemplate;
	}

	public String getResType() {
		return resType;
	}

	public void setResType(String resType) {
		this.resType = resType;
	}

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

	public Date getResDate() {
		return resDate;
	}

	public void setResDate(Date resDate) {
		this.resDate = resDate;
	}

	public Integer getResFlow() {
		return resFlow;
	}

	public void setResFlow(Integer resFlow) {
		this.resFlow = resFlow;
	}
	
	
}
