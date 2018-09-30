package com.wf.deliver.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.Deliver;

import java.util.List;
import java.util.Map;

public interface DeliverMapper extends BaseMapper<Deliver> {

    List<Map<String, Object>> selectDeliverPage(Pagination page, Map<String, Object> params);

    List<Map<String, Object>> selectDeliverGrid(Pagination page, Map<String, Object> params);
}
