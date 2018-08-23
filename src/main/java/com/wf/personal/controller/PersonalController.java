/**
 * 
 */
package com.wf.personal.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.SessionException;
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
    @Autowired
    private IUserService userService;
	
	/*
	 * 个人中心
	 */
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
	@CrossOrigin(origins = "*", maxAge = 3600)
	@ResponseBody
    @PostMapping("/insertSC")
	public  Object insertSC(HttpServletRequest request,HttpServletResponse response){
		String sessionId = request.getParameter("sid");
		UserSessionUtil userSessionUtil = new UserSessionUtil(sessionId, request, response);
		try {
			long userId = userSessionUtil.getUserIdfromRedis();
			String essayId = request.getParameter("EssayId");
			if (essayId != null && essayId != "") {
				long eId = Long.parseLong(essayId);
		        List<PersonalSc> list = personalScService.selectByUIdAndEId(userId,eId);
		        if (list != null && !list.isEmpty()) {
		            return renderSuccess("已收藏！");
		        } else {
		        	//未收藏，存入数据库
					PersonalSc psc = new PersonalSc();
					String title = request.getParameter("Title");
					String author = request.getParameter("Author");
					String source = request.getParameter("Source");
					String abstractZY = request.getParameter("Abstract");
					String url = request.getParameter("Url");
					
					psc.setTime(new Date());
					psc.setUserId(userId);
					psc.setTitle(title);
					psc.setAuthor(author);
					psc.setSource(source);
					psc.setAbstractZY(abstractZY);
					psc.setUrl(url);
					personalScService.insertByPsc(psc);
					return renderSuccess("收藏成功！");
		        }
			}else{
				return renderError("请上传文章Id！");
			}
		} catch (SessionException e1) {
			throw new SessionException(e1.getMessage());
		}
	}
	//点击文献简介页，收藏/未收藏 判断
	@CrossOrigin(origins = "*", maxAge = 3600)
	@ResponseBody
    @PostMapping("/selectScOrNsc")
	public  Object selectScOrNsc(HttpServletRequest request,HttpServletResponse response){
		String sessionId = request.getParameter("sid");
		UserSessionUtil userSessionUtil = new UserSessionUtil(sessionId, request, response);
		try {
			long userId = userSessionUtil.getUserIdfromRedis();
			String essayId = request.getParameter("EssayId");
			//根据userId和EssayId去数据库查该条记录，如果查询到说明已收藏，未查到说明未收藏
			if (essayId != null && essayId != "") {
				long eId = Long.parseLong(essayId);
		        List<PersonalSc> list = personalScService.selectByUIdAndEId(userId,eId);
		        if (list != null && !list.isEmpty()) {
		            return renderSuccess("已收藏！");
		        } else {
		        	return renderError("未收藏！");
		        }
			}else{
				return renderError("请上传文章Id！");
			}
		} catch (SessionException e1) {
			throw new SessionException(e1.getMessage());
		}
	}
}
