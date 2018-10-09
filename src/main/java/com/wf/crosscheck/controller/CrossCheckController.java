package com.wf.crosscheck.controller;

import com.wf.commons.utils.ConfigProperties;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import sun.misc.BASE64Encoder;

import java.util.Date;
import java.util.Map;
import java.util.Properties;

/**
 * Created by Mr_Wanter on 2018/9/16.
 */
@Controller
@RequestMapping("/forehead/crosscheck")
public class CrossCheckController {
    private static Map<String, String> cookies = null;
    @GetMapping("/index")
    public String crossCheck() throws Exception {
        Properties properties = ConfigProperties.getProperties();
        String account = properties.getProperty("connect.api.apiAccount");
        String logintime = new Date().toString();
        String host = properties.getProperty("connect.api.apiHost");
        String token = String.join("|", new String[]{account, logintime, host});
        byte[] bt = token.getBytes();
        String secCode = (new BASE64Encoder()).encodeBuffer(bt);
        secCode = secCode.replace("\r\n", "");
        System.out.println("---------华丽的分割线-----------");
        return "redirect:http://115.29.2.102:8092/ky/Login/LoginSSO?Account=" + account + "&LoginTime=" + logintime + "&SecCode=" + secCode + "&returnUrl=http://115.29.2.102:8092/ky/Home";
    }

    /**
     * 模拟登陆http://et.wanfangdata.com.cn/ky
     *
     **/
    public static String login() throws Exception {
        String urlLogin = "http://115.29.2.102:8092/ky/Login/LoginSSO";
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

        Properties properties = ConfigProperties.getProperties();
        String account = properties.getProperty("connect.api.apiAccount");
        String logintime = new Date().toString();
        String host = properties.getProperty("connect.api.apiHost");
        String token = account + logintime + host;
        byte[] bt = token.getBytes();
        String secCode = (new BASE64Encoder()).encodeBuffer(bt);

        // 携带登陆信息
        connect.data("Account", account).data("LoginTime", logintime).data("SecCode", secCode).data("returnUrl", "http://115.29.2.102:8092/ky/Home");
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
