package com.wf.industry.service;

import java.util.ArrayList;
import java.util.List;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.commons.result.Tree;
import com.wf.model.IndustryData;
import com.wf.model.Organization;
import com.wf.model.vo.IndustryEachVo;
import org.springframework.stereotype.Service;

public interface IIndustryTableService extends IService<IndustryData>{

	void selectDataGrid(PageInfo pageInfo);

	IndustryEachVo selectByID(Long id);

	void updateByVo(IndustryEachVo industryData);

	void insertByVo(IndustryEachVo industryEachVo);

	void deleteEachById(Long id);

	Page<IndustryData> selectByTableName(Integer id,String type,Integer size);

	List<IndustryData> selectByIdAType(String id, String tid);
}
