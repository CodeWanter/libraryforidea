package com.wf.personal.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.wf.model.PersonalSc;

public interface IPersonalScService extends IService<PersonalSc>{
	void insertByPsc(PersonalSc psc);
	List<PersonalSc> selectByUIdAndEId(long userId, long eId);
}
