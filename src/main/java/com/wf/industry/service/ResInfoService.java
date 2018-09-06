package com.wf.industry.service;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.Tree;
import com.wf.model.ResInfo;

public interface ResInfoService extends IService<ResInfo>{
	void insertByRes(ResInfo res);
	void deleteByTName(String tableName);
	ResInfo selectByRTblName(String resTblName);
	ResInfo selectById(int parseInt);
	List<Tree> selectTree();
	List<ResInfo> selectTreeGrid();
}
