package com.wf.personal.service.impl;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
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
}
