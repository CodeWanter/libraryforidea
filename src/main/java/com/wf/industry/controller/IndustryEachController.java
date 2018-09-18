/**
 * 
 */
package com.wf.industry.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.industry.service.IIndustryService;
import com.wf.industry.service.IIndustryTableService;
import com.wf.model.IndustryData;
import com.wf.model.vo.IndustryEachVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author huangjunqing
 * @version create time：2018年8月28日 上午11:31:10
 * 类说明    产业库后台各库信息
 */
@Controller
@RequestMapping("/industryEach")
public class IndustryEachController extends BaseController {
	@Autowired
	private IIndustryService industryService;
	@Autowired
	private IIndustryTableService itService;

	/*
	 * 产品库后台数据页
	 */
	@GetMapping("eachList")
	public String eachList() {
		return "admin/industry/eachList";
	}
    /**
     * 产业库资源树
     */
    @PostMapping(value = "/tree")
    @ResponseBody
    public Object tree() {
        return industryService.selectTree();
    }
    /**
     * 产业库信息列表页展示
     */
    @PostMapping("/dataEachGrid")
    @ResponseBody
    public Object dataEachGrid(IndustryData industryData, String createdateStart1,String createdateEnd1,Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (industryData.getTitle() != null) {
            condition.put("title", industryData.getTitle());
        }
        if (industryData.getTableName() != null) {
            condition.put("tableName", industryData.getTableName());
        }
        if (StringUtils.isNotBlank(createdateStart1)) {
            condition.put("startTime", createdateStart1);
        }
        if (StringUtils.isNotBlank(createdateEnd1)) {
            condition.put("endTime", createdateEnd1);
        }
        pageInfo.setCondition(condition);
        itService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    /**
     * 添加产业库单条信息页
     */
    @GetMapping("/addEachPage")
    public String addEachPage() {
        return "admin/industry/eachAdd";
    }
    /**
     * 编辑产业库单条信息页
     */
    @GetMapping("/editEachPage")
    public String editPage(Model model, Long id) {
    	IndustryData industryEach = itService.selectById(id);
        model.addAttribute("industryEach", industryEach);
        return "admin/industry/eachEdit";
    }
	/**
	 * 保存产业库单条信息
	 */
    @PostMapping("save")
    @ResponseBody
	public Object save(@Valid IndustryEachVo industryEachVo) throws IOException {
		Date date = new Date();
		industryEachVo.setCreateTime(date);
		industryEachVo.setEditTime(date);
		//industry_data
        itService.insertByVo(industryEachVo);
		return renderSuccess("添加成功！");
	}
    /**
     * 编辑产业库单条信息
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid IndustryData industryData) {
		Date date = new Date();
		Date modifyTime= new java.sql.Date(new java.util.Date().getTime());
		industryData.setEditTime(modifyTime);
		boolean r = itService.updateById(industryData);
        return renderSuccess("修改成功！");
    }
    //删除产业库单条信息
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        itService.deleteEachById(id);
        return renderSuccess("删除成功！");
    }

}
