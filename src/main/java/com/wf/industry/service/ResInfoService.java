package com.wf.industry.service;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import com.baomidou.mybatisplus.service.IService;
import com.wf.model.ResInfo;

public interface ResInfoService extends IService<ResInfo>{
	void insertByRes(ResInfo res);
	List<ResInfo> selectByRId(int resId);
}
