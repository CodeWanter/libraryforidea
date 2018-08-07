package com.wf.commons.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
/**
* <p>Title: AccessUtils</p>  
* <p>Description: aceess操作类</p>  
* @author zjh  
* @date 2018年7月24日
 */
public class AccessUtils {
	
	public static Connection getConn(String dbUrl){
		Connection connection = null;
		try {
			Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
			connection=DriverManager.getConnection("jdbc:ucanaccess://"+dbUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

	public static ResultSet getExecute(String dbUrl,String sql,String[] params){
		Connection cn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try{ 
			cn = getConn(dbUrl);
			//预编译
			ps = cn.prepareStatement(sql);
			//设置参数
			if(params != null && params.length > 0){
				for(int i=0;i<params.length;i++){
					ps.setString(i+1, params[i]);
				}
			}
			//执行
			rs = ps.executeQuery();
			
			ResultSetMetaData metaDate = rs.getMetaData();//结果集结构信息    
		    int columnCount = metaDate.getColumnCount();//列数
		    String[] columns = new String[columnCount];
		    List<Map<String,String>> rowList = new ArrayList<Map<String,String>>();
		    while(rs.next()){
		    	try{
			    	Map<String,String> rowData = new HashMap<String,String>();
					for (int i = 1; i <= columnCount; i++) {
						rowData.put(metaDate.getColumnName(i), String.valueOf(rs.getObject(i)));
					}
					//获取目录信息
					String bookId = (String) rowData.get("book_id");
					String catalog = getCatalog(bookId, dbUrl, cn);
					rowData.put("catalog", catalog);
					rowList.add(rowData);
		    	}catch(Exception e){
		    		e.printStackTrace();
		    	}
		    }    
		} catch(Exception e){
			 e.printStackTrace();
		} finally{
			try {
				if(rs != null){
					rs.close();
				}
				if(ps != null){
					ps.close();
				}
				if(cn != null){
					cn.close();
				} 
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
		}
		return rs;
	}
	
	public static String getCatalog(String bookId,String dbUrl,Connection cn) throws Exception{
		ResultSet rs = null;
		PreparedStatement ps = null;
		Document doc = DocumentHelper.createDocument();  
        Element root = DocumentHelper.createElement("catalogList");  
        doc.add(root);
		try{ 
			cn = getConn(dbUrl);
			//预编译
			String sql = "select * from catalog where book_id = ?";
			ps = cn.prepareStatement(sql);
			//设置参数
			ps.setString(1, bookId);
			//执行
			rs = ps.executeQuery();
			
			ResultSetMetaData metaDate = rs.getMetaData();//结果集结构信息    
		    int columnCount = metaDate.getColumnCount();//列数
		    while(rs.next()){
		    	Element childRoot = DocumentHelper.createElement("catalog");
				for (int i = 1; i <= columnCount; i++) {
			        childRoot.addElement(metaDate.getColumnName(i)).setText(String.valueOf(rs.getObject(i)));
				}
				root.add(childRoot);
		    }
		} catch(Exception e){
			 e.printStackTrace();
		} finally{
			try {
				if(rs != null){
					rs.close();
				}
				if(ps != null){
					ps.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
		}
		String catalog = "";
		if(StringUtils.isNotBlank(XMLUtils.formatXml(doc))){
			catalog = XMLUtils.formatXml(doc).replace("\'", "\"");
		}
		return catalog;
	}
	
	public static void close(Connection cn, ResultSet rs, PreparedStatement ps){
		try {
			if(rs != null){
				rs.close();
			}
			if(ps != null){
				ps.close();
			}
			if(cn != null){
				cn.close();
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	public static void main(String args[]) {
		String dbUrl = "F:/gtfile/1531983971071/91111_hascopyright.mdb";
		String sql = "select * from book";
		getExecute(dbUrl, sql, null);
	} 
}
