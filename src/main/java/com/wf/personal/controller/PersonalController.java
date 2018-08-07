/**
 * 
 */
package com.wf.personal.controller;

import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Article;
import com.wf.personal.service.IArticleService;
import org.apache.shiro.SecurityUtils;
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
@RequestMapping("/forehead/personal")
public class PersonalController {
	/*
	 * 个人中心
	 */
	@GetMapping("center")
	public String center() {
		if (SecurityUtils.getSubject().isAuthenticated()) {
			return "website/personal/center";
		}
		return "redirect:/forehead/index";
	}
}
