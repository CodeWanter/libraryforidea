/**
 * 
 */
package com.wf.personal.controller;

import com.wf.commons.result.PageInfo;
import com.wf.commons.shiro.ShiroUser;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Role;
import com.wf.model.vo.UserVo;
import com.wf.user.service.IUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhanghuaiyu
 * @version create time：2018年8月4日 上午11:31:10
 * 类说明 前台个人中心相关请求控制器
 */
@Controller
@RequestMapping("/forehead/personal")
public class PersonalController {
	/*
	 * 个人中心
	 */
	@Autowired
	private IUserService userService;
	@GetMapping("center")
	public String center(Model model,HttpServletRequest request) {
		ShiroUser user =  (ShiroUser)SecurityUtils.getSubject().getPrincipal();
		UserVo userVo = userService.selectVoById(user.getId());
		model.addAttribute("user", userVo);
			return "website/personal/center";
	}
}
