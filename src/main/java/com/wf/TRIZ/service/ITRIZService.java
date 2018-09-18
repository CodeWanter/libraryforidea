package com.wf.TRIZ.service;

import com.baomidou.mybatisplus.service.IService;
import com.wf.model.TRIZ;
import com.wf.model.vo.TrizVO;

import java.util.List;

public interface ITRIZService extends IService<TRIZ> {
    List<TrizVO> selectTreePage(String name);

    int getMaxId();

    boolean insertTree(TRIZ triz);

    void deleteAll();
}
