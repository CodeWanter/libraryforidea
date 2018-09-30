package com.wf.policy.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.model.Policy;
import com.wf.policy.mapper.PolicyMapper;
import com.wf.policy.service.IPolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PolicyServiceImpl extends ServiceImpl<PolicyMapper, Policy> implements IPolicyService {

    @Autowired
    private PolicyMapper policyMapper;

    @Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = policyMapper.selectPolicyPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }
}
