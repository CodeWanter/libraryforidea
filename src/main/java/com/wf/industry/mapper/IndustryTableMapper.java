package com.wf.industry.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.IndustryData;
import com.wf.model.vo.IndustryEachVo;

public interface IndustryTableMapper extends BaseMapper<IndustryData>{
	List<Map<String, Object>> selectIndustryPage(Pagination page, Map<String, Object> params);

	IndustryEachVo selectByID(@Param("id") Long id);
}
