package com.wf.accesslog.controller;

import com.wf.accesslog.service.IAccessLogService;
import com.wf.commons.base.BaseController;
import com.wf.commons.report.excel.ExportExcel;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.BrowerUtils;
import com.wf.commons.utils.IpUtils;
import com.wf.model.AccessLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by Mr_Wanter on 2018/9/3.
 * 资源访问统计控制器
 */
@Controller
@RequestMapping("/accesslog")
public class AccessLogController extends BaseController {

    @Autowired
    private IAccessLogService logService;

    @GetMapping("/index")
    public String log() {
        return "admin/log/access";
    }

    @CrossOrigin(origins = "*", maxAge = 3600)
    @PostMapping("/add")
    @ResponseBody
    public Object insertLog(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("t");//浏览类型
        AccessLog accessLog = new AccessLog();
        accessLog.setResType(type);//浏览类型
        accessLog.setUrl(request.getParameter("u"));//浏览地址
        if (request != null) {
            accessLog.setUserIp(IpUtils.getRemoteIp(request));//用户ip
        }
        accessLog.setCreateTime(new Date());//添加时间
        accessLog.setUserBrower(BrowerUtils.getOsAndBrowserInfo(request));//操作系统及浏览器信息
        logService.insert(accessLog);
        return renderSuccess("添加成功");
    }

    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(String startTime, String endTime, Integer page, Integer rows, @RequestParam(value = "sort", defaultValue = "access_time") String sort, @RequestParam(value = "order", defaultValue = "desc") String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<>();

        if (startTime != null) {
            condition.put("startTime", startTime);
        }
        if (endTime != null) {
            condition.put("endTime", endTime);
        }
        pageInfo.setCondition(condition);
        logService.selectDataDrid(pageInfo);
        return pageInfo;
    }

    @GetMapping("/getChart")
    public String getChart(Model model, String startTime, String endTime) {
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        return "admin/log/accesschart";
    }

    @PostMapping("/getChartData")
    @ResponseBody
    public Object getChartData(String startTime, String endTime) {
        Map<String, Object> chartTimeVo = logService.selectCharDataList(startTime, endTime);
        return chartTimeVo;
    }


    @GetMapping("/excelExport")
    public void excelExport(HttpServletRequest request, HttpServletResponse response, String startTime, String endTime) {
        List<AccessLog> logStatisticsList1 = logService.selectlogList(startTime, endTime);

        Map<String, String> titleMap = new LinkedHashMap<String, String>();
        titleMap.put("userIp", "IP");
        titleMap.put("resType", "浏览内容");
        titleMap.put("userBrower", "操作系统&浏览器");
        titleMap.put("url", "URL");
        titleMap.put("createTime", "浏览时间");
        String sheetName = "资源浏览统计表单";

        System.out.println("start导出");
        long start = System.currentTimeMillis();
        ExportExcel.excelExport(logStatisticsList1, titleMap, sheetName, response);
        long end = System.currentTimeMillis();
        System.out.println("end导出");
        System.out.println("耗时：" + (end - start) + "ms");
    }
}
