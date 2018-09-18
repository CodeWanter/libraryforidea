package com.wf.TRIZ.controller;

import com.wf.TRIZ.service.ITRIZService;
import com.wf.model.vo.TrizVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Mr_Wanter on 2018/9/18.
 */
@Controller
@RequestMapping("/forehead/triz")
public class TRIZHeadController {

    @Autowired
    private ITRIZService trizService;

    @GetMapping("index")
    public String tirz() {
        return "website/triz/index";
    }

    //获取tree数据
    @PostMapping("trizTree")
    @ResponseBody
    public List<TrizVO> treeList(String name) {
        return trizService.selectTreePage(name);
    }

}
