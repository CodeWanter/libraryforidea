package com.wf.industry.service.impl;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

public class AbstractServiceImpl extends JdbcDaoSupport {
	@Resource(name = "dataSource")
	public void setSuperDataSource(DataSource dataSource) {
		super.setDataSource(dataSource);
	}
}
