package com.atecut.atcrowdfunding.component;

import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.atecut.atcrowdfunding.bean.TAdmin;

public class TSecurityAdmin extends User {

	private static final long serialVersionUID = 1L;
	
	TAdmin admin;

	public TSecurityAdmin(TAdmin admin, Set<GrantedAuthority> set) {
		super(admin.getLoginacct(), admin.getUserpswd(), true, true, true, true, set);
		this.admin = admin;
	}

	
}
