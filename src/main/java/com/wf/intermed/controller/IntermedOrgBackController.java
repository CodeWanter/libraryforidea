package com.wf.intermed.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.shiro.PasswordHash;
import com.wf.commons.utils.StringUtils;
import com.wf.intermed.service.IIntermedOrgService;
import com.wf.model.IntermedOrg;
import com.wf.model.User;
import com.wf.model.vo.UserVo;
import com.wf.user.service.IUserService;
/**
 * 后台中介机构管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/intermedOrg/back")
public class IntermedOrgBackController extends BaseController  {
	
	@Autowired
	private IIntermedOrgService intermedOrgService;
	@Autowired
	private IUserService userService;
	
	@Autowired
    private PasswordHash passwordHash;
	
	/**
     * 后台列表页
     */
	@GetMapping("/list")
    public String list() {
        return "admin/intermedOrg/list";
    }
	
	/**
     * 后台添加页
     */
    @GetMapping("/create")
    public String add() {
    	return "admin/intermedOrg/create";
    }
    
    /**
     * 后台编辑页
     */
    @GetMapping("/edit")
    public String edit(Model model,long id) {
    	IntermedOrg intermedOrg = intermedOrgService.selectById(id);
    	model.addAttribute("intermedOrg", intermedOrg);
    	return "admin/intermedOrg/edit";
    }
    /**
     * 列表数据
     * @param intermedOrg
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @ResponseBody
    @RequestMapping("/dataGrid")
    public Object listDate(IntermedOrg intermedOrg,Integer page, Integer rows, String sort, String order) {
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();
        
        if(StringUtils.isNotBlank(intermedOrg.getOrgName())) {
        	condition.put("orgName", intermedOrg.getOrgName());
        }
        
        if(intermedOrg.getPubflag() != null) {
        	condition.put("pubflag", String.valueOf(intermedOrg.getPubflag()));
        }
        pageInfo.setCondition(condition);
        intermedOrgService.selectDataGrid(pageInfo);
    	return pageInfo;
    }
    
    /**
     * 添加
     * @param intermedOrg
     * @return
     * @throws Exception 
     */
    @ResponseBody
    @RequestMapping("/save")
    public Object save(@Valid IntermedOrg intermedOrg,HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
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
     * 编辑后保存
     * @return
     * @throws Exception 
     */
    @ResponseBody
    @RequestMapping("/update")
    public Object update(@Valid IntermedOrg intermedOrg,HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
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
    	
    	intermedOrg.setModifyTime(new Date());
    	boolean updateById = intermedOrgService.updateById(intermedOrg);
    	
    	if (updateById) {
            return renderSuccess("修改成功！");
        } else {
            return renderError("修改失败！");
        }
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/delete")
    public Object delete(Long id) {
    	boolean deleteById = intermedOrgService.deleteById(id);
    	if (deleteById) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    
    /**
     * 树形机构数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/tree")
    public Object tree() {
    	return intermedOrgService.selectTree();
    }
    
    /**
     * 为审核通过的机构查询或生成用户名及密码
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addOrSelectUser")
    public Object addOrSelectUser(@Valid Integer orgId) {
    	Map<String, Object> result = new HashMap<String, Object>();
    	Map<String, Object> condition = new HashMap<String, Object>();
    	condition.put("orgId", orgId);
    	IntermedOrg intermedOrg = intermedOrgService.selectById(orgId);
    	List<Map<String, Object>> selectUserByOrgId = userService.selectUserByOrgId(condition);
    	if(selectUserByOrgId==null||selectUserByOrgId.isEmpty()) {
    		User cool = new User();
    		String creatUserName = creatUserName();
    		String pwdStr = creatUserName+"institution";
    		cool.setOrgId(orgId);
    		cool.setLoginName(creatUserName);
    		cool.setCreateTime(new Date());
    		cool.setName(intermedOrg.getOrgName());
    		String salt = StringUtils.getUUId();
            String pwd = passwordHash.toHex(pwdStr, salt);
            cool.setPassword(pwd);
    		cool.setSalt(salt);
    		cool.setStatus(0);
    		cool.setUserType(1);
    		boolean insert = userService.insert(cool);
    		if(insert) {
    			result.put("success", true);
    			result.put("msg", "创建成功！");
    			result.put("userName", creatUserName);
    			result.put("pwd", pwdStr);
    		}else {
    			result.put("success", false);
    			result.put("msg", "创建失败！");
    		}
    	}else {
    		Map<String,Object> hs= selectUserByOrgId.get(0);
    		String loginName = (String) hs.get("loginName");
    		result.put("success", true);
			result.put("msg", "查询成功！");
			result.put("userName", loginName);
    	}
    	return result;
    }
    
    public String creatUserName() {
    	String randomName = getStringRandom(10);
    	UserVo user = new UserVo();
    	user.setLoginName(randomName);
    	List<User> selectByLoginName = userService.selectByLoginName(user);
    	if(selectByLoginName!=null&&selectByLoginName.size()>0) {
    		randomName = creatUserName();
    	}
    	return randomName;
    }
    
    public String getStringRandom(int length) {  
           
         String val = "";  
         Random random = new Random();  
           
         //参数length，表示生成几位随机数  
         for(int i = 0; i < length; i++) {  
               
             String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";  
             //输出字母还是数字  
             if( "char".equalsIgnoreCase(charOrNum) ) {  
                 //输出是大写字母还是小写字母  
                 int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;  
                 val += (char)(random.nextInt(26) + temp);  
             } else if( "num".equalsIgnoreCase(charOrNum) ) {  
                 val += String.valueOf(random.nextInt(10));  
             }  
         }  
         return val;  
    }       
    
	/**
	 * 上传机构营业执照
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
    private HashMap<String, String> uploadLicenseFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
