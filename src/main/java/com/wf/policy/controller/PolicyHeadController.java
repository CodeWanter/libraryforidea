/**
 *
 */
package com.wf.policy.controller;

import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Policy;
import com.wf.policy.service.IPolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zhanghuaiyu
 * @version create time：2018年8月4日 上午11:31:10
 *          类说明 前台文章相关请求控制器
 */
@Controller
@RequestMapping("/forehead/policy")
public class PolicyHeadController {

    @Autowired
    private IPolicyService policyService;

    /*
     * 文章前台列表页
     */
    @GetMapping("policylist")
    public String policyList() {
        return "website/policy/policylist";
    }

    //	详细页面加载
    @GetMapping("detail")
    public ModelAndView detail(ModelAndView model, Long id) {
        Policy policy = policyService.selectById(id);
        model.addObject("policy", policy);
        model.setViewName("website/policy/detail");
        return model;
    }

    //	文章前台数据获取
    @PostMapping("policylistdata")
    @ResponseBody
    public PageInfo policyListData(String title, @RequestParam(value = "sort", defaultValue = "create_time") String sort, @RequestParam(value = "order", defaultValue = "desc") String order, Integer pageIndex, Integer pageSize) {
        PageInfo pageInfo = new PageInfo(pageIndex, pageSize, sort, order);
        Map<String, Object> condition = new HashMap<>();

        if (StringUtils.isNotBlank(title)) {
            condition.put("title", title);
        }
        condition.put("isShow", 1);//只查询可以显示的数据
        pageInfo.setCondition(condition);
        policyService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    @PostMapping("topTenData")
    @ResponseBody
    public PageInfo topTenData(String title, Integer nowpage, Integer pageSize, @RequestParam(value = "sort", defaultValue = "create_time") String sort, @RequestParam(value = "order", defaultValue = "desc") String order) {
        PageInfo pageInfo = new PageInfo(nowpage, pageSize, sort, order);
        Map<String, Object> condition = new HashMap<>();

        if (StringUtils.isNotBlank(title)) {
            condition.put("title", title);
        }
        condition.put("isShow", 1);//只查询可以显示的数据
        pageInfo.setCondition(condition);
        policyService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    //region 双创平台政策法规展示
    @GetMapping("plist")
    public String pList() {
        return "innovation/policy/list";
    }

    @GetMapping("pdetail/{id}")
    public ModelAndView pDetial(ModelAndView model, @PathVariable("id") Long id) {
        Policy policy = policyService.selectById(id);
        model.addObject("policy", policy);
        model.setViewName("innovation/policy/detail");
        return model;
    }

    //endregion

}
