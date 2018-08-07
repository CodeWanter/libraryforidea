package com.wf.article.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.article.mapper.ArticleMapper;
import com.wf.article.mapper.CollectMapper;
import com.wf.article.service.IArticleService;
import com.wf.article.service.ICollectService;
import com.wf.commons.result.PageInfo;
import com.wf.model.Article;
import com.wf.model.CollectData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CollectServiceImpl extends ServiceImpl<CollectMapper, CollectData> implements ICollectService {

	@Autowired
	private CollectMapper collectMapper;

	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		page.setOrderByField(pageInfo.getSort());
		page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = collectMapper.selectCollectPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}
}
