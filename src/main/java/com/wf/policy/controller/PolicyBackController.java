package com.wf.policy.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.ImportExcelUtil;
import com.wf.commons.utils.StringUtils;
import com.wf.model.Policy;
import com.wf.policy.service.IPolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhanghuaiyu
 *         政策法规 后台管理控制器
 *         2018.08.02
 */
@Controller
@RequestMapping("/policyback")
public class PolicyBackController extends BaseController {

    @Autowired
    private IPolicyService policyService;


    /**
     * 注意：BaseController 中有xss过滤，会处理掉 ueditor 中的html
     * <p>
     * 所以你可以不继承它，或者注释掉BaseController中防止xss的代码
     * <p>
     * 毕竟管理平台几乎都是内网
     */
    @GetMapping("create")
    public String create() {
        return "admin/policy/create";
    }


    /*
     * 文章后台列表页
     */
    @GetMapping("list")
    public String list() {
        return "admin/policy/list";
    }

    /*
     * 后台修改文章页面
     */
    @GetMapping("editPage")
    public String editPage(Model model, long id) {
        Policy policy = policyService.selectById(id);
        model.addAttribute("policy", policy);
        return "admin/policy/edit";
    }

    /**
     * 保存文章
     *
     * @param policy 文章内容
     */
    @PostMapping("save")
    @ResponseBody
    public Object save(@Valid Policy policy) {
        policy.setCreateTime(new Date());
        policy.setModifyTime(new Date());
        boolean isAdded = policyService.insert(policy);
        if (isAdded) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }

	/*
     * 修改文章
	 */

    /**
     * @param policy
     * @return
     * @throws ParseException
     */
    @PostMapping("edit")
    @ResponseBody
    public Object edit(@Valid Policy policy) throws ParseException {
        Date modifyTime = new java.sql.Date(new Date().getTime());
        policy.setModifyTime(modifyTime);
        boolean isupdate = policyService.updateById(policy);
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
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean isdelete = policyService.deleteById(id);
        if (isdelete) {
            return renderSuccess("删除成功！");
        } else {
            return renderSuccess("删除失败！");
        }
    }

    /**
     * 文章管理列表
     *
     * @param policy
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Policy policy, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(policy.getTitle())) {
            condition.put("title", policy.getTitle());
        }
        if (policy.getIsShow() != null) {
            condition.put("isShow", policy.getIsShow());
        }
        pageInfo.setCondition(condition);
        policyService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    @GetMapping("excelImport")
    public String excelImport() {
        return "admin/policy/excelImport";
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
            Policy policy = new Policy();
            policy.setTitle(String.valueOf(lo.get(0)));
            policy.setContent(String.valueOf(lo.get(1)));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(String.valueOf(lo.get(2)));
            policy.setCreateTime(date);
            policy.setModifyTime(date);
            policy.setIsShow(1);
            boolean insert = policyService.insert(policy);
            if (!insert) {
                return renderError("数据转换错误：" + policy.toString());
            }
        }
        return renderSuccess("数据导入成功！");
    }
}
