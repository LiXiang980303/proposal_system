package com.proposal.dao;

import com.proposal.entity.AppProposalComment;
import com.proposal.entity.AppProposalInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AppProposalInfoDao {
    int insertAppProposalInfo(AppProposalInfo appProposalInfo);

    int updateAppProposalInfo(Map params);

    int queryTotalCount();

    List<AppProposalInfo> queryAll(@Param("offset") int offset, @Param("limit") int limit);

    List<AppProposalInfo> listAppProposalInfoByCondition(Map params);

    List<AppProposalComment> listAppProposalCommentByCondition(Map params);

    int insertAppProposalComment(AppProposalComment comment);
}
