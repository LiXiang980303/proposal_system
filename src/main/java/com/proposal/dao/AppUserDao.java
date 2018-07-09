package com.proposal.dao;

import com.proposal.entity.AppUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Created by dynam on 2017/4/30.
 */

public interface AppUserDao {

    /**
     * 增加新对象
     *
     * @param userName
     * @param loginName
     * @param userPhone
     * @param priority
     * @return
     */
    int insertUser(@Param("userName") String userName, @Param("loginName") String loginName,
                   @Param("userPhone") long userPhone, @Param("priority") int priority);

    /**
     * 根据登陆名查询用户对象
     *
     * @param loginName
     * @return
     */
    AppUser queryByLoginName(String loginName);

    /**
     * 根据偏移量查询用户列表
     *
     * @param offset
     * @param limit
     * @return
     */
    List<AppUser> queryAll(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 获取用户总数
     */
    int queryTotalCount();

    /**
     * 更新优先级
     *
     * @param newPriority
     */
    void updatePriority(@Param("newPriority") int newPriority);

    /**
     * 按条件检索
     *
     * @param priority
     * @param userName
     * @return
     */
    List<AppUser> queryByCondition(@Param("offset") int offset, @Param("limit") int limit,
                                   @Param("priority") String priority, @Param("userName") String userName,
                                   @Param("userPhone") String userPhone, @Param("loginName") String loginName);

    /**
     * DataTable 列表页面检索，模糊查询
     *
     * @param offset
     * @param limit
     * @param priority
     * @return
     */
    List<AppUser> queryFuzzy(@Param("offset") int offset, @Param("limit") int limit,
                             @Param("priority") String priority, @Param("userName") String userName,
                             @Param("userPhone") String userPhone, @Param("loginName") String loginName);


    int insertAppUser(@Param("userName") String userName, @Param("loginName") String loginName,
                      @Param("userPhone") long userPhone, @Param("priority") int priority,
                      @Param("birth") String birth, @Param("address") String address,
                      @Param("refer") String refer, @Param("industryBranch") String industryBranch,
                      @Param("specialCommittee") String specialCommittee, @Param("sex") String sex,
                      @Param("verify") String verify, @Param("password") String password);

    int insertAppUser(AppUser appUser);

    /**
     * 更新用户信息
     * */
    int updateAppProposalUser(Map params);
}
