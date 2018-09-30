package com.wf.commons.redis.serialize.sessionUtil;

import com.wf.commons.shiro.ShiroUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.SessionException;
import org.apache.shiro.session.mgt.SessionKey;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.apache.shiro.web.session.mgt.WebSessionKey;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Mr_Wanter on 2018/8/22.
 */
public class UserSessionUtil {

    private ShiroUser userInfo;

    public UserSessionUtil(String sessionId,HttpServletRequest request,  HttpServletResponse response){
        this.userInfo = this.getUserInfo(sessionId, request, response);
        System.out.println(sessionId);
    }

    //判断session是否过期（用户是否在线）
    public boolean isExistUserInReids(){
        boolean isExist=false;
        if(userInfo!=null){
            if(userInfo.getId()!=null){
                isExist= true;
            }
        }
        return isExist;
    }

    //获取用户id
    public Long getUserIdfromRedis() throws SessionException {
        if(isExistUserInReids()){
            return userInfo.getId();
        }else{
            throw new SessionException("亲爱的用户，您尚未登录，请重新登录！");
        }
    }

    /*
    根据sessionid,获取shiro用户对象
     */
    private ShiroUser getUserInfo(String sessionID, HttpServletRequest request, HttpServletResponse response){
        boolean status = false;
        SessionKey key = new WebSessionKey(sessionID,request,response);
        try{
            Session se = SecurityUtils.getSecurityManager().getSession(key);
            Object obj = se.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
            SimplePrincipalCollection coll = (SimplePrincipalCollection) obj;
            return (ShiroUser)coll.getPrimaryPrincipal();
        }catch(Exception e){

        }finally{
        }
        return null;
    }
}

