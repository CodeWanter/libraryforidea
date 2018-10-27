package com.wf.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 中介机构-服务信息
 * @author Administrator
 *
 */

public class OrgService implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//主键id
    private Long id;
    //机构主键id
    private long orgId;
    //审核状态 0是为审核，1是审核通过，2是审核未通过
    private Integer pubflag;
    //服务名称
    private String serviceName;
    //服务类型
    private String serviceType;
    //服务介绍
    private String serviceIntro;
    //服务联系人
    private String serviceContact;
    //联系方式
    private String contactWay;
    //服务收费标准
    private String serviceFee;
    //服务指南(附件)
    private String serviceGuide;
    //创建时间
    private Date createTime;
    //修改时间
    private Date modifyTime;
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public long getOrgId() {
		return orgId;
	}
	public void setOrgId(long orgId) {
		this.orgId = orgId;
	}
	public Integer getPubflag() {
		return pubflag;
	}
	public void setPubflag(Integer pubflag) {
		this.pubflag = pubflag;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getServiceIntro() {
		return serviceIntro;
	}
	public void setServiceIntro(String serviceIntro) {
		this.serviceIntro = serviceIntro;
	}
	public String getServiceContact() {
		return serviceContact;
	}
	public void setServiceContact(String serviceContact) {
		this.serviceContact = serviceContact;
	}
	public String getContactWay() {
		return contactWay;
	}
	public void setContactWay(String contactWay) {
		this.contactWay = contactWay;
	}
	public String getServiceFee() {
		return serviceFee;
	}
	public void setServiceFee(String serviceFee) {
		this.serviceFee = serviceFee;
	}
	public String getServiceGuide() {
		return serviceGuide;
	}
	public void setServiceGuide(String serviceGuide) {
		this.serviceGuide = serviceGuide;
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
    
    

}
