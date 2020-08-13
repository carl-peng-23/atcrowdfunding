package com.atecut.atcrowdfunding.service;

import java.util.Map;

import javax.security.auth.login.LoginException;

import com.atecut.atcrowdfunding.bean.TAdmin;

public interface TAdminService {
	
	
	TAdmin getTAdminByLogin(Map<String, Object> paramMap) throws LoginException;
	
}
