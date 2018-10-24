package com.wf.policysc.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.PolicySc;

public interface IPolicyScService extends IService<PolicySc> {
	public void selectDataGrid(PageInfo pageInfo);
}
