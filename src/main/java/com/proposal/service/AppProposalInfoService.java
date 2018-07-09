package com.proposal.service;

import com.proposal.common.DataPager;
import com.proposal.entity.AppProposalComment;
import com.proposal.entity.AppProposalInfo;
import com.proposal.exception.BizException;

import java.util.List;
import java.util.Map;

public interface AppProposalInfoService {

    /**
     * 增加提案
     */
    Map<String, Object> addAppProposalInfo(AppProposalInfo appProposalInfo) throws BizException;

    /**
     * 撤回提案
     */
    Map<String, Object> repealProposal(Map params) throws BizException;

    /**
     * 推荐提案
     */
    Map<String, Object> upgradeProposal(Map params) throws BizException;

    /**
     * 备案提案
     */
    Map<String, Object> recordProposal(Map params) throws BizException;

    /**
     * 获取提案列表
     */
    List<AppProposalInfo> listAppProposalInfo(int offset, int limit);


    /**
     * DataTable 获取列表
     */
    List<AppProposalInfo> listAppProposalInfoAjax(DataPager pager);

    /**
     * 对提案添加评论
     */
    Map<String, Object> addAppProposalComment(AppProposalComment comment) throws BizException;

    /**
     * 获取某条提案的评论
     */
    List<AppProposalComment> listAppProposalComment(Map params);
}
