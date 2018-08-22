/**
 * 
 */
package com.wf.speciallibraries.controller;

import com.wf.commons.base.BaseController;
import com.wf.model.User;
import com.wf.model.vo.UserVo;
import com.wf.user.service.IUserService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author zhanghuaiyu
 * @version create time：2018年8月4日 上午11:31:10
 * 类说明 前台个人中心相关请求控制器
 */
@Controller
@RequestMapping("/forehead/robot")
public class RobotHeadController extends BaseController {

	@GetMapping("/index")
	public String Index(){
		return "/website/speciallibraries/index";
	}

}
