package com.wf.accesslog.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.AccessLog;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/9/3.
 */
public interface AccessLogMapper extends BaseMapper<AccessLog> {

    List<Map<String, Object>> selectLogPage(Pagination page, Map<String, Object> params);

    Integer selectLogCount(Map<String, Object> params);

    @Select("SELECT access_log.res_type AS typeGroup from access_log group by access_log.res_type")
    List<String> selectTypeList();

    @Select("SELECT date_format(create_time, '%Y-%m') AS monthGroup from access_log where create_time > '${startTime}' and create_time < '${endTime}'  group by date_format(create_time, '%Y-%m') asc")
    List<String> selectTimeList(@Param("startTime") String startTime, @Param("endTime") String endTime);

    @Select("SELECT count(*) as pcount FROM access_log where create_time > '${startTime}' and create_time < '${endTime}' and access_log.res_type=#{resType} and date_format(create_time, '%Y-%m') ='${monthGroup}'")
    @ResultType(Integer.class)
    Integer selectCountByTypeList(@Param("startTime") String startTime, @Param("endTime") String endTime, @Param("resType") String accessType, @Param("monthGroup") String monthGroup);

    @Select("SELECT l.id, l.user_ip AS userIp,l.create_time AS createTime,l.res_type AS resType,\n" +
            "l.user_brower AS userBrower,l.url from access_log l where true and l.create_time >= '${startTime}' and l.create_time <='${endTime}' order by resType desc")
    List<AccessLog> selectlogList(@Param("startTime") String startTime, @Param("endTime") String endTime);
}
