package com.wf.personal.service.impl;
import java.util.List;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.model.PersonalSc;
import com.wf.model.User;
import com.wf.model.vo.UserVo;
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
}
