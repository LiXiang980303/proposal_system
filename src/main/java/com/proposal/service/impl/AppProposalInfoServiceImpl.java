package com.proposal.service.impl;

import com.proposal.common.DataPager;
import com.proposal.dao.AppProposalInfoDao;
import com.proposal.entity.AppProposalComment;
import com.proposal.entity.AppProposalInfo;
import com.proposal.enums.AppProposalConstant;
import com.proposal.enums.ResultEnum;
import com.proposal.exception.BizException;
import com.proposal.service.AppProposalInfoService;
import com.proposal.service.BaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AppProposalInfoServiceImpl extends BaseService implements AppProposalInfoService {

    @Override
    @Transactional
    public Map<String, Object> addAppProposalInfo(AppProposalInfo appProposalInfo) throws BizException {
        // 新增提案前，需要判断是否有三个提案
        Map<String, Object> model = new HashMap<String, Object>();
        Map params = new HashMap();
        params.put("writer", appProposalInfo.getWriter());
        params.put("status", AppProposalConstant.STATUS_WAIT_APPROVE);
        params.put("offset", 0);
        params.put("limit", 10);
        List<AppProposalInfo> tmpList = dao.listAppProposalInfoByCondition(params);

        if (tmpList == null || tmpList.size() <= 3) {
            dao.insertAppProposalInfo(appProposalInfo);
        } else {
            model.put(RESULT_CODE, ResultEnum.BIZ_UNABLE_SUBMIT.getState());
            model.put(RESULT_MESG, ResultEnum.BIZ_UNABLE_SUBMIT.getMsg());
            return model;
        }

        model.put(RESULT_CODE, ResultEnum.BIZ_SUCCESS.getState());
        model.put(RESULT_MESG, "新增提案" + ResultEnum.BIZ_SUCCESS.getMsg());

        return model;
    }

    @Override
    public Map<String, Object> repealProposal(Map params) throws BizException {
        Map<String, Object> model = new HashMap<String, Object>();

        dao.updateAppProposalInfo(params);

        model.put(RESULT_CODE, ResultEnum.BIZ_SUCCESS.getState());
        model.put(RESULT_MESG, "撤回提案" + ResultEnum.BIZ_SUCCESS.getMsg());

        return model;
    }


    /**
     * 推荐提案
     */
    @Override
    public Map<String, Object> upgradeProposal(Map params) throws BizException {
        Map<String, Object> model = new HashMap<String, Object>();

        dao.updateAppProposalInfo(params);

        model.put(RESULT_CODE, ResultEnum.BIZ_SUCCESS.getState());
        model.put(RESULT_MESG, "推荐提案" + ResultEnum.BIZ_SUCCESS.getMsg());

        return model;
    }

    /**
     * 备案提案
     */
    @Override
    public Map<String, Object> recordProposal(Map params) throws BizException{
        Map<String, Object> model = new HashMap<String, Object>();

        dao.updateAppProposalInfo(params);

        model.put(RESULT_CODE, ResultEnum.BIZ_SUCCESS.getState());
        model.put(RESULT_MESG, "备案提案" + ResultEnum.BIZ_SUCCESS.getMsg());

        return model;
    }

    @Override
    public List<AppProposalInfo> listAppProposalInfoAjax(DataPager pager) {
        List<AppProposalInfo> result = new ArrayList<>();
        int offset = (pager.getPageIndex() - 1) * 10;
        int limit = pager.getPageSize();
        String srchVal = pager.getSearchVal();
        result = dao.queryAll(offset, limit);
        return result;
    }

    @Override
    public Map<String, Object> addAppProposalComment(AppProposalComment comment) throws BizException {
        // 新增提案前，需要判断是否有三个提案
        Map<String, Object> model = new HashMap<String, Object>();
        Map params = new HashMap();
        params.put("infoNo", comment.getInfoNo());
        params.put("commentUser", comment.getCommentUser());
        params.put("offset", 0);
        params.put("limit", 10);
        List<AppProposalComment> tmpList = dao.listAppProposalCommentByCondition(params);

        if (tmpList == null || tmpList.size() <= 0) {
            dao.insertAppProposalComment(comment);
        } else {
            model.put(RESULT_CODE, ResultEnum.BIZ_UNABLE_COMMENT.getState());
            model.put(RESULT_MESG, ResultEnum.BIZ_UNABLE_COMMENT.getMsg());
            return model;
        }

        model.put(RESULT_CODE, ResultEnum.BIZ_SUCCESS.getState());
        model.put(RESULT_MESG, "新增提案评论" + ResultEnum.BIZ_SUCCESS.getMsg());

        return model;
    }

    @Override
    public List<AppProposalInfo> listAppProposalInfo(int offset, int limit) {
        List<AppProposalInfo> result = new ArrayList<>();
        return dao.queryAll(offset, limit);
    }

    @Override
    public List<AppProposalComment> listAppProposalComment(Map params) {
        List<AppProposalComment> result = new ArrayList<>();
        return dao.listAppProposalCommentByCondition(params);
    }

    @Autowired
    private AppProposalInfoDao dao;

    private final Logger LOG = LoggerFactory.getLogger(this.getClass());

}
