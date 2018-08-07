package com.wf.personal.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.Article;

public interface IArticleService extends IService<Article>{
	
	 void selectDataGrid(PageInfo pageInfo);
}
