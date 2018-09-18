package com.wf.TRIZ.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.TRIZ.mapper.TRIZMapper;
import com.wf.TRIZ.service.ITRIZService;
import com.wf.commons.utils.StringUtils;
import com.wf.model.TRIZ;
import com.wf.model.vo.TrizVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class ITRIZServiceImpl extends ServiceImpl<TRIZMapper, TRIZ> implements ITRIZService {

    @Autowired
    private TRIZMapper trizMapper;

    @Override
    public List<TrizVO> selectTreePage(String name) {
        List<TrizVO> list = new ArrayList<TrizVO>();
        if (name != null && StringUtils.isNotBlank(name)) {
            list = trizMapper.selectTreePageByName(name);
        } else {
            list = trizMapper.selectTreePage();
        }
        for (TrizVO trizVO : list) {
            if (trizVO.getpId() == 0) {
                trizVO.setOpen(true);
            } else {
                trizVO.setOpen(false);
            }
        }
        return list;
    }

    @Override
    public int getMaxId() {
        return trizMapper.getMaxId();
    }

    @Override
    public boolean insertTree(TRIZ triz) {
        return trizMapper.insertTree(triz);
    }

    @Override
    public void deleteAll() {
        trizMapper.deleteAll();
    }
}
