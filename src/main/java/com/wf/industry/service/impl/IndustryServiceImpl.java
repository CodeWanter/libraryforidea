package com.wf.industry.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.industry.mapper.IndustryMapper;
import com.wf.industry.service.IIndustryService;
import com.wf.model.Industry;

@Service
public class IndustryServiceImpl extends ServiceImpl<IndustryMapper, Industry> implements IIndustryService {

	@Autowired
	private IndustryMapper industryMapper;

	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		page.setOrderByField(pageInfo.getSort());
		page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = industryMapper.selectIndustryPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}
    @Override
    public List<Industry> selectAll() {
        return selectAllByStatus();
    }
    private List<Industry> selectAllByStatus() {
    	Industry industry = new Industry();
        EntityWrapper<Industry> wrapper = new EntityWrapper<Industry>(industry);
        wrapper.orderBy("modify_time");
        return industryMapper.selectList(wrapper);
    }
}
