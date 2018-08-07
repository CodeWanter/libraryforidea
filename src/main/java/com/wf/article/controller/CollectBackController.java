package com.wf.article.controller;

import com.wf.article.service.IArticleService;
import com.wf.article.service.ICollectService;
import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Article;
import com.wf.model.CollectData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhanghuaiyu
 * 采集数据 后台管理控制器
 * 2018.08.02
 */
@Controller
@RequestMapping("/collectback")
public class CollectBackController extends BaseController {

	@Autowired
	private ICollectService collectService;

	@GetMapping("create")
	public String create() {
		return "admin/collect/create";
	}

	/*
	 * 文章后台列表页
	 */
	@GetMapping("list")
	public String list() {
		return "admin/collect/list";
	}

	/*
	 * 后台修改文章页面
	 */
	@GetMapping("editPage")
	public String editPage(Model model, long id) {
		CollectData collect = collectService.selectById(id);
		model.addAttribute("collect", collect);
		return "admin/collect/edit";
	}

	/**
	 * 保存文章
	 *
	 * @param collect 文章内容
	 */
	@PostMapping("save")
	@ResponseBody
	public Object save(@Valid CollectData collect) {
		collect.setCollectTime(new Date());
		boolean isAdded = collectService.insert(collect);
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
	 * @param collect
	 * @return
	 * @throws ParseException
	 */
	@PostMapping("edit")
	@ResponseBody
	public Object edit(@Valid CollectData collect) throws ParseException {
		boolean isupdate = collectService.updateById(collect);
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
		boolean isdelete = collectService.deleteById(id);
		if(isdelete) {
			return renderSuccess("删除成功！");
		}else {
			return renderSuccess("删除失败！");
		}
	}

	/**
	 * 文章管理列表
	 *
	 * @param collect
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@PostMapping("/dataGrid")
	@ResponseBody
	public Object dataGrid(CollectData collect, Integer page, Integer rows, String sort, String order) {
		PageInfo pageInfo = new PageInfo(page, rows, sort, order);
		Map<String, Object> condition = new HashMap<String, Object>();

		if (StringUtils.isNotBlank(collect.getTitle())) {
			condition.put("title", collect.getTitle());
		}
		if(collect.getIsShow() != null) {
			condition.put("isShow", collect.getIsShow());
		}
		if (StringUtils.isNotBlank(collect.getOrignForm())) {
			condition.put("orignFrom", collect.getOrignForm());
		}
		pageInfo.setCondition(condition);
		collectService.selectDataGrid(pageInfo);
		return pageInfo;
	}
}
