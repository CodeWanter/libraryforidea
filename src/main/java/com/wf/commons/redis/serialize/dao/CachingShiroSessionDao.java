package com.wf.commons.redis.serialize.dao;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;

import java.io.Serializable;
import java.util.Collection;
import java.util.concurrent.TimeUnit;

/**
 * Created by Mr_Wanter on 2018/8/21.
 */

public class CachingShiroSessionDao  extends EnterpriseCacheSessionDAO {
    protected Logger logger = LogManager.getLogger(getClass());
    //session在redis中的过期时间:30分钟 30*60s
    private static final int expireTime = 1800;
    //redis中session名称前缀
    private static String prefix = "sessionId:";

    @Autowired
    private RedisTemplate<Object, Object> redisTemplate;

    @Override
    protected void doUpdate(Session session) {
        super.doUpdate(session);
        String key = prefix + session.getId().toString();
        if (!redisTemplate.hasKey(key)) {
            redisTemplate.opsForValue().set(key, session);
            logger.info("更新session:"+session.getId());
        }
        redisTemplate.expire(key, expireTime, TimeUnit.SECONDS);
    }

    @Override
    protected void doDelete(Session session) {
        logger.info("删除session:"+session.getId());
        super.doDelete(session);
        redisTemplate.delete(prefix + session.getId().toString());
    }

    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = super.doCreate(session);
        logger.info("创建session:"+session.getId());
        redisTemplate.opsForValue().set(prefix + sessionId.toString(), session);
        return sessionId;
    }

    @Override
    protected Session doReadSession(Serializable sessionId){
        Session session = super.doReadSession(sessionId);
        if(session == null){
            session = (Session) redisTemplate.opsForValue().get(prefix + sessionId.toString());
            logger.info("读取session:"+sessionId);
        }
        return session;
    }
    //获取当前活动的session
    @Override
    public Collection<Session> getActiveSessions() {
        return super.getActiveSessions();
    }
}
