/**
 * 
 */
package com.wf.personal.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.redis.serialize.sessionUtil.UserSessionUtil;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.deliver.service.IDeliverService;
import com.wf.model.Deliver;
import com.wf.model.PersonalOrder;
import com.wf.model.PersonalSc;
import com.wf.model.User;
import com.wf.model.vo.UserVo;
import com.wf.personal.service.IPersonalOrderService;
import com.wf.personal.service.IPersonalScService;
import com.wf.user.service.IUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.SessionException;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Date;
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
public class PersonalController  extends BaseController {
    @Autowired
    private IPersonalScService personalScService;
    @Autowired
    private IPersonalOrderService personalOrderService;
	@Autowired
	private IDeliverService deliverService;


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
		if (StringUtils.isBlank(newUser.getEmail())) {
			return renderError("Email不能为空！");
		}
		if (newUser.getIndustry().equals("/")) {
			return renderError("行业不能为空！");
		}
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

	//region 我的收藏
	//点击文献简介页，收藏/未收藏 判断
	@CrossOrigin(origins = "*", maxAge = 3600)
	@ResponseBody
	@PostMapping("/selectScOrNsc")
	public  Object selectScOrNsc(HttpServletRequest request, HttpServletResponse response){
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
			if (!StringUtils.isBlank(personalSc.getEssayId())) {
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

	//endregion
	//region 个人订阅
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
	//endregion
	//region 原文传递信息

	/**
	 * 保存原文传递信息
	 *
	 * @param deliver
	 */
	@CrossOrigin(origins = "*", maxAge = 3600)
	@PostMapping("insertdeliver")
	@ResponseBody
	public Object save(HttpServletRequest request, HttpServletResponse response, @Valid Deliver deliver) {
		String sessionId = request.getParameter("sid");
		UserSessionUtil userSessionUtil = new UserSessionUtil(sessionId, request, response);
		long userId = userSessionUtil.getUserIdfromRedis();
		deliver.setUserId(userId);
		deliver.setCreateTime(new Date());
		//// TODO: 2018/9/26 接入原文传递接口
		boolean isAdded = deliverService.insert(deliver);
		if (isAdded) {
			return renderSuccess("申请成功！");
		} else {
			return renderError("申请失败！");
		}
	}

	//	原文传递前台数据获取
	@PostMapping("deliverlistdata")
	@ResponseBody
	public PageInfo deliverListData(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "sort", defaultValue = "create_time") String sort, @RequestParam(value = "order", defaultValue = "desc") String order, Integer pageIndex, Integer pageSize) {
		PageInfo pageInfo = new PageInfo(pageIndex, pageSize, sort, order);
		Map<String, Object> condition = new HashMap<>();
		Long userId = getUserId();
		condition.put("userId", userId);
		pageInfo.setCondition(condition);
		deliverService.selectByID(pageInfo);
		return pageInfo;
	}

	// 原文传递详细页面加载
	@GetMapping("deliverdetail")
	public ModelAndView deliverdetail(ModelAndView model, Long id) {
		Deliver deliver = deliverService.selectById(id);
		model.addObject("deliver", deliver);
		model.setViewName("website/deliver/detail");
		return model;
	}

    //最新资源
    @PostMapping("getNewResourse")
    @ResponseBody
    public Object getNewResourse() throws Exception {
        String urlLogin = "http://my.cnki.net/RCDService/api/MyPapers/similar?clientID=8180918092302531226&userIP=210.22.176.35&userID=-1&top=30";
        Connection connect = Jsoup.connect(urlLogin);
        // 伪造请求头
        connect.header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
        connect.header("Accept-Encoding", "gzip, deflate");
        connect.header("Accept-Language", "zh-CN,zh;q=0.9");
        connect.header("Connection", "keep-alive");
        connect.header("Cookie", "SID=020101; Ecp_ClientId=3181018112001153935; UM_distinctid=166853066dd38-06751dcb5f70e7-335c4f7f-1fa400-166853066de393; Ecp_IpLoginFail=181018106.37.240.36; cnkiUserKey=1343bf8c-ee9d-3139-5ba1-4468e3c93121");
        connect.header("Host", "my.cnki.net");
        connect.header("Upgrade-Insecure-Requests", "1");
        connect.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6756.400 QQBrowser/10.2.2457.400");
        connect.followRedirects(true);

        Connection.Response res = connect.ignoreContentType(true).method(Connection.Method.GET).execute();// 执行请求

        String body = res.body();// 获取响应体
        return body;
    }
    //endregion
}
