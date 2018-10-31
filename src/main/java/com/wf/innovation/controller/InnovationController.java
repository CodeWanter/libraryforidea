package com.wf.innovation.controller;

import com.wf.commons.base.BaseController;
import com.wf.model.vo.UserVo;
import com.wf.user.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Mr_Wanter on 2018/9/16.
 * 双创平台
 */
@Controller
@RequestMapping("innovation")
public class InnovationController extends BaseController {

    @Autowired
    private IUserService userService;

    //首页
    @GetMapping("/index")
    public String index(Model model) {
        return "innovation/index";
    }

    //登陆
    @GetMapping("login")
    public String userLogin() {
        return "innovation/account/login";
    }

    //注册
    @GetMapping("regist")
    public String userRegist() {
        return "innovation/account/registe";
    }

    //个人中心
    @GetMapping("center")
    public String center(Model model) {
        Long userId = getUserId();
        if (userId != null) {
            UserVo userVo = userService.selectVoById(userId);
            model.addAttribute("user", userVo);
            return "innovation/personal/center";
        } else {
            return "redirect:/innovation/index";
        }
    }

}
