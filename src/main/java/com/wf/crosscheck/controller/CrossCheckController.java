package com.wf.crosscheck.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/9/16.
 */
@Controller
@RequestMapping("/forehead/crosscheck")
public class CrossCheckController {
    private static Map<String, String> cookies = null;
    @GetMapping("/index")
    public String crossCheck(Model model) throws Exception {
        return "website/crosscheck/index";
    }
}
