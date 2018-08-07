package com.wf.article.service;

import com.wf.commons.result.PageInfo;
import com.wf.model.Article;
import com.wf.model.CollectData;

public interface ICollectService extends com.baomidou.mybatisplus.service.IService<CollectData> {
	
	 void selectDataGrid(PageInfo pageInfo);
}
