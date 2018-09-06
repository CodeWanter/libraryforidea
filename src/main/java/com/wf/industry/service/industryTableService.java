package com.wf.industry.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.IndustryData;
import com.wf.model.vo.IndustryEachVo;

public interface industryTableService extends IService<IndustryData>{

	void selectDataGrid(PageInfo pageInfo);

	IndustryEachVo selectByID(Long id);

	void updateByVo(IndustryEachVo industryData);

	void insertByVo(IndustryEachVo industryEachVo);

	void deleteEachById(Long id);

	List<IndustryData> selectByTableName(int resId);

}
