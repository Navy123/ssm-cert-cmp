package com.bupt.entity;

public class FrameInfo {
    private Long id;

    private Long baseId;

    private String cveId;

    private String frameName;

    private String frameType;

    private String frameLanguage;

    private String influence;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getBaseId() {
        return baseId;
    }

    public void setBaseId(Long baseId) {
        this.baseId = baseId;
    }

    public String getCveId() {
        return cveId;
    }

    public void setCveId(String cveId) {
        this.cveId = cveId == null ? null : cveId.trim();
    }

    public String getFrameName() {
        return frameName;
    }

    public void setFrameName(String frameName) {
        this.frameName = frameName == null ? null : frameName.trim();
    }

    public String getFrameType() {
        return frameType;
    }

    public void setFrameType(String frameType) {
        this.frameType = frameType == null ? null : frameType.trim();
    }

    public String getFrameLanguage() {
        return frameLanguage;
    }

    public void setFrameLanguage(String frameLanguage) {
        this.frameLanguage = frameLanguage == null ? null : frameLanguage.trim();
    }

    public String getInfluence() {
        return influence;
    }

    public void setInfluence(String influence) {
        this.influence = influence == null ? null : influence.trim();
    }
}