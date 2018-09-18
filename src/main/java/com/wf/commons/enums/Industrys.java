package com.wf.commons.enums;

/**
 * Created by Mr_Wanter on 2018/9/16.
 */
public enum Industrys {
    ZHANLI("2", "专利"),
    XIANGMU("3", "项目信息"),
    ZIXUN("4", "资讯"),
    KEJI("5", "科技成果");

    private final String value;//数据库类型值
    private final String str;//类型描述

    private Industrys(String value, String str) {
        this.value = value;
        this.str = str;
    }

    // 普通方法
    public static String getStr(String index) {
        for (Industrys c : Industrys.values()) {
            if (c.getValue() == index) {
                return c.str;
            }
        }
        return null;
    }

    public String getValue() {
        return value;
    }

    public String getStr() {
        return str;
    }

    //        public Integer getValue(){
//            return value;
//        }
//
//        public String getStr(){
//            return str;
//        }
}
