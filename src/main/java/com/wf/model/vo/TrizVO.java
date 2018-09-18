package com.wf.model.vo;

import java.io.Serializable;

/**
 * Created by Mr_Wanter on 2018/9/17.
 * triz树结构模型
 */
public class TrizVO implements Serializable {
    private Long id;
    private String name;
    private Integer pId;
    private Boolean open;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public Boolean getOpen() {
        return true;
    }

    public void setOpen(Boolean open) {
        this.open = open;
    }
}
