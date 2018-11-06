package com.wf.intermed.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.shiro.captcha.DreamCaptcha;
import com.wf.intermed.service.IIntermedOrgService;
import com.wf.model.IntermedOrg;
import com.wf.model.User;
import com.wf.user.service.IUserService;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;
/**
 * 中介机构  中心
 * @author Administrator
 *
 */
@Controller
public class IntermedOrgCenterController extends BaseController  {
	
	@Autowired
	private DreamCaptcha dreamCaptcha;
	
	@Autowired
	private IIntermedOrgService intermedOrgService;
	
	@Autowired
	private IUserService userService;
	
	/*
	 * 中介机构入驻页面
	 */
	@RequestMapping("/forehead/intermedOrg/add")
	public String orgRegister() {

        return "innovation/account/jgrz";
    }

    /*
     * 中介机构中心  主页
     */
    @RequestMapping("/intermedOrg/index")
    public String center(Model model) {
        Long userId = getUserId();
		if(userId!=null) {
			User user = userService.selectById(userId);
			Integer orgId = user.getOrgId();
			if(orgId!=null&&!orgId.equals("")) {
				IntermedOrg intermedOrg = intermedOrgService.selectById(orgId);
				model.addAttribute("intermedOrg", intermedOrg);
			}
			model.addAttribute("user", user);
			return "innovation/personal/orgCenter";
		}else{
			return "redirect:/forehead/index";
		}
	}
	
	/*
	 * 我的服务列表页
	 */
	@RequestMapping("/intermedOrg/service")
	public String orgService() {
		return "website/personal/orgServices";
	}
	
	
	/**
	 * 中介机构入驻页面提交保存
	 * @param intermedOrg
	 * @param captcha
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/forehead/intermedOrg/save")
	public Object saveIntermedOrg(@Valid IntermedOrg intermedOrg,String captcha,HttpServletRequest request, HttpServletResponse response) {
		
		if (!dreamCaptcha.validate(request, response, captcha)) {
            return renderError("验证码错误！");
        }
		
		HashMap<String, String> uploadLicenseFile = uploadLicenseFile(request, response);
    	String code = uploadLicenseFile.get("code");
    	String msg = uploadLicenseFile.get("msg");
    	if(code.equals("0")) {//上传失败
    		return renderError(msg);
    	}else if(code.equals("1")) {
    		if(!msg.equals("")) {
    			intermedOrg.setBusinessLicense(msg);
    		}
    	}
    	
    	intermedOrg.setCreateTime(new Date());
    	intermedOrg.setModifyTime(new Date());
    	boolean insert = intermedOrgService.insert(intermedOrg);
    	if (insert) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
		
	}
	/**
	 * 获取机构信息
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/intermedOrg/detail")
	public Object getDetail(long id) {
		IntermedOrg intermedOrg = intermedOrgService.selectById(id);
		return intermedOrg;
	}
	
	
	/***
	 * 修改信息后保存
	 * @param intermedOrg
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/intermedOrg/update")
	public Object updateIntermedOrg(@Valid IntermedOrg intermedOrg,HttpServletRequest request, HttpServletResponse response){
		Boolean updateFlag = false;
		IntermedOrg before = intermedOrgService.selectById(intermedOrg.getId());
		//上传后
		HashMap<String, String> uploadLicenseFile = uploadLicenseFile(request, response);
    	String code = uploadLicenseFile.get("code");
    	String msg = uploadLicenseFile.get("msg");
    	if(code.equals("0")) {//上传失败
    		return renderError(msg);
    	}else if(code.equals("1")) {
    		if(!msg.equals("")) {
    			intermedOrg.setBusinessLicense(msg);
    		}
    	}
    	//判断是否产生修改
		boolean equals = before.equals(intermedOrg);
		
		if(!equals) {
			intermedOrg.setModifyTime(new Date());
			boolean updateById = intermedOrgService.updateById(intermedOrg);
			if (updateById) {
	            return renderSuccess("修改成功！");
	        } else {
	            return renderError("修改失败！");
	        }
		}
		return renderSuccess("保存成功！");
	}
	
	
	
	
	
	
	/**
	 * 上传机构营业执照
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
    private HashMap<String, String> uploadLicenseFile(HttpServletRequest request, HttpServletResponse response){
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
	        
	        MultipartFile file = multipartRequest.getFile("businessLicenseFile");
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
