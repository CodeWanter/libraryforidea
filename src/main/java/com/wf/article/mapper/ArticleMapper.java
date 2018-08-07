package com.wf.article.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.Article;

public interface ArticleMapper extends BaseMapper<Article>{
	
	List<Map<String, Object>> selectArticlePage(Pagination page, Map<String, Object> params);
}
