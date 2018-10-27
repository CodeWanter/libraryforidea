package com.wf.intermed.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.commons.result.Tree;
import com.wf.intermed.mapper.IntermedOrgMapper;
import com.wf.intermed.service.IIntermedOrgService;
import com.wf.model.Industry;
import com.wf.model.IntermedOrg;


@Service
public class IntermedOrgServiceImpl extends ServiceImpl<IntermedOrgMapper,IntermedOrg> implements IIntermedOrgService{
	
	@Autowired
	private IntermedOrgMapper intermedOrgMapper;
	
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = intermedOrgMapper.selectPageIntermedOrg(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
		
	}
	
	@Override
	public List<Tree> selectTree() {
		List<IntermedOrg> intermedOrgList = selectTreeGrid();

		List<Tree> trees = new ArrayList<Tree>();
		if (intermedOrgList != null) {
			for (IntermedOrg intermedOrg : intermedOrgList) {
				Tree tree = new Tree();
				tree.setId(intermedOrg.getId());
				tree.setText(intermedOrg.getOrgName());
				tree.setIconCls("glyphicon-send");
				trees.add(tree);
			}
		}
		return trees;
	}

	@Override
	public List<IntermedOrg> selectTreeGrid() {
		EntityWrapper<IntermedOrg> wrapper = new EntityWrapper<IntermedOrg>();
		wrapper.orderBy("create_time");
		return intermedOrgMapper.selectList(wrapper);
	}
	
	

}
