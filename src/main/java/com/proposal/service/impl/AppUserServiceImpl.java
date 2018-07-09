package com.proposal.service.impl;

import com.proposal.enums.ResultEnum;
import com.proposal.exception.BizException;
import com.proposal.service.BaseService;
import com.proposal.util.*;
import com.proposal.common.DataPager;
import com.proposal.dao.AppUserDao;
import com.proposal.entity.AppUser;
import com.proposal.service.AppUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dynam on 2017/5/1.
 */
@Service
public class AppUserServiceImpl extends BaseService implements AppUserService {

    @Override
    public int getTotalCount() {
        return appUserDao.queryTotalCount();
    }

    @Override
    public List<AppUser> listAppUser(int offset, int limit) {
        List<AppUser> result = new ArrayList<>();

        result = appUserDao.queryAll(offset, limit);

        return result;
    }

    @Override
    public Map<String, Object> userAgreeRefer(Map params) throws BizException {
        Map<String, Object> model = new HashMap<String, Object>();

        appUserDao.updateAppProposalUser(params);

        model.put(RESULT_CODE, ResultEnum.BIZ_SUCCESS.getState());
        model.put(RESULT_MESG, "操作用户" + ResultEnum.BIZ_SUCCESS.getMsg());

        return model;
    }

    @Override
    public List<AppUser> listAppUserAjax(DataPager pager) {
        List<AppUser> result = new ArrayList<>();
        int offset = (pager.getPageIndex() - 1) * 10;
        int limit = pager.getPageSize();
        String srchVal = pager.getSearchVal();
        if (StrUtils.isNullOrEmpty(srchVal)) {
            result = appUserDao.queryAll(offset, limit);
        } else {
            //srchVal = "%"+ srchVal +"%";
            result = appUserDao.queryFuzzy(offset, limit, srchVal, srchVal, srchVal, srchVal);
        }
        return result;
    }

    @Override
    public int multiInsert(AppUser appUser) {
        String userName = appUser.getUserName();
        String loginName = appUser.getLoginName();
        long userPhone = appUser.getUserPhone();
        int priority = appUser.getPriority();
        int res = appUserDao.insertUser(userName, loginName, userPhone, priority);
        return res;
    }

    @Override
    public AppUser getAppUserByLoginName(String loginName) {
        return appUserDao.queryByLoginName(loginName);
    }

    @Override
    public int addAppUser(AppUser appUser) {
        return appUserDao.insertAppUser(appUser);
    }

    private final Logger LOG = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private AppUserDao appUserDao;
}
