/**
 * 
 */
package com.wf.industry.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.CommonConstant;
import com.wf.commons.utils.StringUtils;
import com.wf.industry.service.IIndustryService;
import com.wf.industry.service.IIndustryTableService;
import com.wf.model.Industry;
import com.wf.model.IndustryData;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author huangjunqing
 * @version create time：2018年8月28日 上午11:31:10
 * 类说明    产业库后台管理控制器
 */
@Controller
@RequestMapping("/industry")
public class IndustryController extends BaseController {

	@Autowired
	private IIndustryService industryService;
	@Autowired
	private IIndustryTableService itService;
	/*
	 * 修改产业库信息
	 */
	/**
	 * @param industry
	 * @return
	 * @throws ParseException
	 * @throws IOException 
	 */
	@PostMapping("edit")
	@ResponseBody
	public Object edit(@Valid Industry industry,@RequestParam MultipartFile[] pic,HttpServletRequest request) throws ParseException, IOException {
		Date modifyTime= new java.sql.Date(new java.util.Date().getTime());
		Date date = new Date();
		industry.setModifyTime(modifyTime);
		//删除旧图，上传新图
		for(MultipartFile Pic : pic){
            if(Pic.isEmpty()){
            	return renderError("请选择文件进行上传！");
            }else{
            	String realPath = request.getSession().getServletContext().getRealPath(CommonConstant.IMAGE_PATH);
            	if (industry.getFileName() != null) {
    	            File oldFile = new File(realPath,industry.getFileName());
    	            if (oldFile.exists()) {
    	            	oldFile.delete();
    	            	System.out.println("文件已删除!");
    				}else{
    					System.out.println("要删除的文件不存在!");
    				}
				} else {
					System.out.println("要删除的文件不存在!");
				}
	            String fileName = String.valueOf(date.getTime())+".jpg";
	            FileUtils.copyInputStreamToFile(Pic.getInputStream(), new File(realPath, fileName));
	            industry.setFileName(fileName);
            }  
        }
		boolean isupdate = industryService.updateById(industry);
		if(isupdate) {
			return renderSuccess("修改成功！");
		}else {
			return renderError("修改失败！");
		}
	}
	/*
	 * 产品库后台列表页
	 */
	@GetMapping("list")
	public String list() {
		return "admin/industry/list";
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
	 * 产业库管理列表
	 * @param industry
	 */
	@PostMapping("dataGrid")
	@ResponseBody
	public Object dataGrid(Industry industry, Integer page, Integer rows, String sort, String order) {
		PageInfo pageInfo = new PageInfo(page, rows, sort, order);
		Map<String, Object> condition = new HashMap<String, Object>();

		if (StringUtils.isNotBlank(industry.getTitle())) {
			condition.put("title", industry.getTitle());
		}
		pageInfo.setCondition(condition);
		industryService.selectDataGrid(pageInfo);
		return pageInfo;
	}
	@GetMapping("create")
	public String create(){
		return "admin/industry/create";
	}

    /**
     * 删除产业库信息
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
	public Object delete(Long id) {
		boolean isdelete = industryService.deleteById(id);
		if(isdelete) {
			return renderSuccess("删除成功！");
		}else {
			return renderSuccess("删除失败！");
		}
	}
	/*
	 * 后台修改产业库页面
	 */
	@GetMapping("editPage")
	public String editPage(Model model, long id) {
		Industry industry = industryService.selectById(id);
		model.addAttribute("industry", industry);
		return "admin/industry/edit";
	}
	/**
	 * 保存产业库信息
	 * 
	 * @param industry 
	 * @throws IOException 
	 */
    @PostMapping("save")
    @ResponseBody
	public Object save(@Valid Industry industry,@RequestParam MultipartFile[] pic,HttpServletRequest request) throws IOException {
    		Date date = new Date();
    		industry.setCreateTime(date);
    		industry.setModifyTime(date);
    		for(MultipartFile Pic : pic){
                if(Pic.isEmpty()){  
                	return renderError("请选择文件进行上传！"); 
                }else{  
    	            String realPath = request.getSession().getServletContext().getRealPath(CommonConstant.IMAGE_PATH);  
    	            String fileName = String.valueOf(date.getTime())+".jpg";
    	            FileUtils.copyInputStreamToFile(Pic.getInputStream(), new File(realPath, fileName));
    	            industry.setFileName(fileName);
                }  
            }
        	//industry
            boolean isAdded = industryService.insert(industry);
    		if (isAdded) {
    			return renderSuccess("添加成功！");
    		} else {
    			return renderError("添加失败！");
    		}
        }
}
