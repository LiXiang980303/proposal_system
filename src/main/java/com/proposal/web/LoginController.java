package com.proposal.web;

import com.proposal.entity.AppUser;
import com.proposal.service.AppUserService;
import com.proposal.service.impl.AppUserServiceImpl;
import com.proposal.util.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@Scope("session")
@RequestMapping("/login")
public class LoginController extends BaseController {

    private final String LOGIN_SUCCESS = "success";
    private final String LOGIN_FAILED = "failed";

    @RequestMapping("/sign")
    public String sign(Model model, String loginName, String password) {
        LOG.info("invoke -------- /login/sign [" + loginName + "]");

        if (StrUtils.isNullOrEmpty(loginName)) {
            return "redirect:/html/signin.html";
        }

        AppUser appUser = appUserSrv.getAppUserByLoginName(loginName);

        if (appUser == null) {
            model.addAttribute("LOGIN_STATUS", "USER_NOT_EXITS");
            return "redirect:/html/signin.html";
        }

        // 获取加密内容
        String rPassword = appUser.getPassword() == null ? "" : appUser.getPassword();
        // 对用户输入的密码进行加密
        String dPassword = EncryptUtil.EncryptPassword(password);
        if (true || rPassword.equals(dPassword)) {
            model.addAttribute("LOGIN_STATUS", "SUCCESS");
            model.addAttribute("appUser", appUser);
            return "redirect:/jsp/index.jsp";
        }

        model.addAttribute("LOGIN_STATUS", "WRONG_PSW");
        return "redirect:/jsp/signin.jsp";
    }

    @RequestMapping(value = "/signin", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String signin(HttpServletRequest request, HttpServletResponse response, String loginName, String password) {
        LOG.info("invoke -------- /login/signin");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, LOGIN_FAILED);
        String passwd = request.getParameter("password");
        HttpSession session = request.getSession(true);
        try {
            AppUser appUser = appUserSrv.getAppUserByLoginName(loginName);
            if (appUser == null) {
                resMap.put(RESULT_MESG, "用户不存在");
                return JsonUtils.transObject2Json(resMap);
            }

            if (!"1".equals(appUser.getVerify())) {
                resMap.put(RESULT_MESG, "用户尚未通过审核");
                return JsonUtils.transObject2Json(resMap);
            }

            // 获取加密内容
            String rPassword = appUser.getPassword() == null ? "" : appUser.getPassword();
            // 对用户输入的密码进行加密
            String dPassword = EncryptUtil.EncryptPassword(passwd);
            if (rPassword.equals(passwd) || rPassword.equals(dPassword)) {
                resMap.put(RESULT_CODE, LOGIN_SUCCESS);
                resMap.put(RESULT_MESG, "登录成功");
                resMap.put("accessGranted", true);

                session.setAttribute(LOGIN_INFO, appUser);

                return JsonUtils.transObject2Json(resMap);
            } else {
                resMap.put(RESULT_MESG, "密码错误");
                return JsonUtils.transObject2Json(resMap);
            }

        } catch (Exception e) {
            LOG.error(this.getClass().getName(), "signin", "登录错误");
            e.printStackTrace();
        }
        return JsonUtils.transObject2Json(resMap);
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public String register(HttpServletRequest request, HttpServletResponse response, AppUser appUser) {
        LOG.info("invoke -------- /login/register");
        Map<String, Object> resMap = new HashMap<String, Object>();

        appUser.setVerify("0");
        appUser.setLoginName(appUser.getUserName());
        int res = appUserSrv.addAppUser(appUser);
        if (res == 1) {
            resMap.put(RESULT_MESG, "注册成功");
        } else {
            resMap.put(RESULT_MESG, "注册失败");
        }

        return JsonUtils.transObject2Json(resMap);
    }

    @RequestMapping(value = "/logout", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("invoke -------- /login/logout");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();

        HttpSession session = request.getSession();
        if (session != null && session.getAttribute(LOGIN_INFO) != null) {
            session.setAttribute(LOGIN_INFO, null);
        }

        resMap.put(RESULT_CODE, "success");
        resMap.put(RESULT_MESG, "退出成功");

        return JsonUtils.transObject2Json(resMap);
    }

    @RequestMapping(value = "/getLoginInfo", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getLoginInfo(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("invoke -------- /login/getLoginInfo");
        response.setContentType("text/html;charset=utf-8");
        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put(RESULT_CODE, LOGIN_FAILED);

        HttpSession session = request.getSession();
        if (session == null && session.getAttribute(LOGIN_INFO) == null) {
            resMap.put(RESULT_MESG, "用户未登录");
            return JsonUtils.transObject2Json(resMap);
        }

        AppUser appUser = (AppUser) session.getAttribute(LOGIN_INFO);

        resMap.put(RESULT_CODE, "success");
        resMap.put(LOGIN_INFO, appUser);

        return JsonUtils.transObject2Json(resMap);
    }



    private final Logger LOG = LoggerFactory.getLogger(this.getClass());

    @Autowired
    AppUserService appUserSrv = new AppUserServiceImpl();

}
