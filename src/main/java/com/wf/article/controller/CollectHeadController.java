/**
 * 
 */
package com.wf.article.controller;

import com.wf.article.service.ICollectService;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zhanghuaiyu
 * @version create time：2018年8月4日 上午11:31:10
 * 类说明 前台文章相关请求控制器
 */
@Controller
@RequestMapping("/forehead/collect")
public class CollectHeadController {

	@Autowired
	private ICollectService collectService;
	
	/*
	 * 采集前台列表页
	 */
	@GetMapping("collectlist")
	public String collectlist() {
		return "website/collect/collectlist";
	}

    /*
 * H5每日推荐列表页
 */
    @GetMapping("dailylist")
    public String dailylist() {
        return "website/H5/dailylist";
    }

    /*
	 * 文章前台列表页
	 */
	@GetMapping("articlelist")
	public String articleList() {
		return "website/article/articlelist";
	}
//	采集前台列表数据获取
	@PostMapping("collectlistdata")
	@ResponseBody
	public PageInfo collectListData(String title,@RequestParam(value = "sort", defaultValue = "collect_time")String sort,@RequestParam(value = "order", defaultValue = "desc")String order,Integer pageIndex, Integer pageSize) {
		PageInfo pageInfo = new PageInfo(pageIndex, pageSize, sort, order);
		Map<String, Object> condition = new HashMap<>();

		if (StringUtils.isNotBlank(title)) {
			condition.put("title", title);
		}
		condition.put("isShow", 0);
		pageInfo.setCondition(condition);
		collectService.selectDataGrid(pageInfo);
		return pageInfo;
	}

//	前十条数据加载
	@PostMapping("topTenData")
	@ResponseBody
	public PageInfo topTenData(String title,Integer nowpage,Integer pageSize, @RequestParam(value = "sort", defaultValue = "collect_time")String sort,@RequestParam(value = "order", defaultValue = "desc")String order) {
		PageInfo pageInfo = new PageInfo(nowpage, pageSize, sort, order);
		Map<String, Object> condition = new HashMap<>();

		if (StringUtils.isNotBlank(title)) {
			condition.put("title", title);
		}
		condition.put("isShow", 0);
		pageInfo.setCondition(condition);
		collectService.selectDataGrid(pageInfo);
		return pageInfo;
	}
}
