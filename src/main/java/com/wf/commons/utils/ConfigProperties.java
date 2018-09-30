package com.wf.commons.utils;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import java.io.IOException;
import java.util.Properties;

/**
 * @ClassName ConfigProperties
 * @Description
 * @Author Heexl
 * @Date 2018年9月21日
 */
public class ConfigProperties {

    /**
     * 获取application.properties配置文件
     *
     * @return 配置Props
     */
    public static Properties getProperties() {

        // 读取配置文件
        Resource resource = new ClassPathResource("/config/application.properties");
        Properties properties = new Properties();
        try {
            properties = PropertiesLoaderUtils.loadProperties(resource);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return properties;
    }

}
