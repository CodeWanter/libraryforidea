/**
 * 
 */
package com.wf.industry.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.CommonConstant;
import com.wf.industry.service.DBMService;
import com.wf.industry.service.IIndustryService;
import com.wf.industry.service.ResInfoService;
import com.wf.industry.service.industryTableService;
import com.wf.model.Industry;
import com.wf.model.IndustryData;
import com.wf.model.ResInfo;
import com.wf.model.vo.IndustryEachVo;
import com.wf.model.vo.ResVo;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author huangjunqing
 * @version create time：2018年8月28日 上午11:31:10
 * 类说明    产业库后台各库信息
 */
@Controller
@RequestMapping("/industryEach")
public class IndustryEachController extends BaseController {
	@Autowired
	private ResInfoService resInfoService;
	@Autowired
	private DBMService dbmService;
	@Autowired
	private IIndustryService industryService;
	@Autowired
	private industryTableService itService;
	
	private static ApplicationContext context = null;
	private static JdbcTemplate jt=null;
	public IndustryEachController() {
		super();
		context = new ClassPathXmlApplicationContext("applicationContext.xml");
		jt = (JdbcTemplate)context.getBean("jdbcTemplate");	
	}
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
        return resInfoService.selectTree();
    }
    /**
     * 产业库信息列表页展示
     */
    @PostMapping("/dataEachGrid")
    @ResponseBody
    public Object dataEachGrid(ResVo resVo, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        if (resVo.getName() != null) {
        	condition.put("title", resVo.getName());
        }
        if (resVo.getTableName() != null) {
            condition.put("tableName", resVo.getTableName());
        }
        if (resVo.getCreatedateStart1() != null) {
            condition.put("startTime", resVo.getCreatedateStart1());
        }
        if (resVo.getCreatedateEnd1() != null) {
            condition.put("endTime", resVo.getCreatedateEnd1());
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
    //详情页
    @GetMapping("detail")
    public Object detail(Model model,Long id) {
    	//根据id查出该条信息详细信息
    	IndustryData selectById = itService.selectById(id);
    	Integer tableName = selectById.getTableName();
    	String resTblName = resInfoService.selectById(tableName).getResTblName();
      	List<Industry> selectAll = industryService.selectAll();
      	for (int i = 0; i < selectAll.size(); i++) {
			if(selectAll.get(i).getTableName().equals(resTblName)){
				model.addAttribute("industry", selectAll.get(i));
			}
		}
    	model.addAttribute("resTblName", resTblName);
        model.addAttribute("list", selectById);
        return "website/industry/detail";
    }
}
