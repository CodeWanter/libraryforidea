package com.wf.log.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wf.model.LogStatistics;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/9/3.
 */
public interface LogMapper extends BaseMapper<LogStatistics>{

    List<Map<String, Object>> selectLogPage(Pagination page, Map<String, Object> params);

    Integer selectLogCount(Map<String, Object> params);

    @Select("SELECT log_statistics.access_type AS typeGroup from log_statistics group by log_statistics.access_type")
    List<String> selectTypeList();

    @Select("SELECT date_format(access_time, '%Y-%m') AS monthGroup from log_statistics where access_time > '${startTime}' and access_time < '${endTime}'  group by date_format(access_time, '%Y-%m') asc")
    List<String> selectTimeList(@Param("startTime")String startTime, @Param("endTime")String endTime);

    @Select("SELECT count(*) as pcount FROM log_statistics where access_time > '${startTime}' and access_time < '${endTime}' and log_statistics.access_type=#{accessType} and date_format(access_time, '%Y-%m') ='${monthGroup}'")
    @ResultType(Integer.class)
    Integer selectCountByTypeList(@Param("startTime")String startTime, @Param("endTime")String endTime,@Param("accessType") String accessType,@Param("monthGroup") String monthGroup);

    @Select("SELECT l.id, l.user_id AS userId ,r.login_name AS userName,l.user_ip AS userIp,l.access_time AS accessTime,l.access_type AS accessType,\n" +
            "l.user_brower AS userBrower,l.url,l.key_word AS keyWord from log_statistics l LEFT JOIN user r ON l.user_id = r.id where true and l.access_time >= '${startTime}' and l.access_time <='${endTime}' order by accessType desc")
    List<LogStatistics> selectlogList(@Param("startTime")String startTime, @Param("endTime")String endTime);

    @Select(" SELECT\n" +
            "        l.key_word AS keyWord\n" +
            "        from log_statistics l where key_word is NOT NULL and key_word  <> \"\"  GROUP BY l.key_word limit 0,10")
    List<String> getTopSixKeyWordLog();

    @Select(" SELECT\n" +
            "        l.key_word AS keyWord\n" +
            "        from log_statistics l where industry='${industry}' and key_word is NOT NULL and key_word  <> \"\"  GROUP BY l.key_word limit 0,10")
    List<String> getTopSixKeyWordLogById(@Param("industry") String industry);
}
