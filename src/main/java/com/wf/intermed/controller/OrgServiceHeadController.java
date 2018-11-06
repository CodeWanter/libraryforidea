package com.wf.intermed.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.intermed.service.IOrgServiceService;
import com.wf.model.OrgService;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/orgService")
public class OrgServiceHeadController extends BaseController {
	
	@Autowired
	private IOrgServiceService orgServiceService;
	
	
	
	/**
     * 列表页
     */
	@GetMapping("/list")
    public String list() {
        return "website/intermedOrg/servicelist";
    }
	
	/**
     * 后台添加页
     */
    @GetMapping("/create")
    public String add() {
    	return "website/intermedOrg/servicecreate";
    }
    
    /**
     * 后台编辑页
     */
    @GetMapping("/edit")
    public String edit(Model model,long id) {
    	OrgService selectById = orgServiceService.selectById(id);
    	model.addAttribute("orgService", selectById);
    	return "website/intermedOrg/serviceedit";
    }
    
    /**
     * 数据列表
     * @param orgService
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @ResponseBody
    @RequestMapping("/dataGrid")
    public Object listDate(OrgService orgService,Integer page, Integer rows, String sort, String order) {
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        long orgId = orgService.getOrgId();
        
        if(orgId!=0 ) {
        	condition.put("orgId", orgId);
        }
        
        if(StringUtils.isNotBlank(orgService.getServiceName())) {
        	condition.put("serviceName", orgService.getServiceName());
        }
        
        if(orgService.getPubflag() != null) {
        	condition.put("pubflag", String.valueOf(orgService.getPubflag()));
        }
		if (orgService.getServiceType() != null) {
			condition.put("serviceType", String.valueOf(orgService.getServiceType()));
		}

		pageInfo.setCondition(condition);
		orgServiceService.selectDataGrid(pageInfo);
		return pageInfo;
	}

	/**
	 * 数据列表
     * @param orgService
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @ResponseBody
    @RequestMapping("/myService")
    public Object listService(OrgService orgService,Integer page, Integer rows, String sort, String order) {
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        long orgId = orgService.getOrgId();
        
        if(orgId!=0 ) {
        	condition.put("orgId", orgId);
        }
        
        
        pageInfo.setCondition(condition);
        orgServiceService.selectDataGrid(pageInfo);
    	return pageInfo;
    }
    /**
     * 获取详细信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/detail")
    public Object getDetail(long id) {
    	OrgService orgService = orgServiceService.selectById(id);
    	return orgService;
    }
    
    
    @ResponseBody
    @RequestMapping("/myService/save")
    public Object save(@Valid OrgService orgService,HttpServletRequest request, HttpServletResponse response) {
    	
    	HashMap<String, String> uploadLicenseFile = uploadServiceGuideFile(request, response);
    	String code = uploadLicenseFile.get("code");
    	String msg = uploadLicenseFile.get("msg");
    	if(code.equals("0")) {//上传失败
    		return renderError(msg);
    	}else if(code.equals("1")) {
    		if(!msg.equals("")) {
    			orgService.setServiceGuide(msg);
    		}
    		
    	}
    	
    	orgService.setCreateTime(new Date());
    	orgService.setModifyTime(new Date());
    	boolean insert = orgServiceService.insert(orgService);
    	if (insert) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    
    
    /**
     * 编辑后保存
     * @return
     * @throws Exception 
     */
    @ResponseBody
    @RequestMapping("/myService/update")
    public Object update(@Valid OrgService orgService,HttpServletRequest request, HttpServletResponse response){
    	Boolean updateFlag = false;
    	OrgService before = orgServiceService.selectById(orgService.getId());
    	
    	HashMap<String, String> uploadLicenseFile = uploadServiceGuideFile(request, response);
    	String code = uploadLicenseFile.get("code");
    	String msg = uploadLicenseFile.get("msg");
    	if(code.equals("0")) {//上传失败
    		return renderError(msg);
    	}else if(code.equals("1")) {
    		if(!msg.equals("")) {
    			orgService.setServiceGuide(msg);
    		}
    	}
    	boolean equals = before.equals(orgService);
    	if(!equals) {
    		orgService.setModifyTime(new Date());
        	boolean updateById = orgServiceService.updateById(orgService);
        	
        	if (updateById) {
                return renderSuccess("修改成功！");
            } else {
                return renderError("修改失败！");
            }
    	}
    	return renderSuccess("保存成功！");
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delete")
    public Object delete(Long id) {
    	boolean deleteById = orgServiceService.deleteById(id);
    	if (deleteById) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    
    
    /**
	 * 上传机构服务指南
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
    private HashMap<String, String> uploadServiceGuideFile(HttpServletRequest request, HttpServletResponse response){
    	HashMap<String, String> resultMap = new HashMap<String, String>();
    	try {
	    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	    	
	    	ServletContext application = request.getSession().getServletContext();
	        //文件保存磁盘目录
	    	String savePath = application.getRealPath("/") + "/static/upload/intermed/";
	    	
	    	// 文件保存目录URL(相对目录)
	        String saveUrl = request.getContextPath() + "/static/upload/intermed/";
	        //定义上传文件类型
	        HashMap<String, String> extMap = new HashMap<String, String>();
	        extMap.put("file", "pdf,doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");
	        
	        // 最大文件大小
	        long maxSize = 999999999;
	        response.setContentType("text/html; charset=UTF-8");
	        if (!ServletFileUpload.isMultipartContent(request)) {
	        	resultMap.put("code", "0");
	        	resultMap.put("msg", "请选择文件");
	            return resultMap;
	        }
	        
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	        String ymd = sdf.format(new Date());
	        saveUrl += ymd + "/";
	        savePath += ymd + "/";
	        
	        File dirFile = new File(savePath);
	        if (!dirFile.exists()) {
	            dirFile.mkdirs();
	        }
	        
	        FileItemFactory factory = new DiskFileItemFactory();
	        ServletFileUpload upload = new ServletFileUpload(factory);
	        upload.setHeaderEncoding("UTF-8");
	        
	        MultipartFile file = multipartRequest.getFile("serviceGuideFile");
	        //检查文件大小
	        if (file.getSize() > maxSize) {
	        	resultMap.put("code", "0");
	        	resultMap.put("msg", "上传文件大小超过限制。");
	        	return resultMap;
	        }
	        
	        // 检查扩展名
	        String fileExt = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
	        if (!Arrays.asList(extMap.get("file").split(",")).contains(fileExt)) {
	        	resultMap.put("code", "0");
	        	resultMap.put("msg", "上传文件类型不正确。");
	        	return resultMap;
	        }
	        
	        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	        String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
	        
	        try {
	            File uploadedFile = new File(savePath, newFileName);
	            copyFile(file, uploadedFile);
	            resultMap.put("code", "1");
	        	resultMap.put("msg", saveUrl + newFileName);
	        } catch (Exception e) {
	        	resultMap.put("code", "0");
	        	resultMap.put("msg", "上传文件失败。");
	        	return resultMap;
	        }
    	} catch (Exception e) {
    		resultMap.put("code", "1");
        	resultMap.put("msg", "");
    		
    	}
		return resultMap;
    }
	
    public void copyFile(MultipartFile file,File toFile) throws IOException{
        InputStream ins = file.getInputStream();
        OutputStream out = new FileOutputStream(toFile);
        //添加缓冲流读写更快
        BufferedInputStream bis = new BufferedInputStream(ins);
        BufferedOutputStream bos = new BufferedOutputStream(out);
        byte[] b = new byte[1024];
        int n=0;
        while((n=bis.read(b))!=-1){
            bos.write(b, 0, n);
        }
//        ins.close();
//        out.close();
        bos.close();
        bis.close();
    }
    
	
}
