package com.wf.model.vo;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Mr_Wanter on 2018/9/4.
 */
public class ChartSeries implements Serializable {
    private String name;
    private Object[] data;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Object[] getData() {
        return data;
    }

    public void setData(Object[] data) {
        this.data = data;
    }
}
