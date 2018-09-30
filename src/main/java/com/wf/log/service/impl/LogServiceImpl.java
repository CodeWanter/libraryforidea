package com.wf.log.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.log.mapper.LogMapper;
import com.wf.log.service.ILogService;
import com.wf.model.LogStatistics;
import com.wf.model.vo.ChartSeries;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/9/3.
 */
@Service
public class LogServiceImpl extends ServiceImpl<LogMapper, LogStatistics> implements ILogService {

    @Autowired
    private LogMapper logMapper;

    @Override
    public void selectDataDrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = logMapper.selectLogPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public Integer selectLogCount(Map<String, Object> params) {
        return logMapper.selectLogCount(params);
    }

    @Override
    public Map<String, Object> selectCharDataList(String startTime, String endTime) {
        Map<String, Object> map = new HashedMap();
        List<String> xlist = logMapper.selectTimeList(startTime,endTime);
        map.put("categories",xlist.toArray());
        List<String> tlist = logMapper.selectTypeList();

        Map<String,Object> series = new HashedMap();
        List<ChartSeries> slist = new ArrayList<>();
        List<Integer> monClo = new ArrayList<>();
        for(String str:tlist){
            series.clear();
            ChartSeries chartSeries = new ChartSeries();
            chartSeries.setName(str);
            monClo.clear();
            for (String mon:xlist ) {
                Integer c = logMapper.selectCountByTypeList(startTime,endTime,str,mon);
                monClo.add(c);
            }
            chartSeries.setData(monClo.toArray());
            slist.add(chartSeries);
        }
        map.put("result", slist);
        return map;
    }

    @Override
    public List<LogStatistics> selectlogList(String startTime, String endTime) {
        return logMapper.selectlogList(startTime,endTime);
    }

    @Override
    public List<String> getTopSixKeyWordLog() {
        return logMapper.getTopSixKeyWordLog();
    }
}
