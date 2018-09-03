package com.wf.industry.service;

import java.sql.SQLException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
@Service
public interface DBMService {
	//创建一个物理表
	void addTables(JdbcTemplate jt, String tName,String fields);
	//查询数据库是否有某表
	boolean getAllTableName(JdbcTemplate jt, String resTblName) throws SQLException;
}
