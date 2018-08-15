/**
 * 
 */
package com.wf.personal.controller;

import com.wf.commons.shiro.ShiroUser;
import com.wf.model.vo.UserVo;
import com.wf.user.service.IUserService;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView center() {
		ModelAndView view =new ModelAndView();
		if (SecurityUtils.getSubject().isAuthenticated()) {
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			UserVo userVo = userService.selectVoById(user.getId());
			view.addObject("user", userVo);
			view.setViewName("/website/personal/center");
		}else{
			view.setViewName("/forehead/index");
		}
		return view;
	}
	//个人资料修改
	@ResponseBody
    @PostMapping("/centerEdit")
	public ModelAndView centerEdit(String logName,String name,String sex,String age,String phone) {
		ModelAndView view =new ModelAndView();
		if (SecurityUtils.getSubject().isAuthenticated()) {
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			UserVo userVo = userService.selectVoById(user.getId());
			userVo.setLoginName(logName);
			userVo.setName(name);
			userVo.setSex(Integer.parseInt(sex));
			userVo.setAge(Integer.parseInt(age));
			userVo.setPhone(phone);
			userService.updateByVo(userVo);
			
			view.addObject("user", userVo);
			view.setViewName("/website/personal/center");
		}else{
			view.setViewName("/forehead/index");
		}
		return view;
	}
}
