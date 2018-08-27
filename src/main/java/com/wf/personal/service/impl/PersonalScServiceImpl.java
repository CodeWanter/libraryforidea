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
	public List<PersonalSc> selectByUIdAndEId(long userId, long eId) {
		PersonalSc personalSc = new PersonalSc();
		personalSc.setUserId(userId);
		personalSc.setEssayId(eId);
		EntityWrapper<PersonalSc> wrapper = new EntityWrapper<PersonalSc>(personalSc);
		return this.selectList(wrapper);
	}
	@Override
	public void selectSixData(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		page.setOrderByField(pageInfo.getSortT());
		page.setAsc(pageInfo.getTitle().equalsIgnoreCase("asc"));
		/*page.setTitleByField(pageInfo.getSortT());
		page.setTitleAsc(pageInfo.getTitle().equalsIgnoreCase("asc"));
		page.setAuthorByField(pageInfo.getSortA());
		page.setAuthorAsc(pageInfo.getAuthor().equalsIgnoreCase("asc"));
		page.setTimeByField(pageInfo.getSortM());
		page.setTimeAsc(pageInfo.getTime().equalsIgnoreCase("asc"));*/
		List<Map<String, Object>> list = personalScMapper.selectPersonalPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}
}
