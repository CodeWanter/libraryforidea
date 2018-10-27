package com.wf.model;

import java.io.Serializable;
import java.util.Date;


/**
 * 中介机构信息
 * @author Administrator
 *
 */
public class IntermedOrg implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//主键id
    private Long id;
    //审核状态 0是为审核，1是审核通过，2是审核未通过
    private Integer pubflag;
    //机构名称
    private String orgName;
    //联系人
    private String contactName;
    //联系电话
    private String contactTel;
    //联系邮箱
    private String contactEmail;
    //营业执照
    private String businessLicense;
    //机构代码
    private String orgCode;
    //机构介绍
    private String orgIntro;
    //前台要显示的字段
    private String showFields;
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
	public Integer getPubflag() {
		return pubflag;
	}
	public void setPubflag(Integer pubflag) {
		this.pubflag = pubflag;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}
	public String getContactEmail() {
		return contactEmail;
	}
	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}
	public String getBusinessLicense() {
		return businessLicense;
	}
	public void setBusinessLicense(String businessLicense) {
		this.businessLicense = businessLicense;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getOrgIntro() {
		return orgIntro;
	}
	public void setOrgIntro(String orgIntro) {
		this.orgIntro = orgIntro;
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
	public String getShowFields() {
		return showFields;
	}
	public void setShowFields(String showFields) {
		this.showFields = showFields;
	}
    
    
    
    
    

}
