package com.proposal.entity;

import java.util.Date;

public class AppProposalInfo {
    private long infoNo;

    private String infoName;

    private String infoContent;

    private String writer;

    private Date submitTime;

    private Date endTime;

    private Date updateTime;

    private String status;

    private int numAgree;

    private int numDisagree;

    public long getInfoNo() {
        return infoNo;
    }

    public void setInfoNo(long infoNo) {
        this.infoNo = infoNo;
    }

    public String getInfoName() {
        return infoName;
    }

    public void setInfoName(String infoName) {
        this.infoName = infoName;
    }

    public String getInfoContent() {
        return infoContent;
    }

    public void setInfoContent(String infoContent) {
        this.infoContent = infoContent;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getNumAgree() {
        return numAgree;
    }

    public void setNumAgree(int numAgree) {
        this.numAgree = numAgree;
    }

    public int getNumDisagree() {
        return numDisagree;
    }

    public void setNumDisagree(int numDisagree) {
        this.numDisagree = numDisagree;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public boolean equals(Object obj) {
        return super.equals(obj);
    }

    @Override
    public int hashCode() {
        return super.hashCode();
    }
}
