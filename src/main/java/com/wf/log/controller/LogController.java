package com.wf.log.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.redis.serialize.sessionUtil.UserSessionUtil;
import com.wf.commons.report.excel.ExportExcel;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.BrowerUtils;
import com.wf.commons.utils.IpUtils;
import com.wf.log.service.ILogService;
import com.wf.model.LogStatistics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by Mr_Wanter on 2018/9/3.
 * 用户行为统计控制器
 */
@Controller
@RequestMapping("/logmanage")
public class LogController extends BaseController{

    @Autowired
    private ILogService logService;

    @GetMapping("/index")
    public String log(){return "admin/log/index";}

    @CrossOrigin(origins = "*", maxAge = 3600)
    @PostMapping("/add")
    @ResponseBody
    public Object insertLog(HttpServletRequest request, HttpServletResponse response){
        long userId=0;
        if(request.getParameter("sid")!=null){
            String sessionId = request.getParameter("sid");
            UserSessionUtil userSessionUtil = new UserSessionUtil(sessionId, request, response);
            try {
                userId = userSessionUtil.getUserIdfromRedis();
            } catch (Exception e) {
                userId = 0;//未登录用户保存id为0
            }
        }else if( request.getParameter("userid")!=null){
            String userid= request.getParameter("userid");
            userId =Long.parseLong(userid);
        }
        String type = request.getParameter("t");//浏览类型
        LogStatistics logStatistics = new LogStatistics();
        logStatistics.setUserId(userId);//用户id
        logStatistics.setAccessType(type);//浏览类型
        logStatistics.setUrl(request.getParameter("u"));//浏览地址
        if (request != null) {
            logStatistics.setUserIp(IpUtils.getRemoteIp(request));//用户ip
        }
        if (request.getParameter("k") != null) {
            logStatistics.setKeyWord(request.getParameter("k"));//检索词
        }
        logStatistics.setAccessTime(new Date());//添加时间
        logStatistics.setUserBrower(BrowerUtils.getOsAndBrowserInfo(request));//操作系统及浏览器信息
        logService.insert(logStatistics);
        return renderSuccess("添加成功");
    }

    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(String startTime, String endTime, Integer page, Integer rows, @RequestParam(value = "sort", defaultValue = "access_time")String sort, @RequestParam(value = "order", defaultValue = "desc")String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<>();

        if (startTime!=null) {
            condition.put("startTime", startTime);
        }
        if(endTime != null) {
            condition.put("endTime", endTime);
        }
        pageInfo.setCondition(condition);
        logService.selectDataDrid(pageInfo);
        return pageInfo;
    }

    @GetMapping("/getChart")
    public String getChart(Model model, String startTime, String endTime){
        model.addAttribute("startTime",startTime);
        model.addAttribute("endTime",endTime);
        return "admin/log/chart";
    }

    @PostMapping("/getChartData")
    @ResponseBody
    public Object getChartData(String startTime, String endTime){
        Map<String, Object> chartTimeVo = logService.selectCharDataList(startTime,endTime);
        return chartTimeVo;
    }


    @GetMapping("/excelExport")
    public void excelExport(HttpServletRequest request, HttpServletResponse response,String startTime,String endTime){
        List<LogStatistics> logStatisticsList1 = logService.selectlogList(startTime, endTime);

        Map<String,String> titleMap = new LinkedHashMap<String,String>();
        titleMap.put("userName", "用户名");
        titleMap.put("userIp", "IP");
        titleMap.put("accessType", "浏览内容");
        titleMap.put("userBrower", "操作系统&浏览器");
        titleMap.put("url", "URL");
        titleMap.put("keyWord", "检索词");
        titleMap.put("accessTime", "浏览时间");
        String sheetName = "统计表单";

        System.out.println("start导出");
        long start = System.currentTimeMillis();
        ExportExcel.excelExport(logStatisticsList1, titleMap, sheetName,response);
        long end = System.currentTimeMillis();
        System.out.println("end导出");
        System.out.println("耗时："+(end-start)+"ms");
    }


}
