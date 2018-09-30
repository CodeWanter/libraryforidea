package com.wf.deliver.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.Deliver;

public interface IDeliverService extends IService<Deliver> {

    void selectByID(PageInfo pageInfo);

    void selectDataGrid(PageInfo pageInfo);
}
