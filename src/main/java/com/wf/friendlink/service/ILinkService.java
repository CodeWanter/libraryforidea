package com.wf.friendlink.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.PageInfo;
import com.wf.model.Link;

import java.util.List;

public interface ILinkService extends IService<Link>{
	void selectDataGrid(PageInfo pageInfo);
}
