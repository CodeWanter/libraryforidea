package com.wf.industry.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.industry.mapper.ResInfoMapper;
import com.wf.industry.service.ResInfoService;
import com.wf.model.ResInfo;

@Service
public class ResInfoServiceImpl extends ServiceImpl<ResInfoMapper, ResInfo> implements ResInfoService {
	@Override
	public void insertByRes(ResInfo res) {
		this.insert(res);
	}
	@Override
	public List<ResInfo> selectByRId(int resId) {
		ResInfo resInfo = new ResInfo();
		resInfo.setResId(resId);
		EntityWrapper<ResInfo> wrapper = new EntityWrapper<ResInfo>(resInfo);
		return this.selectList(wrapper);
	}
}
