package com.wf.industry.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.Industry;

public interface IIndustryService extends IService<Industry>{
	
	 void selectDataGrid(PageInfo pageInfo);
}