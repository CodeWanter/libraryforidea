package com.wf.TRIZ.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.wf.model.TRIZ;
import com.wf.model.vo.TrizVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface TRIZMapper extends BaseMapper<TRIZ> {

    @Select("SELECT\n" +
            "t.id, t.node_name AS name, t.parent_id AS pId,status AS status\n" +
            "FROM t_r_i_z t where true ")
    List<TrizVO> selectTreePage();

    @Select("SELECT\n" +
            "t.id, t.node_name AS name, t.parent_id AS pId,status AS status\n" +
            "FROM t_r_i_z t where true and t.node_name like CONCAT('%',${name},'%')")
    List<TrizVO> selectTreePageByName(@Param("name") String name);

    @Select("select max(t_r_i_z.id) from t_r_i_z")
    int getMaxId();

    boolean insertTree(TRIZ triz);

    @Delete("delete from t_r_i_z")
    void deleteAll();
}
