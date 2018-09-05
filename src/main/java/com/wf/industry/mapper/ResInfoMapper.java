package com.wf.industry.mapper;

import org.springframework.jdbc.core.JdbcTemplate;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.wf.model.ResInfo;

public interface ResInfoMapper extends BaseMapper<ResInfo>{

	boolean getAllTableName(JdbcTemplate jt, String resTblName);
	
}
