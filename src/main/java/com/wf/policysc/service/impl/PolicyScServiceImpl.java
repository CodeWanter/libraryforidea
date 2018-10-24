package com.wf.policysc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.model.PolicySc;
import com.wf.policysc.mapper.PolicyScMapper;
import com.wf.policysc.service.IPolicyScService;

@Service
public class PolicyScServiceImpl extends ServiceImpl<PolicyScMapper, PolicySc> implements IPolicyScService {

	@Autowired
	private PolicyScMapper policyScMapper;
	
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = policyScMapper.selectPolicyScPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
	}
	
}
