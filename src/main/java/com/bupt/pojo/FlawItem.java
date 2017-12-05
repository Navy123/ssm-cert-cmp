package com.bupt.pojo;

import com.bupt.entity.*;

/**
 * Created by hxg on 2017/9/8.
 */
public class FlawItem {
    private BaseInfoWithBLOBs baseInfo;
    private CodeInfo codeInfo;
    private FrameInfo frameInfo;
    private LibInfo libInfo;
    private AffectedProductWithBLOBs affectedProduct;

    public BaseInfoWithBLOBs getBaseInfo() {
        return baseInfo;
    }

    public void setBaseInfo(BaseInfoWithBLOBs baseInfo) {
        this.baseInfo = baseInfo;
    }

    public CodeInfo getCodeInfo() {
        return codeInfo;
    }

    public void setCodeInfo(CodeInfo codeInfo) {
        this.codeInfo = codeInfo;
    }

    public FrameInfo getFrameInfo() {
        return frameInfo;
    }

    public void setFrameInfo(FrameInfo frameInfo) {
        this.frameInfo = frameInfo;
    }

    public LibInfo getLibInfo() {
        return libInfo;
    }

    public void setLibInfo(LibInfo libInfo) {
        this.libInfo = libInfo;
    }

    public AffectedProductWithBLOBs getAffectedProduct() {
        return affectedProduct;
    }

    public void setAffectedProduct(AffectedProductWithBLOBs affectedProduct) {
        this.affectedProduct = affectedProduct;
    }
}
