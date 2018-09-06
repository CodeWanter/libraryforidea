package com.wf.industry.service.impl;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCountCallbackHandler;
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
		sb.append(" `title` varchar(256) DEFAULT  NULL ,");
		sb.append(" `type` varchar(256) DEFAULT  NULL ,");
		sb.append(" `content` text DEFAULT  NULL ,");
		sb.append(" `createTime` datetime DEFAULT  NULL ,");
		sb.append(" `editTime` datetime DEFAULT  NULL ,");
		sb.append(" PRIMARY KEY (`id`) ");
		sb.append(") ENGINE=InnoDB DEFAULT CHARSET=utf8;");
		try {
			jt.update(sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@Override
	public void deleteTables(JdbcTemplate jt, String tableName, String string) {
		StringBuffer sb = new StringBuffer("");
		sb.append("DROP TABLE `"+tableName+"`");
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
	@Override
	public List selectDataGrid(JdbcTemplate jt, String resTblName, String string) {
		StringBuffer sb = new StringBuffer("");
		sb.append("SELECT * FROM`"+resTblName+"`");
		try {
			List query = jt.query(sb.toString(), new BeanPropertyRowMapper(resTblName.getClass()));
			return query;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
