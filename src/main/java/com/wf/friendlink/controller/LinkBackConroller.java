package com.wf.friendlink.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.result.PageInfo;
import com.wf.commons.utils.StringUtils;
import com.wf.friendlink.service.ILinkService;
import com.wf.model.Link;
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
import java.util.List;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/8/6.
 */
@Controller
@RequestMapping("/linkback")
public class LinkBackConroller extends BaseController{

    @Autowired
    private ILinkService linkService;

    @GetMapping("/linkmanage")
    public String linkManage(){
        return "/admin/link/linkmanage";
    }

    @GetMapping("/create")
    public String create(){return "/admin/link/create";}

    @GetMapping("editPage")
    public String editPage(Model model, long id) {
        Link link = linkService.selectById(id);
        model.addAttribute("link", link);
        return "admin/link/edit";
    }

    @PostMapping("save")
    @ResponseBody
    public Object save(@Valid Link link) {
        link.setCreateTime(new Date());
        link.setModifyTime(new Date());
        boolean isAdded = linkService.insert(link);
        if (isAdded) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }

    @PostMapping("edit")
    @ResponseBody
    public Object edit(@Valid Link link) throws ParseException {
        Date modifyTime= new java.sql.Date(new java.util.Date().getTime());
        link.setModifyTime(modifyTime);
        boolean isupdate = linkService.updateById(link);
        if(isupdate) {
            return renderSuccess("修改成功！");
        }else {
            return renderError("修改失败！");
        }
    }

    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean isdelete = linkService.deleteById(id);
        if(isdelete) {
            return renderSuccess("删除成功！");
        }else {
            return renderSuccess("删除失败！");
        }
    }

    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Link link, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(link.getLinkName())) {
            condition.put("linkName", link.getLinkName());
        }
        if(link.getLinkStatus() != null) {
            condition.put("linkStatus", link.getLinkStatus());
        }
        pageInfo.setCondition(condition);
        linkService.selectDataGrid(pageInfo);
        return pageInfo;
    }
}
