package com.wf.personal.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.Article;

import java.util.List;
import java.util.Map;

public interface ArticleMapper extends BaseMapper<Article>{
	
	List<Map<String, Object>> selectArticlePage(Pagination page, Map<String, Object> params);
}
