package com.wf.user.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.Tree;
import com.wf.model.Organization;

/**
 *
 * Organization 表数据服务层接口
 *
 */
public interface IOrganizationService extends IService<Organization> {

    List<Tree> selectTree();
    
    List<Tree> selectTopTree();

    List<Organization> selectTreeGrid();

}