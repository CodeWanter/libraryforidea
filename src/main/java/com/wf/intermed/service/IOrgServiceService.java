package com.wf.intermed.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.commons.result.Tree;
import com.wf.model.OrgService;


public interface IOrgServiceService extends IService<OrgService> {
	
	public void selectDataGrid(PageInfo pageInfo);
	
	
}
