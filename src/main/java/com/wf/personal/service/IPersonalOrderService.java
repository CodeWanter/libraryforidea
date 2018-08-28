package com.wf.personal.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.PersonalOrder;

/**
 * Created by Mr_Wanter on 2018/8/28.
 */
public interface IPersonalOrderService extends IService<PersonalOrder> {
    void selectDataGrid(PageInfo pageInfo);
}
