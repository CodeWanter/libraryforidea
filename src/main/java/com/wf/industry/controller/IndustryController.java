/**
 * 
 */
package com.wf.industry.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.CommonConstant;
import com.wf.commons.utils.StringUtils;
import com.wf.industry.service.IIndustryService;
import com.wf.model.Industry;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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


	/**
	 * 注意：BaseController 中有xss过滤，会处理掉 ueditor 中的html
	 * 
	 * 所以你可以不继承它，或者注释掉BaseController中防止xss的代码
	 * 
	 * 毕竟管理平台几乎都是内网
	 * 
	 */
	
	/*
	 * 修改产业库信息
	 */
	/**
	 * @param industry
	 * @return
	 * @throws ParseException
	 */
	@PostMapping("edit")
	@ResponseBody
	public Object edit(@Valid Industry industry) throws ParseException {
		Date modifyTime= new java.sql.Date(new java.util.Date().getTime());
		industry.setModifyTime(modifyTime);
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
	 * 产业库管理列表
	 *
	 * @param industry
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@ResponseBody
	@PostMapping("/dataGrid")
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
	
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public Object create(HttpServletRequest request) throws IOException {
		//处理传递过来的图片
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = (String) fileNames.next();
			MultipartFile Pic = multipartRequest.getFile(fileName);
			
	        if(Pic.isEmpty()){  
	        	return renderError("请选择文件进行上传！"); 
	        }else{  
	            String realPath = request.getSession().getServletContext().getRealPath(CommonConstant.IMAGE_PATH);  
	            String filename = "home_adv3_2.jpg";             
	            //这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉，我是看它的源码才知道的  
	            FileUtils.copyInputStreamToFile(Pic.getInputStream(), new File(realPath, filename)); 
	        } 
		}
		return "admin/industry/create";
	}
    /**
     * 删除产业库信息
     * @param id
     * @return
     */
    @PostMapping("/delete")
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
	 */
	@PostMapping("save")
	@ResponseBody
	public Object save(@Valid Industry industry) {
		industry.setCreateTime(new Date());
		industry.setModifyTime(new Date());
		boolean isAdded = industryService.insert(industry);
		if (isAdded) {
			return renderSuccess("添加成功！");
		} else {
			return renderError("添加失败！");
		}
	}
}
