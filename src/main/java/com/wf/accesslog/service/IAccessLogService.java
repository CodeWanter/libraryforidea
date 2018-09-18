package com.wf.accesslog.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.AccessLog;

import java.util.List;
import java.util.Map;


/**
 * Created by Mr_Wanter on 2018/9/3.
 */
public interface IAccessLogService extends IService<AccessLog> {

    void selectDataDrid(PageInfo pageInfo);

    Integer selectLogCount(Map<String, Object> params);

    Map<String, Object> selectCharDataList(String startTime, String endTime);

    List<AccessLog> selectlogList(String startTime, String endTime);
}
