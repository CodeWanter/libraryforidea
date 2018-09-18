package com.wf.industry.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.commons.result.Tree;
import com.wf.model.Industry;

import java.util.List;

public interface IIndustryService extends IService<Industry>{
	 void selectDataGrid(PageInfo pageInfo);
	 List<Industry> selectAll();
	 List<Tree> selectTree();
	 List<Industry> selectTreeGrid();
}
