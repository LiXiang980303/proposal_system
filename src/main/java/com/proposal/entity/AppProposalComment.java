package com.proposal.entity;

import java.util.Date;

/**
 * Created by dynam on 2017/5/1.
 */
public class AppProposalComment {
    private long commentNo;

    private long infoNo;

    private String commentContent;

    private String commentUser;

    private Date commentTime;

    private String status;

    public long getCommentNo() {
        return commentNo;
    }

    public void setCommentNo(long commentNo) {
        this.commentNo = commentNo;
    }

    public long getInfoNo() {
        return infoNo;
    }

    public void setInfoNo(long infoNo) {
        this.infoNo = infoNo;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public String getCommentUser() {
        return commentUser;
    }

    public void setCommentUser(String commentUser) {
        this.commentUser = commentUser;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
