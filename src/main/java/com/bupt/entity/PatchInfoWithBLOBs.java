package com.bupt.entity;

public class PatchInfoWithBLOBs extends PatchInfo {
    private String description;

    private String patchCode;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getPatchCode() {
        return patchCode;
    }

    public void setPatchCode(String patchCode) {
        this.patchCode = patchCode == null ? null : patchCode.trim();
    }
}