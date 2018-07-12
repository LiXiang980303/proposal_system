package com.proposal.web;

import com.proposal.entity.AppProposalComment;
import com.proposal.entity.AppProposalUserRefer;
import com.proposal.entity.AppUser;
import com.proposal.entity.User;
import com.proposal.service.AppUserService;
import com.proposal.service.UserService;
import com.proposal.util.JsonUtils;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope("session")
@RequestMapping("/user")
public class UserController extends BaseController{

	private final Logger LOG = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	UserService userService;

	@Autowired
	AppUserService appUserService;


	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, Integer offset, Integer limit) {
		LOG.info("invoke----------/user/list");
		offset = offset == null ? 0 : offset;//默认便宜0
		limit = limit == null ? 100 : limit;//默认展示50条
		List<User> list = userService.getUserList(offset, limit);
		model.addAttribute("userlist", list);
		return "userlist";
	}


	/************ 身份管理相关 ****************/

	@RequestMapping(value = "/listRegisterUser", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String listRegisterUser(HttpServletRequest request, HttpServletResponse response, String infoNo) {
		LOG.info("invoke -------- /user/listRegisterUser");
		response.setContentType("text/html;charset=utf-8");
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(RESULT_CODE, RESULT_CODE_SUCCESS);
		Map params = new HashMap();
		try {
			params.put("offset", 0);
			params.put("limit", 100);
			params.put("infoNo", infoNo);

			List<AppUser> list = appUserService.listAppUser(0, 1000);
			resMap.put("registerUserList", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JsonUtils.transObject2Json(resMap);
	}


	@RequestMapping(value = "/searchUser", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String searchUser(HttpServletRequest request, HttpServletResponse response, String userName) {
		LOG.info("invoke -------- /user/listRegisterUser");
		response.setContentType("text/html;charset=utf-8");
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(RESULT_CODE, RESULT_CODE_SUCCESS);
		Map params = new HashMap();
		try {
			params.put("offset", 0);
			params.put("limit", 100);
			params.put("userName", userName);

			AppUser user = appUserService.queryUserRefer(userName);
			List<AppUser> list = new ArrayList<>();
			list.add(user);
			resMap.put("searchUserList", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JsonUtils.transObject2Json(resMap);
	}

	@RequestMapping(value = "/userAgreeRefer", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String userAgreeRefer(HttpServletRequest request, HttpServletResponse response,
								 String status, String userId) {
		LOG.info("invoke -------- /user/userAgreeRefer");
		response.setContentType("text/html;charset=utf-8");
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(RESULT_CODE, RESULT_CODE_SUCCESS);
		Map params = new HashMap();
		try {
			params.put("offset", 0);
			params.put("limit", 100);
			params.put("verify", status);
			params.put("userId", userId);

			resMap = appUserService.userAgreeRefer(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JsonUtils.transObject2Json(resMap);
	}

	@RequestMapping(value = "/submitNewRefer", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String submitNewRefer(HttpServletRequest request, HttpServletResponse response,
								 AppProposalUserRefer refer) {
		LOG.info("invoke -------- /user/submitNewRefer");
		response.setContentType("text/html;charset=utf-8");
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(RESULT_CODE, RESULT_CODE_SUCCESS);
		Map params = new HashMap();
		try {

			params.put("refer", refer);

			int x = appUserService.submitNewRefer(params);

			if (x >= 1) {
				resMap.put(RESULT_MESG, "成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JsonUtils.transObject2Json(resMap);
	}

	/************ 身份管理相关 ****************/

}
