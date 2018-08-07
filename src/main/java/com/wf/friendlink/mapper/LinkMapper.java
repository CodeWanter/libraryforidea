package com.wf.friendlink.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.Link;

import java.util.List;
import java.util.Map;

public interface LinkMapper extends BaseMapper<Link>{
    List<Map<String, Object>> selectLinkPage(Pagination page, Map<String, Object> params);
}
