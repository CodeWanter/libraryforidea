package com.wf.intermed.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.wf.intermed.mapper.OrgServiceMapper;
import com.wf.intermed.service.IIntermedOrgService;
import com.wf.intermed.service.IOrgServiceService;
import com.wf.model.Industry;
import com.wf.model.IntermedOrg;
import com.wf.model.OrgService;
import com.wf.model.User;
import com.wf.user.mapper.UserMapper;
import com.wf.user.service.IUserService;


@Service
public class IntermedOrgServiceImpl extends ServiceImpl<IntermedOrgMapper,IntermedOrg> implements IIntermedOrgService{
	
	@Autowired
	private IntermedOrgMapper intermedOrgMapper;
	
	@Autowired
	private IUserService userService;
	
	@Autowired
	private IOrgServiceService orgServiceService;
	
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
	/**
	 * 删除机构同时删除机构下的服务和把用户状态禁用
	 */
	@Override
	public Boolean deleteOrgAndService(long orgId) {
		
		//设置之前的机构用户禁用
		Map<String, Object> condition = new HashMap<String, Object>();
    	condition.put("orgId", orgId);
		List<Map<String, Object>> selectUserByOrgId = userService.selectUserByOrgId(condition);
		for (Map<String, Object> map : selectUserByOrgId) {
			long uid = (long) map.get("id");
			User user = userService.selectById(uid);
			user.setStatus(1);
			userService.updateById(user);
		}
		
		//删除现有服务
		EntityWrapper<OrgService> wrapper = new EntityWrapper<OrgService>();
		wrapper.and("org_id = {0}", orgId);
		List<OrgService> selectList = orgServiceService.selectList(wrapper);
		for (OrgService orgService : selectList) {
			orgServiceService.deleteById(orgService.getId());
		}
		//删除机构
		boolean deleteById = this.deleteById(orgId);
		return deleteById;
	}

}
