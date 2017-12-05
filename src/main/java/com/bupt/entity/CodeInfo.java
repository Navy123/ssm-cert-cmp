package com.bupt.entity;

public class CodeInfo {
    private Long id;

    private Long baseId;

    private String cveId;

    private String codePosition;

    private String codeSection;

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

    public String getCodePosition() {
        return codePosition;
    }

    public void setCodePosition(String codePosition) {
        this.codePosition = codePosition == null ? null : codePosition.trim();
    }

    public String getCodeSection() {
        return codeSection;
    }

    public void setCodeSection(String codeSection) {
        this.codeSection = codeSection == null ? null : codeSection.trim();
    }

    public String getInfluence() {
        return influence;
    }

    public void setInfluence(String influence) {
        this.influence = influence == null ? null : influence.trim();
    }
}