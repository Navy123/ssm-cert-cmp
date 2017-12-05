package com.bupt.entity;

import java.util.Date;

public class BaseInfo {
    private Long id;

    private String cveId;

    private Date gmtCreate;

    private Date gmtModified;

    private String bugType;

    private Date publishTime;

    private Date modifiedTime;

    private String dangerLevel;

    private String reference;

    private Boolean isExistPatch;

    private Boolean isExistProductList;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCveId() {
        return cveId;
    }

    public void setCveId(String cveId) {
        this.cveId = cveId == null ? null : cveId.trim();
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Date getGmtModified() {
        return gmtModified;
    }

    public void setGmtModified(Date gmtModified) {
        this.gmtModified = gmtModified;
    }

    public String getBugType() {
        return bugType;
    }

    public void setBugType(String bugType) {
        this.bugType = bugType == null ? null : bugType.trim();
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public Date getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(Date modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    public String getDangerLevel() {
        return dangerLevel;
    }

    public void setDangerLevel(String dangerLevel) {
        this.dangerLevel = dangerLevel == null ? null : dangerLevel.trim();
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference == null ? null : reference.trim();
    }

    public Boolean getIsExistPatch() {
        return isExistPatch;
    }

    public void setIsExistPatch(Boolean isExistPatch) {
        this.isExistPatch = isExistPatch;
    }

    public Boolean getIsExistProductList() {
        return isExistProductList;
    }

    public void setIsExistProductList(Boolean isExistProductList) {
        this.isExistProductList = isExistProductList;
    }
}