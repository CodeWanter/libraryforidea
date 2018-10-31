package com.wf.log.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.shiro.ShiroUser;
import com.wf.log.service.ILogService;
import com.wf.user.service.IUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Mr_Wanter on 2018/9/29.
 */
@RestController
@RequestMapping("/forehead/keyword")
public class KeyWordController extends BaseController {

    @Autowired
    private ILogService logService;
    @Autowired
    private IUserService userService;

    @GetMapping("/getTopSixKeyWordLog")
    public Object getTopSixKeyWordLog() {
        List<String> keyWords = new ArrayList<>();
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        ShiroUser user = (ShiroUser) session.getAttribute("user");
        if (user == null) {
            keyWords = logService.getTopSixKeyWordLog();
        } else {
            Long userid = getShiroUser().getId();
            String industry = userService.selectVoById(userid).getIndustry();
            keyWords = logService.getTopSixKeyWordLogById(industry);
        }
        return keyWords;
    }
}
