package com.wf.crosscheck.controller;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/9/16.
 */
@Controller
@RequestMapping("/forehead/crosscheck")
public class CrossCheckController {
    private static Map<String, String> cookies = null;

    @GetMapping("/index")
    public String crossCheck(Model model) {
        try {
            String login = login("kk1", "111");
            //model.addAttribute("logindata",login);
            String url = "http://et.wanfangdata.com.cn/ky/Home";
            Connection connect = Jsoup.connect(url);
            cookies.put("kk1", "kk1");
            connect.header("Cookie", cookies.toString().replaceAll(",", ";"));
            cookies.put("homeshow", "1");
            // 伪造请求头
            connect.header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
            connect.header("Accept-Encoding", "gzip, deflate");
            connect.header("Accept-Language", "zh-CN,zh;q=0.9");
            connect.header("Connection", "keep-alive");
            connect.header("Cache-Control", "max-age=0");
            connect.header("Host", "et.wanfangdata.com.cn");
            connect.header("Upgrade-Insecure-Requests", "1");
            connect.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.6726.400 QQBrowser/10.2.2265.400");
            connect.cookies(cookies);
            // 直接获取DOM树，带着cookies去获取
            Document document = connect.get();
            System.out.println(document.toString());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return "redirect:http://et.wanfangdata.com.cn/ky/Home";
        }
    }

    /**
     * 模拟登陆http://et.wanfangdata.com.cn/ky
     *
     * @param userName 用户名
     * @param pwd      密码
     **/
    public static String login(String userName, String pwd) throws Exception {
        String urlLogin = "http://et.wanfangdata.com.cn/ky/Login/index";
        Connection connect = Jsoup.connect(urlLogin);
        // 伪造请求头
        connect.header("Accept", "application/json, text/javascript, */*; q=0.01").header("Accept-Encoding",
                "gzip, deflate");
        connect.header("Accept-Language", "zh-CN,zh;q=0.9").header("Connection", "keep-alive");
        connect.header("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        connect.header("Host", "et.wanfangdata.com.cn").header("Referer", "http://et.wanfangdata.com.cn/ky");
        connect.header("User-Agent",
                "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36")
                .header("X-Requested-With", "XMLHttpRequest");
        connect.followRedirects(true);
        // 携带登陆信息
        connect.data("Account", userName).data("Password", pwd).data("Force", "0").data("para", new Date().toString());
        //请求url获取响应信息
        Connection.Response res = connect.ignoreContentType(true).method(Connection.Method.POST).execute();// 执行请求
        // 获取返回的cookie
        cookies = res.cookies();
        for (Map.Entry<String, String> entry : cookies.entrySet()) {
            System.out.println(entry.getKey() + "-" + entry.getValue());
        }
        System.out.println("---------华丽的分割线-----------");
        String body = res.body();// 获取响应体
        System.out.println(body);
        return body;
    }
}
