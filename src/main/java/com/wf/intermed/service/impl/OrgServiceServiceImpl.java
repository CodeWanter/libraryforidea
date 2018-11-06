package com.wf.intermed.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.intermed.mapper.OrgServiceMapper;
import com.wf.intermed.service.IOrgServiceService;
import com.wf.model.OrgService;

@Service
public class OrgServiceServiceImpl extends ServiceImpl<OrgServiceMapper, OrgService> implements IOrgServiceService {
	
	@Autowired
	private OrgServiceMapper orgServiceMapper;
	
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = orgServiceMapper.selectOrgServicePage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());

	}

	
	
	
	
	

}
