package com.wf.industry.mapper;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.Industry;

public interface IndustryMapper extends BaseMapper<Industry>{
	
	List<Map<String, Object>> selectIndustryPage(Pagination page, Map<String, Object> params);
}
