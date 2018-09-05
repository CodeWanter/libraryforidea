/**
 * 
 */
package com.wf.industry.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
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
import com.wf.industry.service.DBMService;
import com.wf.industry.service.IIndustryService;
import com.wf.industry.service.ResFldInfoService;
import com.wf.industry.service.ResInfoService;
import com.wf.model.Industry;
import com.wf.model.PersonalSc;
import com.wf.model.ResFldInfo;
import com.wf.model.ResInfo;

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
 * 类说明    产业库后台管理控制器
 */
@Controller
@RequestMapping("/industry")
public class IndustryController extends BaseController {

	@Autowired
	private IIndustryService industryService;
	@Autowired
	private ResInfoService resInfoService;
	@Autowired
	private ResFldInfoService resFldInfoService;
	@Autowired
	private DBMService dbmService;
	
	private static ApplicationContext context = null;
	private static JdbcTemplate jt=null;
	public IndustryController() {
		super();
		context = new ClassPathXmlApplicationContext("applicationContext.xml");
		jt = (JdbcTemplate)context.getBean("jdbcTemplate");	
	}
	
	//前台首页点击单个产业库信息
	@GetMapping("selectOneInfo")
	public String selectOneInfo(Model model,@RequestParam String title, @RequestParam String fileName, @RequestParam String id) {
		model.addAttribute("title", title);
		model.addAttribute("img", fileName);
		model.addAttribute("id", id);
		//根据id查出所有的产业库信息，排除id，传递给专题页面
    	List<Industry> selectAll = industryService.selectAll();
    	model.addAttribute("industrys", selectAll);
		return "website/industry/industry_zt";
	}
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
	//@RequestMapping(value = "/edit", method = RequestMethod.POST)
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
	/*
	 * 产品库后台自建库
	 */
	@GetMapping("resource")
	public String resource() {
		return "admin/industry/resource";
	}
	/**
	 * 创建资源库和对应表
	 * @param tableName
	 */
	@RequestMapping(value = "/createResource", method = RequestMethod.POST)
	public  Object createTable(Model model, ResInfo res,HttpServletRequest request){
		res.setResDate(new Date());
        List<ResInfo> list = resInfoService.selectByRId(res.getResId());
        if (list != null && !list.isEmpty()) {
            return renderError("数据库中已有相同表名的表!");
        } else {
        	resInfoService.insertByRes(res);
        }
		//创建物理表
        try {
			boolean allTableName = dbmService.getAllTableName(jt,res.getResTblName());
			if (allTableName == false) {
				dbmService.addTables(jt, res.getResTblName(), "");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//跳转到字段列表页面，方便添加字段
		//获取该库的所有字段
		List<ResFldInfo> lstFld=resFldInfoService.ListResFld(res.getResId());
		model.addAttribute("FldList", lstFld);
		model.addAttribute("ResId", res.getResId());
		return renderSuccess("表创建成功！");
	}	
	//跳到添加字段的页面
	@GetMapping("addFldPage")
	public String addFldPage() {
		return "admin/industry/resource";
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
	//@RequestMapping(value = "/save", method = RequestMethod.POST)
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
		boolean isAdded = industryService.insert(industry);
		if (isAdded) {
			return renderSuccess("添加成功！");
		} else {
			return renderError("添加失败！");
		}
	}
}
