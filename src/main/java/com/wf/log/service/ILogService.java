package com.wf.log.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.LogStatistics;

import java.util.List;
import java.util.Map;


/**
 * Created by Mr_Wanter on 2018/9/3.
 */
public interface ILogService extends IService<LogStatistics> {

    void selectDataDrid(PageInfo pageInfo);

    Integer selectLogCount(Map<String, Object> params);

    Map<String, Object> selectCharDataList(String startTime, String endTime);

    List<LogStatistics> selectlogList(String startTime,String endTime);
}
