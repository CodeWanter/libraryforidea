package com.wf.policy.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.Policy;

public interface IPolicyService extends IService<Policy> {

    void selectDataGrid(PageInfo pageInfo);
}
