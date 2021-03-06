/**
 * 
 */
package com.wf.article.controller;

import com.wf.article.service.IArticleService;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zhanghuaiyu
 * @version create time：2018年8月4日 上午11:31:10
 * 类说明 前台文章相关请求控制器
 */
@Controller
@RequestMapping("/forehead/article")
public class ArticleHeadController {

	@Autowired
	private IArticleService articleService;
	
	/*
	 * 文章前台列表页
	 */
	@GetMapping("articlelist")
	public String articleList() {
		return "website/article/articlelist";
	}

	/*
	 * H5文章前台列表页
	 */
	@GetMapping("noticelist")
	public String noticelist() {
		return "website/H5/noticelist";
	}

//	详细页面加载
	@GetMapping("detail")
	public ModelAndView detail(ModelAndView model, Long id) {
		Article article = articleService.selectById(id);
		//article.setContent(HtmlUtils.htmlUnescape(article.getContent()));
		model.addObject("article",article);
		model.setViewName("website/article/detail");
		return model;
	}

	//H5详细页面加载
	@GetMapping("noticedetail")
	public ModelAndView noticedetail(ModelAndView model, Long id) {
		Article article = articleService.selectById(id);
		//article.setContent(HtmlUtils.htmlUnescape(article.getContent()));
		model.addObject("article", article);
		model.setViewName("website/H5/noticedetail");
		return model;
	}

//	文章前台数据获取
	@PostMapping("articlelistdata")
	@ResponseBody
	public PageInfo articleListData(String title, Integer type,@RequestParam(value = "sort", defaultValue = "create_time")String sort,@RequestParam(value = "order", defaultValue = "desc")String order,Integer pageIndex, Integer pageSize) {
		PageInfo pageInfo = new PageInfo(pageIndex, pageSize, sort, order);
		Map<String, Object> condition = new HashMap<>();

		if (StringUtils.isNotBlank(title)) {
			condition.put("title", title);
		}
		if(type != null) {
			condition.put("articleType", type);
		}
		pageInfo.setCondition(condition);
		articleService.selectDataGrid(pageInfo);
		return pageInfo;
	}

	@PostMapping("topTenData")
	@ResponseBody
	public PageInfo topTenData(String title, Integer type,Integer nowpage,Integer pageSize,@RequestParam(value = "sort", defaultValue = "create_time")String sort,@RequestParam(value = "order", defaultValue = "desc")String order) {
		PageInfo pageInfo = new PageInfo(nowpage, pageSize, sort, order);
		Map<String, Object> condition = new HashMap<>();

		if (StringUtils.isNotBlank(title)) {
			condition.put("title", title);
		}
		if(type != null) {
			condition.put("articleType", type);
		}
		pageInfo.setCondition(condition);
		articleService.selectDataGrid(pageInfo);
		return pageInfo;
	}

    //region 双创通知通告相关action
    //通知公告列表页
    @GetMapping("nlist")
    public String noticeList() {
        return "innovation/notice/list";
    }

    //通知公告详情页
    @GetMapping("ndetail/{id}")
    public ModelAndView noticeDetail(ModelAndView model, @PathVariable("id") Long id) {
        Article article = articleService.selectById(id);
        model.addObject("article", article);
        model.setViewName("innovation/notice/detail");
        return model;
    }
    //endregion

}
