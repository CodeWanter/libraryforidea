package com.wf.policysc.controller;

import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.ImportExcelUtil;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Policy;
import com.wf.model.PolicySc;
import com.wf.policysc.service.IPolicyScService;

@Controller
@RequestMapping("/scpolicyback")
public class PolicyScBackController extends BaseController {
	
	@Autowired
	private IPolicyScService policyScService;
	
	 /*
     * 文章后台列表页
     */
    @GetMapping("list")
    public String list() {
        return "admin/policySc/list";
    }
    
    /*
     * 文章后台添加页
     */
    @GetMapping("add")
    public String add() {
    	return "admin/policySc/add";
    }
    
    /*
     * 文章后台编辑页
     */
    @GetMapping("edit")
    public String edit(Model model,long id) {
    	PolicySc policySc = policyScService.selectById(id);
        model.addAttribute("policySc", policySc);
    	return "admin/policySc/edit";
    }
    
    
    /**
     * 文章管理列表
     *
     * @param policySc
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(PolicySc policySc, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(policySc.getTitle())) {
            condition.put("title", policySc.getTitle());
        }
        if (StringUtils.isNotBlank(policySc.getColumnName())) {
            condition.put("columnName", policySc.getColumnName());
        }
        if (policySc.getIsShow() != null) {
            condition.put("isShow", policySc.getIsShow());
        }
        pageInfo.setCondition(condition);
        policyScService.selectDataGrid(pageInfo);
        return pageInfo;
    }
    
    /**
     * 保存文章
     *
     * @param policy 文章内容
     */
    @PostMapping("save")
    @ResponseBody
    public Object save(@Valid PolicySc policySc) {
    	policySc.setCreateTime(new Date());
    	policySc.setModifyTime(new Date());
        boolean isAdded = policyScService.insert(policySc);
        if (isAdded) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    
    /**
     * @param policy
     * @return
     * @throws ParseException
     */
    @PostMapping("update")
    @ResponseBody
    public Object edit(@Valid PolicySc policySc) throws ParseException {
        Date modifyTime = new java.sql.Date(new Date().getTime());
        policySc.setModifyTime(modifyTime);
        boolean isupdate = policyScService.updateById(policySc);
        if (isupdate) {
            return renderSuccess("修改成功！");
        } else {
            return renderError("修改失败！");
        }
    }
    
    /**
     * 删除文章
     *
     * @param id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean isdelete = policyScService.deleteById(id);
        if (isdelete) {
            return renderSuccess("删除成功！");
        } else {
            return renderSuccess("删除失败！");
        }
    }
    
    
    @GetMapping("excelImport")
    public String excelImport() {
        return "admin/policySc/excelImport";
    }

    @ResponseBody
    @RequestMapping(value = "excelUpload", method = {RequestMethod.GET, RequestMethod.POST})
    public Object excelUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        InputStream in = null;
        List<List<Object>> listob = null;
        MultipartFile file = multipartRequest.getFile("upexcelfile");
        if (file.isEmpty()) {
            throw new Exception("文件不存在！");
        }

        in = file.getInputStream();
        // FIXME: 2018/9/19 excel只读取了一行数据
        listob = new ImportExcelUtil().getBankListByExcel(in, file.getOriginalFilename());
        for (int i = 0; i < listob.size(); i++) {
            List<Object> lo = listob.get(i);
            PolicySc policySc = new PolicySc();
            policySc.setTitle(String.valueOf(lo.get(0)));
            policySc.setColumnName(String.valueOf(lo.get(1)));
            policySc.setContent(String.valueOf(lo.get(2)));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(String.valueOf(lo.get(3)));
            policySc.setCreateTime(date);
            policySc.setModifyTime(date);
            policySc.setIsShow(1);
            boolean insert = policyScService.insert(policySc);
            if (!insert) {
                return renderError("数据转换错误：" + policySc.toString());
            }
        }
        return renderSuccess("数据导入成功！");
    }
    
    
    
}
