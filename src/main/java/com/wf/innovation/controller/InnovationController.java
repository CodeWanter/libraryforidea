package com.wf.innovation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Mr_Wanter on 2018/9/16.
 */
@Controller
@RequestMapping("innovation")
public class InnovationController {
    @GetMapping("/index")
    public String index(Model model) {
        return "innovation/index";
    }
}
