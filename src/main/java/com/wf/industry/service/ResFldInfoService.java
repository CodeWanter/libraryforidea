package com.wf.industry.service;

import java.util.List;
import com.baomidou.mybatisplus.service.IService;
import com.wf.model.ResFldInfo;

public interface ResFldInfoService extends IService<ResFldInfo>{

	List<ResFldInfo> ListResFld(int resId);

}
