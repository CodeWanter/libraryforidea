package com.wf.industry.service.impl;

import java.util.List;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.industry.mapper.ResFldInfoMapper;
import com.wf.industry.service.ResFldInfoService;
import com.wf.model.ResFldInfo;

@Service
public class ResFldInfoServiceImpl extends ServiceImpl<ResFldInfoMapper, ResFldInfo> implements ResFldInfoService {

	@Override
	public List<ResFldInfo> ListResFld(int resId) {
		ResFldInfo resFldInfo = new ResFldInfo();
		resFldInfo.setResId(resId);
		EntityWrapper<ResFldInfo> wrapper = new EntityWrapper<ResFldInfo>(resFldInfo);
		return this.selectList(wrapper);
	}
}
