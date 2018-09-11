package com.wf.personal.service.impl;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.model.PersonalSc;
import com.wf.personal.mapper.PersonalScMapper;
import com.wf.personal.service.IPersonalScService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonalScServiceImpl extends ServiceImpl<PersonalScMapper, PersonalSc> implements IPersonalScService {

	@Autowired
	private PersonalScMapper personalScMapper;

	@Override
	public void insertByPsc(PersonalSc psc) {
		this.insert(psc);
	}

	@Override
	public List<PersonalSc> selectByUIdAndEId(long userId, String eId) {
		EntityWrapper<PersonalSc> wrapper = new EntityWrapper<PersonalSc>();
		wrapper.where("user_id = {0}",userId).andNew("essay_id = {0}",eId);
		return this.selectList(wrapper);
	}
	@Override
	public void selectSixData(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = personalScMapper.selectPersonalPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}
}
