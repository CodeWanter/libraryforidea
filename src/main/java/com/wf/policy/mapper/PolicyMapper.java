package com.wf.policy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.Policy;

import java.util.List;
import java.util.Map;

public interface PolicyMapper extends BaseMapper<Policy> {

    List<Map<String, Object>> selectPolicyPage(Pagination page, Map<String, Object> params);
}
