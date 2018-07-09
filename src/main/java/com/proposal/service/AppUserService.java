package com.proposal.service;

import com.proposal.common.DataPager;
import com.proposal.entity.AppUser;
import com.proposal.exception.BizException;

import java.util.List;
import java.util.Map;

/**
 * Created by dynam on 2017/5/1.
 */
public interface AppUserService {

    int multiInsert(AppUser appUser);
    

    List<AppUser> listAppUser(int offset, int limit);

    /**
     * 撤回提案
     */
    Map<String, Object> userAgreeRefer(Map params) throws BizException;


    List<AppUser> listAppUserAjax(DataPager page);


    int getTotalCount();

    /**
     * 根据用户登录名获取用户
     *
     * @param loginName 登录名
     * @return
     */
    AppUser getAppUserByLoginName(String loginName);

    /**
     * 增加注册用户
     * */
    int addAppUser(AppUser appUser);
}
