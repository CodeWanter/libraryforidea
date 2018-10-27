package com.wf.intermed.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.commons.result.Tree;
import com.wf.model.IntermedOrg;

public interface IIntermedOrgService extends IService<IntermedOrg> {
	
	public void selectDataGrid(PageInfo pageInfo);
	
	public List<Tree> selectTree();
	public List<IntermedOrg> selectTreeGrid();
}
