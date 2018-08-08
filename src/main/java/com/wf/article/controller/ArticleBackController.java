package com.wf.article.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wf.article.service.IArticleService;
import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Article;

/**
 * @author zhanghuaiyu
 * 文章 后台管理控制器
 * 2018.08.02
 */
@Controller
@RequestMapping("/articleback")
public class ArticleBackController extends BaseController {

	@Autowired
	private IArticleService articleService;


	/**
	 * 注意：BaseController 中有xss过滤，会处理掉 ueditor 中的html
	 * 
	 * 所以你可以不继承它，或者注释掉BaseController中防止xss的代码
	 * 
	 * 毕竟管理平台几乎都是内网
	 * 
	 */
	@GetMapping("create")
	public String create() {
		return "admin/article/create";
	}
	
	
	/*
	 * 文章后台列表页
	 */
	@GetMapping("list")
	public String list() {
		return "admin/article/list";
	}

	/*
	 * 后台修改文章页面
	 */
	@GetMapping("editPage")
	public String editPage(Model model, long id) {
		Article article = articleService.selectById(id);
		model.addAttribute("article", article);
		return "admin/article/edit";
	}

	/**
	 * 保存文章
	 * 
	 * @param article 文章内容
	 */
	@PostMapping("save")
	@ResponseBody
	public Object save(@Valid Article article) {
		article.setCreateTime(new Date());
		article.setModifyTime(new Date());
		//article.setContent(article.getContent().replace(',', ' '));//esayui form提交添加额外参数时，后台获取数据默认包含逗号
		boolean isAdded = articleService.insert(article);
		if (isAdded) {
			return renderSuccess("添加成功！");
		} else {
			return renderError("添加失败！");
		}
	}

	/*
	 * 修改文章
	 */
	/**
	 * @param article
	 * @return
	 * @throws ParseException
	 */
	@PostMapping("edit")
	@ResponseBody
	public Object edit(@Valid Article article) throws ParseException {
		Date modifyTime= new java.sql.Date(new java.util.Date().getTime());
		article.setModifyTime(modifyTime);
		boolean isupdate = articleService.updateById(article);
		if(isupdate) {
			return renderSuccess("修改成功！");
		}else {
			return renderError("修改失败！");
		}
	}
	
	
    /**
     * 删除文章
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
	public Object delete(Long id) {
		boolean isdelete = articleService.deleteById(id);
		if(isdelete) {
			return renderSuccess("删除成功！");
		}else {
			return renderSuccess("删除失败！");
		}
	}

	/**
	 * 文章管理列表
	 *
	 * @param article
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@PostMapping("/dataGrid")
	@ResponseBody
	public Object dataGrid(Article article, Integer page, Integer rows, String sort, String order) {
		PageInfo pageInfo = new PageInfo(page, rows, sort, order);
		Map<String, Object> condition = new HashMap<String, Object>();

		if (StringUtils.isNotBlank(article.getTitle())) {
			condition.put("title", article.getTitle());
		}
		if(article.getArticleType() != null) {
			condition.put("articleType", article.getArticleType());
		}
		pageInfo.setCondition(condition);
		articleService.selectDataGrid(pageInfo);
		return pageInfo;
	}
}
