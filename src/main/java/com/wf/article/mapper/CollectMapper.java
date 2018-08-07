package com.wf.article.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.Article;
import com.wf.model.CollectData;

import java.util.List;
import java.util.Map;

public interface CollectMapper extends BaseMapper<CollectData>{
	
	List<Map<String, Object>> selectCollectPage(Pagination page, Map<String, Object> params);
}
