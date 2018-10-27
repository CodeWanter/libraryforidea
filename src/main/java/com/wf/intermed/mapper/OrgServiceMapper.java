package com.wf.intermed.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.OrgService;

public interface OrgServiceMapper extends BaseMapper<OrgService> {
	List<Map<String,Object>> selectOrgServicePage(Pagination page, Map<String, Object> params);
}
