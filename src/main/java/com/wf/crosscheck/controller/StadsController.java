package com.wf.crosscheck.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Mr_Wanter on 2018/9/16.
 */
@Controller
@RequestMapping("/forehead/stads")
public class StadsController {

    private String ip = "http://webstads.sciinfo.cn/";
    private String newHtml;

    @GetMapping("/index")
    public String stadIndex() {
        return "/website/stads/index";
    }
}
