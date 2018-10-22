package com.wf.user.controller;

import com.wf.commons.base.BaseController;
import com.wf.commons.redis.serialize.sessionUtil.UserSessionUtil;
import com.wf.commons.shiro.ShiroUser;
import com.wf.commons.shiro.captcha.DreamCaptcha;
import com.wf.commons.utils.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Mr_Wanter on 2018/10/9.
 */
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*", maxAge = 3600)
public class AccountRestController extends BaseController {

    @Autowired
    private DreamCaptcha dreamCaptcha;

    /**
     * 获取用户登录信息
     **/
    @PostMapping("/userInfo")
    public Object getUserInfo(String sessionID, HttpServletRequest request, HttpServletResponse response) {
        UserSessionUtil userSessionUtil = new UserSessionUtil(sessionID, request, response);
        ShiroUser userInfo = userSessionUtil.getUserInfo();
        loginData data = new loginData();
        data.setUsername(userInfo.getLoginName());
        data.setSid(sessionID);
        return renderSuccess(data);
    }

    @PostMapping("/login")
    public Object loginPost(HttpServletRequest request, String username, String password, String captcha) {
        boolean flg = true;
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
//        if (!dreamCaptcha.validate(request, response, captcha)) {
//            return renderError("验证码错误");
//        }
        Subject user = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        // 设置记住密码
        token.setRememberMe(1 == 1);
        try {
            user.login(token);
            ShiroUser shiroUser = getShiroUser();
            Session session = SecurityUtils.getSubject().getSession();
            Subject subject = SecurityUtils.getSubject();
            String sid = session.getId().toString();
            loginData data = new loginData();
            data.setSid(sid);
            data.setUsername(shiroUser.getLoginName());
            HttpSession sessionl = request.getSession();
            //把用户数据保存在session域对象中
            sessionl.setAttribute("loginName", username);
            return renderSuccess(data);
            //return shiroUser;
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

    @PostMapping("/logout")
    public void loginOut() {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
    }
}

class loginData {
    private String username;
    private String sid;

    public String getSid() {
        return sid;
    }
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }
}
