package com.wf.industry.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.wf.industry.service.IIndustryTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.BeanUtils;
import com.wf.industry.mapper.IndustryTableMapper;
import com.wf.model.IndustryData;
import com.wf.model.vo.IndustryEachVo;

@Service
public class IndustryTableServiceImp extends ServiceImpl<IndustryTableMapper, IndustryData> implements IIndustryTableService {

	@Autowired
	private IndustryTableMapper industryTableMapper;
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		page.setOrderByField(pageInfo.getSort());
		page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = industryTableMapper.selectIndustryPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}

	@Override
	public IndustryEachVo selectByID(Long id) {
		return industryTableMapper.selectByID(id);
	}

	@Override
	public void updateByVo(IndustryEachVo industryEachVo) {
		IndustryData industryData = BeanUtils.copy(industryEachVo, IndustryData.class);
		EntityWrapper<IndustryData> wrapper = new EntityWrapper<IndustryData>(industryData);
		this.update(industryData, wrapper);
	}

	@Override
	public void insertByVo(IndustryEachVo industryEachVo) {
		IndustryData industryData = BeanUtils.copy(industryEachVo, IndustryData.class);
		industryData.setCreateTime(new Date());
		this.insert(industryData);
	}

	@Override
	public void deleteEachById(Long id) {
		this.deleteById(id);
	}

	@Override
	public Page<IndustryData> selectByTableName(Integer id) {
		IndustryData industryData = new IndustryData();
		industryData.setTableName(id);
		Wrapper<IndustryData> wrapper = new EntityWrapper<IndustryData>(industryData);

		return this.selectPage(new Page<IndustryData>(1,10),wrapper);
	}

	@Override
	public List<IndustryData> selectByIdAType(String id, String tid) {
		EntityWrapper<IndustryData> wrapper = new EntityWrapper<IndustryData>();
		wrapper.where("table_name = {0}",id).andNew("type = {0}",tid).andNew("auditing = {0}","1").orderBy("create_time");
		return this.selectList(wrapper);
	}
}
