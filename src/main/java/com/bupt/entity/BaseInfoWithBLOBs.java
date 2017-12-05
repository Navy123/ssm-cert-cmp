package com.bupt.entity;

public class BaseInfoWithBLOBs extends BaseInfo {
    private String description;

    private String solutionOpinion;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getSolutionOpinion() {
        return solutionOpinion;
    }

    public void setSolutionOpinion(String solutionOpinion) {
        this.solutionOpinion = solutionOpinion == null ? null : solutionOpinion.trim();
    }
}