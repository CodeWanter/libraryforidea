/**
 * 
 */
package com.wf.personal.controller;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
