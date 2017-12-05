package com.bupt.entity;

public class AffectedProductWithBLOBs extends AffectedProduct {
    private String affectedOs;

    private String affectedSoft;

    public String getAffectedOs() {
        return affectedOs;
    }

    public void setAffectedOs(String affectedOs) {
        this.affectedOs = affectedOs == null ? null : affectedOs.trim();
    }

    public String getAffectedSoft() {
        return affectedSoft;
    }

    public void setAffectedSoft(String affectedSoft) {
        this.affectedSoft = affectedSoft == null ? null : affectedSoft.trim();
    }
}