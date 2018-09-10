package com.wf.industry.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.industry.service.IIndustryService;
import com.wf.industry.service.IIndustryTableService;
import com.wf.model.Industry;
import com.wf.model.IndustryData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/9/10.
 */
@Controller
@RequestMapping("/forehead/industry")
public class IndustryHeadController extends BaseController {
    @Autowired
    private IIndustryService industryService;
    @Autowired
    private IIndustryTableService itService;

    @GetMapping("list")
    public String list(Model model,String id){
        Industry industry = industryService.selectById(id);
        model.addAttribute("nav", industry);
        return "website/industry/list";
    }

    //获取产业库模块列表
    @PostMapping("listdata")
    @ResponseBody
    public PageInfo listData(String id, String tid, @RequestParam(value = "sort", defaultValue = "create_time")String sort, @RequestParam(value = "order", defaultValue = "desc")String order, Integer pageIndex, Integer pageSize) {
        PageInfo pageInfo = new PageInfo(pageIndex, pageSize, sort, order);
        Map<String, Object> condition = new HashMap<>();

        if (StringUtils.isNotBlank(id)) {
            condition.put("id", id);
        }
        if(tid != null) {
            condition.put("tid", tid);
        }
        condition.put("auditing","1");
        pageInfo.setCondition(condition);
        itService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    //前台首页点击单个产业库多模块信息展示
    @GetMapping("selectOneInfo/{id}")
    public String selectOneInfo(Model model, @PathVariable String id) {
        Industry industry = industryService.selectById(id);
        //根据id查出所有的产业库信息，排除id，传递给专题页面
        List<Industry> selectAll = industryService.selectAll();
        model.addAttribute("industrys", selectAll);//期刊 0   论文1     专利2   项目信息3   咨询4   科技成果5 ，根据id查   industry_data表里id数据
        Page<IndustryData> list = itService.selectByTableName(Integer.parseInt(id));
        model.addAttribute("list", list);
        model.addAttribute("industry", industry);
        return "website/industry/industry_zt";
    }

    //详情页
    @GetMapping("detail/{id}/{tid}")
    public Object detail(Model model,@PathVariable Long id,@PathVariable Long tid) {
        Industry industry = industryService.selectById(tid);
        //根据id查出该条信息详细信息
        IndustryData selectById = itService.selectById(id);
        Integer tableName = selectById.getTableName();
        List<Industry> selectAll = industryService.selectAll();
        model.addAttribute("list", selectById);
        model.addAttribute("nav", industry);
        return "website/industry/detail";
    }
}
