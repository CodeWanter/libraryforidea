package com.wf.personal.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.article.mapper.ArticleMapper;
import com.wf.commons.result.PageInfo;
import com.wf.model.PersonalOrder;
import com.wf.model.PersonalSc;
import com.wf.personal.mapper.PersonalOrderMapper;
import com.wf.personal.mapper.PersonalScMapper;
import com.wf.personal.service.IPersonalOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by Mr_Wanter on 2018/8/28.
 */
@Service
public class PersonalOrderServiceImpl extends ServiceImpl<PersonalOrderMapper, PersonalOrder> implements IPersonalOrderService {
    @Autowired
    private PersonalOrderMapper personalOrderMapper ;

    @Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = personalOrderMapper.selectOrderPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }
}
