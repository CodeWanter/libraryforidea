package com.wf.crosscheck.controller;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        //return "website/crosscheck/index";
    }

    /**
     * 获取创新助手html
     **/
    @ResponseBody
    @GetMapping("stadshtml")
    public String html() throws Exception {
        String url = "http://webstads.sciinfo.cn/stads.do?index";
        Document doc = Jsoup.connect(url).get();
        Elements imgEles = doc.getAllElements();
        for (Element imgEle : imgEles) {
            String element = imgEle.attr("src");
            imgEle.attr("src", ip + element);
        }
        doc.getElementsByClass("CXZS2018_topAll").remove();
        doc.getElementsByClass("CXZS2018_ft mobile").remove();
        newHtml = doc.html();
        String title = doc.title();
        Element body = doc.body();
        Element after = body.after("<div class=\"CXZS2018_shadow\"></div> ");
        return body.html();
    }
}
