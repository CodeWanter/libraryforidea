package com.wf.personal.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.PersonalOrder;

import java.util.List;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/8/28.
 */
public interface PersonalOrderMapper extends BaseMapper<PersonalOrder> {
    List<Map<String, Object>> selectOrderPage(Pagination page, Map<String, Object> params);
}
