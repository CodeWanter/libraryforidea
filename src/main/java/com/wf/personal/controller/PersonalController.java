/**
 * 
 */
package com.wf.personal.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wf.commons.base.BaseController;
import com.wf.commons.redis.serialize.sessionUtil.UserSessionUtil;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.model.PersonalOrder;
import com.wf.model.PersonalSc;
import com.wf.model.User;
import com.wf.model.vo.UserVo;
import com.wf.personal.service.IPersonalOrderService;
import com.wf.personal.service.IPersonalScService;
import com.wf.user.service.IUserService;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.SessionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    private IPersonalOrderService personalOrderService;

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
	public Object centerEdit(Model model,User newUser) {
		if (SecurityUtils.getSubject().isAuthenticated()||SecurityUtils.getSubject().isRemembered()) {
			Long userId = getUserId();
			newUser.setId(userId);
			userService.updateById(newUser);

			model.addAttribute("user", newUser);
			return renderSuccess("修改成功");
		}else{
			return renderError("当前用户状态已失效，修改失败，请重新登录");
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
		        List<PersonalSc> list = personalScService.selectByUIdAndEId(userId,essayId);
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
	//收藏接口
	@CrossOrigin(origins = "*", maxAge = 3600)
	@ResponseBody
    @PostMapping("/insertSC")
	public  Object insertSC(HttpServletRequest request,HttpServletResponse response,PersonalSc personalSc){
		String sessionId = request.getParameter("sid");
		UserSessionUtil userSessionUtil = new UserSessionUtil(sessionId, request, response);
		try {
			long userId = userSessionUtil.getUserIdfromRedis();
			if (StringUtils.isBlank(personalSc.getTitle())) {
				return renderError("收藏名称不能为空！");
			}
			if (StringUtils.isBlank(personalSc.getUrl())) {
				return renderError("链接地址不能为空！");
			}
			if (StringUtils.isBlank(personalSc.getEssayId())) {
		        List<PersonalSc> list = personalScService.selectByUIdAndEId(userId,personalSc.getEssayId());
		        if (list != null && !list.isEmpty()) {
		            return renderError("已收藏！");
		        } else {
		        	//未收藏，存入数据库
					personalSc.setTime(new Date());
					personalSc.setUserId(userId);
					personalScService.insertByPsc(personalSc);
					return renderSuccess("收藏成功！");
		        }
			}else{
				return renderError("请上传文章Id！");
			}
		} catch (SessionException e1) {
			throw new SessionException(e1.getMessage());
		}
	}
	//删除收藏
	@ResponseBody
	@PostMapping("/scdelete")
	public Object scDel(long id){
		personalScService.deleteById(id);
		return renderSuccess("删除成功！");
	}
//	前六条数据加载
	@ResponseBody
	@PostMapping("/topSixData")
	public PageInfo topSixData(@RequestParam(value = "sort", defaultValue = "time")String sort,String order,Integer pageIndex, Integer pageSize) {
		PageInfo pageInfo = new PageInfo(pageIndex, pageSize, sort, order);
		if (SecurityUtils.getSubject().isAuthenticated()||SecurityUtils.getSubject().isRemembered()) {
			Map<String, Object> condition = new HashMap<String, Object>();
			Long userId = getUserId();
			if (userId!=null) {
				condition.put("userId", userId);
			}
			pageInfo.setCondition(condition);
			personalScService.selectSixData(pageInfo);
		}
		return pageInfo;
	}
	
	//插入我的订阅
	@CrossOrigin(origins = "*", maxAge = 3600)
	@ResponseBody
	@PostMapping("/insertOrder")
	public Object insertOrder(HttpServletRequest request, HttpServletResponse response, PersonalOrder personalOrder){
		String sessionId = request.getParameter("sid");
		UserSessionUtil userSessionUtil = new UserSessionUtil(sessionId, request, response);
		long userId = userSessionUtil.getUserIdfromRedis();
		personalOrder.setUserId(userId);
		personalOrder.setCreateTime(new Date());
		if (StringUtils.isBlank(personalOrder.getDefineName())) {
			return renderError("订阅名称不能为空！");
		}
		if (StringUtils.isBlank(personalOrder.getUrl())) {
			return renderError("链接地址不能为空！");
		}
		personalOrderService.insert(personalOrder);
		return renderSuccess("订阅成功！");
	}
	//	个人订阅前台数据获取
	@ResponseBody
	@PostMapping("/orderlistdata")
	public PageInfo orderData(@RequestParam(value = "sort", defaultValue = "create_time")String sort,String order,Integer pageIndex, Integer pageSize){
		PageInfo pageInfo = new PageInfo(pageIndex, pageSize, sort, order);
		if (SecurityUtils.getSubject().isAuthenticated()||SecurityUtils.getSubject().isRemembered()) {
		Map<String, Object> condition = new HashMap<>();
		Long userId = getUserId();
		if (userId!=null) {
			condition.put("userId", userId);
		}
		pageInfo.setCondition(condition);
		personalOrderService.selectDataGrid(pageInfo);
		}
		return pageInfo;
	}
	//删除订阅
	@ResponseBody
	@PostMapping("/orderdelete")
	public Object orderDel(long id){
		personalOrderService.deleteById(id);
		return renderSuccess("删除成功！");
	}
}
