package com.wf.industry.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.jdbc.core.JdbcTemplate;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.wf.model.ResInfo;

public interface ResInfoMapper extends BaseMapper<ResInfo>{

	boolean getAllTableName(JdbcTemplate jt, String resTblName);

	ResInfo selectByTName(@Param("resTblName") String resTblName);
	
	ResInfo selectById(@Param("resId") String parseInt);
	
}
