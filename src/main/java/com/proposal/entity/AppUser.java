package com.proposal.entity;

import java.util.Date;

/**
 * Created by dynam on 2017/5/1.
 */
public class AppUser {
    private long userId;

    private String userName;

    private String loginName;

    private String sex;

    private String address;

    private String birth;

    private String refer;

    private String industryBranch;

    private String specialCommittee;

    private Date createTime;

    private long userPhone;

    private int priority;

    private String password;

    private String verify;

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public long getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(long userPhone) {
        this.userPhone = userPhone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getRefer() {
        return refer;
    }

    public void setRefer(String refer) {
        this.refer = refer;
    }

    public String getIndustryBranch() {
        return industryBranch;
    }

    public void setIndustryBranch(String industryBranch) {
        this.industryBranch = industryBranch;
    }

    public String getSpecialCommittee() {
        return specialCommittee;
    }

    public void setSpecialCommittee(String specialCommittee) {
        this.specialCommittee = specialCommittee;
    }

    public String getVerify() {
        return verify;
    }

    public void setVerify(String verify) {
        this.verify = verify;
    }

    @Override
    public String toString() {
        return "AppUser = [userId=" + userId + ", userName=" + userName + ", loginName=" + loginName + ", createTime=" + createTime + ", priority=" + priority + "]";
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
