/**
 * 
 */
package com.wf.personal.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wf.commons.base.BaseController;
import com.wf.commons.redis.serialize.sessionUtil.UserSessionUtil;
import com.wf.commons.shiro.ShiroUser;
import com.wf.model.PersonalSc;
import com.wf.model.User;
import com.wf.model.vo.UserVo;
import com.wf.personal.service.IPersonalScService;
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
public class PersonalController  extends BaseController {
    @Autowired
    private IPersonalScService personalScService;
	
	/*
	 * 个人中心
	 */
	@Autowired
	private IUserService userService;
	@GetMapping("center")
	public String center(Model model) {
		Long userId = getUserId();
		if(userId!=null) {
				UserVo userVo = userService.selectVoById(userId);
				model.addAttribute("user", userVo);
				return "/website/personal/center";
			}else{
				return "redirect:/forehead/index";
			}
	}
	//个人资料修改
	@ResponseBody
    @PostMapping("/centerEdit")
	public Object centerEdit(Model model,String logName,String name,String sex,String age,String phone) {
		if (SecurityUtils.getSubject().isAuthenticated()) {
			Long userId = getUserId();
			User newUser = new User();
			newUser.setId(userId);
			newUser.setLoginName(logName);
			newUser.setName(name);
			newUser.setSex(Integer.parseInt(sex));
			newUser.setAge(Integer.parseInt(age));
			newUser.setPhone(phone);
			userService.updateById(newUser);

			model.addAttribute("user", newUser);
			return renderSuccess("修改成功");
		}else{
			return renderError("当前用户状态已失效，修改失败，请重新登录");
		}
	}
	//收藏接口
	@ResponseBody
    @PostMapping("/insertSC")
	public String insertSC(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String sessionId = request.getParameter("sessionId");
		UserSessionUtil userSessionUtil = new UserSessionUtil(sessionId, request, response);
		Long userId = userSessionUtil.getUserIdfromRedis();
		
		if (SecurityUtils.getSubject().isAuthenticated()) {
			PersonalSc psc = new PersonalSc();
			//Long userId = getUserId();
			String title = request.getParameter("Title");
			String author = request.getParameter("Author");
			String time = request.getParameter("Time");
			String source = request.getParameter("Source");
			String abstractZY = request.getParameter("Abstract");
			String url = request.getParameter("Url");
			try {
				SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");  
				String format2 = format.format(time);
				Date parse = format.parse(format2);
				psc.setTime(parse);
			} catch (ParseException e) {
				System.out.println("时间戳转date格式失败！");
			}
			psc.setUserId(userId);
			psc.setTitle(title);
			psc.setAuthor(author);
			psc.setSource(source);
			psc.setAbstractZY(abstractZY);
			psc.setUrl(url);
			personalScService.insertByPsc(psc);
			return "收藏成功！";
		}else{
			return "当前用户状态已失效，请重新登录后进行收藏！";
		}
	}
}
