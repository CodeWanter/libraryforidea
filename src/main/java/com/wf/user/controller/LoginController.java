package com.wf.user.controller;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.wf.commons.base.BaseController;
import com.wf.commons.shiro.PasswordHash;
import com.wf.commons.shiro.captcha.DreamCaptcha;
import com.wf.commons.utils.StringUtils;
import com.wf.model.User;
import com.wf.model.vo.UserVo;
import com.wf.user.service.IUserService;

/**
 * @description：登录退出
 * @author：zhixuan.wang @date：2015/10/1 14:51
 */
@Controller
public class LoginController extends BaseController {
    @Autowired
    private IUserService userService;
    @Autowired
    private PasswordHash passwordHash;
    @Autowired
    private DreamCaptcha dreamCaptcha;

    /**
     * 首页
     *
     * @return
     */
    @GetMapping("/")
    public String index() {
        return "redirect:/forehead/index";
    }

    /**
     * 前台首页
     *
     * @param model
     * @return
     */
    @GetMapping("/forehead/index")
    public String home(Model model,HttpServletRequest request,HttpServletResponse response) {
        return "homepage";
    }

    /**
     * 首页
     *
     * @param model
     * @return
     */
    @GetMapping("/index")
    public String index(Model model) {
        if (SecurityUtils.getSubject().isAuthenticated() == false) {
            return "redirect:/login";
        }
        return "index";
    }

    /**
     * GET 前台注册
     *
     * @return {String}
     */
    @GetMapping("/forehead/userRegist")
    public String userRegist() {
        return "website/account/registe";
    }

    /**
     * GET 前台登录
     *
     * @return {String}
     */
    @GetMapping("/forehead/userlogin")
    public String userLogin() {
        logger.info("GET请求前台登录");
        if (SecurityUtils.getSubject().isAuthenticated()) {
            return "redirect:/forehead";
        }
        return "website/account/login";
    }

    /**
     * GET 后台登录
     *
     * @return {String}
     */
    @GetMapping("/login")
    public String login() {
        logger.info("GET请求登录");
        if (SecurityUtils.getSubject().isAuthenticated()) {
            return "redirect:/index";
        }
        return "login";
    }

    /**
     * 添加用户
     *
     * @param userVo
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(UserVo userVo, HttpServletRequest request, HttpServletResponse response, String captcha,String acceptprotocol) {
        List<User> list = userService.selectByLoginName(userVo);
        if (StringUtils.isBlank(userVo.getLoginName())) {
            return renderError("用户名不能为空！");
        }
        if (list != null && !list.isEmpty()) {
            return renderError("用户名已存在!");
        }
        if (StringUtils.isBlank(userVo.getPassword())) {
            return renderError("密码不能为空！");
        }
        if (StringUtils.isBlank(captcha)) {
            return renderError("验证码不能为空！");
        }
        if (!dreamCaptcha.validate(request, response, captcha)) {
            return renderError("验证码错误！");
        }
        if (StringUtils.isBlank(acceptprotocol)) {
        	return renderError("请阅读并同意用户协议！");
        }
        String salt = StringUtils.getUUId();
        String pwd = passwordHash.toHex(userVo.getPassword(), salt);
        userVo.setSalt(salt);
        userVo.setPassword(pwd);
        userService.insertByVo(userVo);
        return renderSuccess();
    }

    /**
     * POST 登录 shiro 写法
     *
     * @param username 用户名
     * @param password 密码
     * @return {Object}
     */
    @PostMapping("/login")
    @ResponseBody
    public Object loginPost(HttpServletRequest request, HttpServletResponse response, String username, String password,
                            String captcha, @RequestParam(value = "rememberMe", defaultValue = "0") Integer rememberMe) {
        logger.info("POST请求登录");
        // 改为全部抛出异常，避免ajax csrf token被刷新
        if (StringUtils.isBlank(username)) {
            return renderError("用户名不能为空");
        }
        if (StringUtils.isBlank(password)) {
            return renderError("密码不能为空");
        }
        if (StringUtils.isBlank(captcha)) {
            return renderError("验证码不能为空");
        }
        if (!dreamCaptcha.validate(request, response, captcha)) {
            return renderError("验证码错误");
        }
        Subject user = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        // 设置记住密码
        token.setRememberMe(1 == rememberMe);
        try {
            user.login(token);
            return renderSuccess();
        } catch (UnknownAccountException e) {
            throw new RuntimeException("账号不存在！", e);
        } catch (DisabledAccountException e) {
            throw new RuntimeException("账号未启用！", e);
        } catch (IncorrectCredentialsException e) {
            throw new RuntimeException("密码错误！", e);
        } catch (Throwable e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }

    /**
     * 未授权
     *
     * @return {String}
     */
    @GetMapping("/unauth")
    public String unauth() {
        if (SecurityUtils.getSubject().isAuthenticated() == false) {
            return "redirect:/login";
        }
        return "unauth";
    }

    /**
     * 退出
     *
     * @return {Result}
     */
    @PostMapping("/logout")
    @ResponseBody
    public Object logout() {
        logger.info("登出");
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return renderSuccess();
    }

}
