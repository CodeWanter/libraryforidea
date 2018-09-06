package com.wf.industry.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.BeanUtils;
import com.wf.commons.utils.StringUtils;
import com.wf.industry.mapper.IndustryMapper;
import com.wf.industry.mapper.IndustryTableMapper;
import com.wf.industry.mapper.ResInfoMapper;
import com.wf.industry.service.industryTableService;
import com.wf.model.IndustryData;
import com.wf.model.ResInfo;
import com.wf.model.vo.IndustryEachVo;

@Service
public class industryTableServiceImpl extends ServiceImpl<IndustryTableMapper, IndustryData> implements industryTableService {
	@Autowired
	private IndustryTableMapper industryTableMapper;
	@Autowired
	private ResInfoMapper resInfoMapper;
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
	public List<IndustryData> selectByTableName(int tableName) {
		//根据tableName在res_info中查res_id，res_id 在表industry_data中查数据返回
		IndustryData industryData = new IndustryData();
		industryData.setTableName(tableName);
		EntityWrapper<IndustryData> wrapper = new EntityWrapper<IndustryData>(industryData);
		return this.selectList(wrapper);
	}
}
