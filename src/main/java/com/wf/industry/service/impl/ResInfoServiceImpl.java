package com.wf.industry.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.Tree;
import com.wf.industry.mapper.IndustryMapper;
import com.wf.industry.mapper.ResInfoMapper;
import com.wf.industry.service.ResInfoService;
import com.wf.model.ResInfo;

@Service
public class ResInfoServiceImpl extends ServiceImpl<ResInfoMapper, ResInfo> implements ResInfoService {
	@Autowired
	private ResInfoMapper resInfoMapper;
	
	@Override
	public void insertByRes(ResInfo res) {
		this.insert(res);
	}
	@Override
	public void deleteByTName(String tableName) {
		ResInfo info = resInfoMapper.selectByTName(tableName);
		EntityWrapper<ResInfo> wrapper = new EntityWrapper<ResInfo>(info);
		this.delete(wrapper);
	}
	@Override
	public ResInfo selectByRTblName(String resTblName) {
		ResInfo info = resInfoMapper.selectByTName(resTblName);
		return info;
	}
	@Override
	public ResInfo selectById(int parseInt) {
		ResInfo info = resInfoMapper.selectById(parseInt);
		return info;
	}
	@Override
	public List<ResInfo> selectTreeGrid() {
        EntityWrapper<ResInfo> wrapper = new EntityWrapper<ResInfo>();
        wrapper.orderBy("res_id");
        return resInfoMapper.selectList(wrapper);
	}
	
    
    @Override
    public List<Tree> selectTree() {
        List<ResInfo> organizationList = selectTreeGrid();

        List<Tree> trees = new ArrayList<Tree>();
        if (organizationList != null) {
            for (ResInfo organization : organizationList) {
                Tree tree = new Tree();
                tree.setId((long) organization.getResId());
                tree.setText(organization.getResTblName());
                tree.setIconCls("glyphicon-send ");
                trees.add(tree);
            }
        }
        return trees;
    }
}
