package com.wf.personal.mapper;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.PersonalSc;

public interface PersonalScMapper extends BaseMapper<PersonalSc>{
	List<Map<String, Object>> selectPersonalPage(Pagination page, Map<String, Object> params);
}
