package com.wf.TRIZ.controller;

import com.wf.TRIZ.service.ITRIZService;
import com.wf.commons.base.BaseController;
import com.wf.commons.utils.ImportExcelUtil;
import com.wf.model.TRIZ;
import com.wf.model.vo.TrizVO;
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
import java.util.List;

/**
 * Created by Mr_Wanter on 2018/8/6.
 */
@Controller
@RequestMapping("/trizback")
public class TRIZBackConroller extends BaseController {

    @Autowired
    private ITRIZService trizService;

    @GetMapping("/trizmanage")
    public String linkManage() {
        return "/admin/triz/trizmanage";
    }

    @GetMapping("/create")
    public String create() {
        return "/admin/link/create";
    }

    @PostMapping("trizTree")
    @ResponseBody
    public List<TrizVO> treeList(String name) {
        return trizService.selectTreePage(name);
    }

    @GetMapping("editPage")
    public String editPage(Model model, long id) {
        TRIZ link = trizService.selectById(id);
        model.addAttribute("link", link);
        return "admin/triz/edit";
    }

    @PostMapping("save")
    @ResponseBody
    public Object save(@Valid TRIZ triz) {
        triz.setId(trizService.getMaxId() + 1);
        boolean isAdded = trizService.insertTree(triz);
        if (isAdded) {
            return renderSuccess(triz, "添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }

    @PostMapping("edit")
    @ResponseBody
    public Object edit(@Valid TRIZ triz) throws ParseException {
        boolean isupdate = trizService.updateById(triz);
        if (isupdate) {
            return renderSuccess("修改成功！");
        } else {
            return renderError("修改失败！");
        }
    }

    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Integer id) {
        boolean isdelete = trizService.deleteById(id);
        if (isdelete) {
            return renderSuccess("删除成功！");
        } else {
            return renderSuccess("删除失败！");
        }
    }

    @ResponseBody
    @RequestMapping(value = "ajaxUpload", method = {RequestMethod.GET, RequestMethod.POST})
    public Object ajaxUploadExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        InputStream in = null;
        List<List<Object>> listob = null;
        MultipartFile file = multipartRequest.getFile("upfile");
        if (file.isEmpty()) {
            throw new Exception("文件不存在！");
        }

        in = file.getInputStream();
        listob = new ImportExcelUtil().getBankListByExcel(in, file.getOriginalFilename());
        trizService.deleteAll();
        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        for (int i = 0; i < listob.size(); i++) {
            List<Object> lo = listob.get(i);
            TRIZ vo = new TRIZ();
            vo.setId(Integer.parseInt(lo.get(0).toString()));
            vo.setNodeName(String.valueOf(lo.get(1)));
            vo.setParentId(Integer.parseInt(lo.get(2).toString()));
            vo.setStatus(1);

            boolean insert = trizService.insertTree(vo);
            if (!insert) {
                return renderError("数据转换错误：" + vo.toString());
            }
        }
        return renderSuccess("文件导入成功！");
    }
}
