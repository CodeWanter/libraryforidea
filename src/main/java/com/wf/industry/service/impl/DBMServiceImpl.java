package com.wf.industry.service.impl;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.wf.industry.service.AbstractService;
import com.wf.industry.service.DBMService;

@Service
public class DBMServiceImpl implements DBMService{
	/**
	 * 根据表名称创建一张表
	 * @param tableName
	 */
	@Override
	public void addTables(JdbcTemplate jt,String tableName,String fields){
		StringBuffer sb = new StringBuffer("");
		sb.append("CREATE TABLE `"+tableName+"` (");
		sb.append(" `id` int(11) NOT NULL AUTO_INCREMENT,");	
		sb.append(" `pubFlag` int(11) DEFAULT  NULL ,");
		sb.append(" `categoryId` varchar(64) DEFAULT  NULL ,");
		sb.append(" `createTime` datetime DEFAULT  NULL ,");
		sb.append(" `editTime` datetime DEFAULT  NULL ,");
		sb.append(" `userId` int(11) DEFAULT  NULL ,");
		sb.append(" `checkedUserId` int(11) DEFAULT  NULL ,");
		sb.append(" `updatedUserId` int(11) DEFAULT  NULL ,");
		sb.append(" `isGather` int(2) DEFAULT  1 COMMENT '是否属于采集(0:是，1:否)' ,");
		sb.append(" `deleted` int(2) DEFAULT  1 COMMENT '是否删除(0:是，1:否)' ,");
		sb.append(" PRIMARY KEY (`id`) ,");
		sb.append(" INDEX `isGather` (`isGather`) USING BTREE ");
		sb.append(") ENGINE=InnoDB DEFAULT CHARSET=utf8;");
		try {
			jt.update(sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 查询数据库是否有某表
	 * @param cnn
	 * @param tableName
	 * @return
	 * @throws SQLException 
	 * @throws Exception
	 */
	@Override
	public boolean getAllTableName(JdbcTemplate jt,String tableName) throws SQLException{
		Connection conn = jt.getDataSource().getConnection();
		ResultSet tabs = null;
		try {
			DatabaseMetaData dbMetaData = conn.getMetaData();
			String[]   types   =   { "TABLE" };
			tabs = dbMetaData.getTables(null, null, tableName, types);
			if (tabs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			tabs.close();
			conn.close();
		}
		return false;
	}
}
