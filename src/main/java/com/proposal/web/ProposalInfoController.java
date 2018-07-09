package com.proposal.web;

import com.proposal.entity.AppProposalComment;
import com.proposal.entity.AppProposalInfo;
import com.proposal.entity.AppUser;
import com.proposal.enums.AppProposalConstant;
import com.proposal.enums.ResultEnum;
import com.proposal.service.AppProposalInfoService;
import com.proposal.util.EncryptUtil;
import com.proposal.util.JsonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@Scope("session")
@RequestMapping("/proposal")
public class ProposalInfoController extends BaseController {
    @RequestMapping(value = "/listAppProposal", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listAppProposal(HttpServletRequest request, HttpServletResponse response, String init) {
        LOG.info("invoke -------- /proposal/listAppProposal");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();

        if (!"1".equals(init)) {
            HttpSession session = request.getSession();
            AppUser appUser = (AppUser) session.getAttribute(LOGIN_INFO);
            if (appUser == null) {
                resMap.put(RESULT_MESG, ResultEnum.SESSION_IS_OUT_TIME.getMsg());
                return JsonUtils.transObject2Json(resMap);
            }
        }

        resMap.put(RESULT_CODE, RESULT_CODE_SUCCESS);
        try {
            List<AppProposalInfo> list = appProposalInfoService.listAppProposalInfo(0, 10);
            resMap.put("proposalList", list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }

    @RequestMapping(value = "/upgradeProposal", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String upgradeProposal(HttpServletRequest request, HttpServletResponse response, String infoNos) {
        LOG.info("invoke -------- /proposal/upgradeProposal");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, RESULT_CODE_FAILED);
        Map params = new HashMap();
        HttpSession session = request.getSession();
        AppUser appUser = (AppUser) session.getAttribute(LOGIN_INFO);
        if (appUser == null) {
            resMap.put(RESULT_MESG, ResultEnum.SESSION_IS_OUT_TIME.getMsg());
            return JsonUtils.transObject2Json(resMap);
        }

        infoNos = infoNos.substring(0, infoNos.length() - 1);
        params.put("infoNos", infoNos);
        params.put("priority", AppProposalConstant.UPGRADE_MAX);
        params.put("upgradeUser", appUser.getLoginName());

        try {
            resMap = appProposalInfoService.upgradeProposal(params);
        } catch (Exception e) {
            LOG.error(this.getClass().getName(), "submitNewProposal", e.getMessage());
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }

    @RequestMapping(value = "/recordProposal", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String recordProposal(HttpServletRequest request, HttpServletResponse response, String infoNos) {
        LOG.info("invoke -------- /proposal/recordProposal");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, RESULT_CODE_FAILED);
        Map params = new HashMap();
        HttpSession session = request.getSession();
        AppUser appUser = (AppUser) session.getAttribute(LOGIN_INFO);
        if (appUser == null) {
            resMap.put(RESULT_MESG, ResultEnum.SESSION_IS_OUT_TIME.getMsg());
            return JsonUtils.transObject2Json(resMap);
        }

        infoNos = infoNos.substring(0, infoNos.length() - 1);
        params.put("infoNos", infoNos);
        params.put("recordNo", AppProposalConstant.RECORD_1);
        params.put("recordUser", appUser.getLoginName());

        try {
            resMap = appProposalInfoService.recordProposal(params);
        } catch (Exception e) {
            LOG.error(this.getClass().getName(), "submitNewProposal", e.getMessage());
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }

    @RequestMapping(value = "/repealProposal", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String repealProposal(HttpServletRequest request, HttpServletResponse response, String infoNos) {
        LOG.info("invoke -------- /proposal/repealProposal");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, RESULT_CODE_FAILED);
        Map params = new HashMap();
        HttpSession session = request.getSession();
        AppUser appUser = (AppUser) session.getAttribute(LOGIN_INFO);
        if (appUser == null) {
            resMap.put(RESULT_MESG, ResultEnum.SESSION_IS_OUT_TIME.getMsg());
            return JsonUtils.transObject2Json(resMap);
        }

        infoNos = infoNos.substring(0, infoNos.length() - 1);
        params.put("infoNos", infoNos);
        params.put("status", AppProposalConstant.STATUS_UNREACH);

        try {
            resMap = appProposalInfoService.repealProposal(params);
        } catch (Exception e) {
            LOG.error(this.getClass().getName(), "submitNewProposal", e.getMessage());
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }


    @RequestMapping(value = "/submitNewProposal", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String submitNewProposal(HttpServletRequest request, HttpServletResponse response,
                                    String proposalName, String proposalContent, AppProposalInfo appProposalInfo) {
        LOG.info("invoke -------- /proposal/submitNewProposal");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, RESULT_CODE_FAILED);
        HttpSession session = request.getSession();
        AppUser appUser = (AppUser) session.getAttribute(LOGIN_INFO);
        if (appUser == null) {
            resMap.put(RESULT_MESG, ResultEnum.SESSION_IS_OUT_TIME.getMsg());
            return JsonUtils.transObject2Json(resMap);
        }

        // 0-编辑，1-待审核，2-通过，3-未通过
        appProposalInfo.setStatus(AppProposalConstant.STATUS_UNREACH);
        appProposalInfo.setWriter(appUser.getLoginName());
        appProposalInfo.setInfoName(proposalName);
        appProposalInfo.setInfoContent(proposalContent);

        try {
            resMap = appProposalInfoService.addAppProposalInfo(appProposalInfo);
        } catch (Exception e) {
            LOG.error(this.getClass().getName(), "submitNewProposal", e.getMessage());
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }


    @RequestMapping(value = "/submitComment", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String submitComment(HttpServletRequest request, HttpServletResponse response,
                                AppProposalComment comment) {
        LOG.info("invoke -------- /proposal/submitComment");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, RESULT_CODE_FAILED);
        HttpSession session = request.getSession();
        AppUser appUser = (AppUser) session.getAttribute(LOGIN_INFO);
        if (appUser == null) {
            resMap.put(RESULT_MESG, ResultEnum.SESSION_IS_OUT_TIME.getMsg());
            return JsonUtils.transObject2Json(resMap);
        }

        comment.setCommentUser(appUser.getLoginName());

        try {
            resMap = appProposalInfoService.addAppProposalComment(comment);
        } catch (Exception e) {
            LOG.error(this.getClass().getName(), "submitNewProposal", e.getMessage());
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }

    @RequestMapping(value = "/listAppProposalComment", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String listAppProposalComment(HttpServletRequest request, HttpServletResponse response, String infoNo) {
        LOG.info("invoke -------- /proposal/listAppProposalComment");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, RESULT_CODE_SUCCESS);
        Map params = new HashMap();
        try {
            params.put("offset", 0);
            params.put("limit", 10);
            params.put("infoNo", infoNo);

            List<AppProposalComment> list = appProposalInfoService.listAppProposalComment(params);
            resMap.put("commentlList", list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }


    private final Logger LOG = LoggerFactory.getLogger(this.getClass());

    @Autowired
    AppProposalInfoService appProposalInfoService;
}
