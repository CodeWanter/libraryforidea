package com.wf.deliver.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.deliver.service.IDeliverService;
import com.wf.model.Deliver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhanghuaiyu
 *         原文传递 后台管理控制器
 *         2018.08.02
 */
@Controller
@RequestMapping("/deliverback")
public class DeliverBackController extends BaseController {

    @Autowired
    private IDeliverService deliverService;

    /*
     * 后台列表页
     */
    @GetMapping("list")
    public String list() {
        return "admin/deliver/index";
    }

    /*
     * 后台修改页面
     */
    @GetMapping("editPage")
    public String editPage(Model model, long id) {
        Deliver deliver = deliverService.selectById(id);
        model.addAttribute("deliver", deliver);
        return "admin/deliver/edit";
    }

    /**
     * 保存
     *
     * @param deliver 内容
     */
    @PostMapping("save")
    @ResponseBody
    public Object save(@Valid Deliver deliver) {
        deliver.setCreateTime(new Date());
        boolean isAdded = deliverService.insert(deliver);
        if (isAdded) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }

	/*
     * 修改
	 */

    /**
     * @param deliver
     * @return
     * @throws ParseException
     */
    @PostMapping("edit")
    @ResponseBody
    public Object edit(@Valid Deliver deliver) throws ParseException {
        Date modifyTime = new java.sql.Date(new Date().getTime());
        boolean isupdate = deliverService.updateById(deliver);
        if (isupdate) {
            return renderSuccess("修改成功！");
        } else {
            return renderError("修改失败！");
        }
    }


    /**
     * 删除
     *
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean isdelete = deliverService.deleteById(id);
        if (isdelete) {
            return renderSuccess("删除成功！");
        } else {
            return renderSuccess("删除失败！");
        }
    }

    /**
     * 管理列表
     *
     * @param deliver
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Deliver deliver, String startTime, String endTime, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(deliver.getTitle())) {
            condition.put("title", deliver.getTitle());
        }
        if (startTime != null) {
            condition.put("startTime", startTime);
        }
        if (endTime != null) {
            condition.put("endTime", endTime);
        }
        pageInfo.setCondition(condition);
        deliverService.selectDataGrid(pageInfo);
        return pageInfo;
    }

}
