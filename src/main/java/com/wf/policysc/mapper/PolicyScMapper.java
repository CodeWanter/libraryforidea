package com.wf.policysc.mapper;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.PolicySc;

public interface PolicyScMapper extends BaseMapper<PolicySc> {
	List<Map<String, Object>> selectPolicyScPage(Pagination page, Map<String, Object> params);
}
