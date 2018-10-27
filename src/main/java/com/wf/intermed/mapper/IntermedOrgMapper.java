package com.wf.intermed.mapper;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.IntermedOrg;

public interface IntermedOrgMapper extends BaseMapper<IntermedOrg> {
	
	List<Map<String, Object>> selectPageIntermedOrg(Pagination page, Map<String, Object> params);
	
	
}
