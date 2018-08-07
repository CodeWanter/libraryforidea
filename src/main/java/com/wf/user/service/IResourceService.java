package com.wf.user.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.wf.commons.result.Tree;
import com.wf.commons.shiro.ShiroUser;
import com.wf.model.Resource;

/**
 *
 * Resource 表数据服务层接口
 *
 */
public interface IResourceService extends IService<Resource> {

    List<Resource> selectAll();

    List<Tree> selectAllMenu();

    List<Tree> selectAllTree();

    List<Tree> selectTree(ShiroUser shiroUser);

}