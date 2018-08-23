package com.wf.commons.redis.serialize.sessionUtil;

/*
自定义的session过期异常类
 */
public class SessionException extends  Exception{

   static final long serialVersionUID = -3387516993124229948L;

   public SessionException() {
       super();
   }

   public SessionException(String message) {
       super(message);
   }
}
