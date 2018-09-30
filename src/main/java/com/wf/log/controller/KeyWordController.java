package com.wf.log.controller;

import com.wf.log.service.ILogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by Mr_Wanter on 2018/9/29.
 */
@RestController
@RequestMapping("/forehead/keyword")
public class KeyWordController {

    @Autowired
    private ILogService logService;

    @GetMapping("/getTopSixKeyWordLog")

    public Object getTopSixKeyWordLog() {
        List<String> keyWords = logService.getTopSixKeyWordLog();
        return keyWords;
    }
}
