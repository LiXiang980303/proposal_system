package com.proposal.service;

import java.util.List;

import com.proposal.entity.User;

public interface UserService {

	List<User> getUserList(int offset, int limit);
	 
}
