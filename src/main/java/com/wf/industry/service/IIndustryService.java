package com.wf.industry.service;

import java.util.List;
import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.commons.result.Tree;
import com.wf.model.Industry;
import com.wf.model.IndustryData;

public interface IIndustryService extends IService<Industry>{
	 void selectDataGrid(PageInfo pageInfo);
	 List<Industry> selectAll();
	 List<Tree> selectTree();
	 List<Industry> selectTreeGrid();
}
