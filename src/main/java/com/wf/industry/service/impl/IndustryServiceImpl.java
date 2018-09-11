package com.wf.industry.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.wf.commons.result.Tree;
import com.wf.model.IndustryData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wf.commons.result.PageInfo;
import com.wf.industry.mapper.IndustryMapper;
import com.wf.industry.service.IIndustryService;
import com.wf.model.Industry;

@Service
public class IndustryServiceImpl extends ServiceImpl<IndustryMapper, Industry> implements IIndustryService {
	@Autowired
	private IndustryMapper industryMapper;
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
		page.setOrderByField(pageInfo.getSort());
		page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = industryMapper.selectIndustryPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}
    @Override
    public List<Industry> selectAll() {
        return selectAllByStatus();
    }
    private List<Industry> selectAllByStatus() {
    	Industry industry = new Industry();
        EntityWrapper<Industry> wrapper = new EntityWrapper<Industry>(industry);
        wrapper.orderBy("create_time",false);
        return industryMapper.selectList(wrapper);
    }

	@Override
	public List<Tree> selectTree() {
		List<Industry> industryList = selectTreeGrid();

		List<Tree> trees = new ArrayList<Tree>();
		if (industryList != null) {
			for (Industry industry : industryList) {
				Tree tree = new Tree();
				tree.setId(industry.getId());
				tree.setText(industry.getTitle());
				tree.setIconCls("glyphicon-send");
				trees.add(tree);
			}
		}
		return trees;
	}

	@Override
	public List<Industry> selectTreeGrid() {
		EntityWrapper<Industry> wrapper = new EntityWrapper<Industry>();
		wrapper.orderBy("create_time");
		return industryMapper.selectList(wrapper);
	}


}
