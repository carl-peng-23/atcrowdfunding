package com.atecut.atcrowdfunding.component;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.atecut.atcrowdfunding.bean.TAdmin;
import com.atecut.atcrowdfunding.bean.TAdminExample;
import com.atecut.atcrowdfunding.bean.TPermission;
import com.atecut.atcrowdfunding.bean.TRole;
import com.atecut.atcrowdfunding.mapper.TAdminMapper;
import com.atecut.atcrowdfunding.mapper.TPermissionMapper;
import com.atecut.atcrowdfunding.mapper.TRoleMapper;

@Component
public class SecurityUserDetailServiceImpl implements UserDetailsService {

	@Autowired
	TAdminMapper adminMapper;
	
	@Autowired
	TRoleMapper roleMapper;
	
	@Autowired
	TPermissionMapper permissionMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		TAdminExample adminExample = new TAdminExample();
		adminExample.createCriteria().andLoginacctEqualTo(username);
		List<TAdmin> list = adminMapper.selectByExample(adminExample);
		if(list != null && list.size() == 1) {
			// 登录的用户
			TAdmin admin = list.get(0);

			// 查询角色的集合
			List<TRole> roleList = roleMapper.listRoleByAdminId(admin.getId());
			// 查询权限的集合
			List<TPermission> permissionList = permissionMapper.listPermissionByAdminId(admin.getId());
			// 构建用户所有权限的集合
			Set<GrantedAuthority> set = new HashSet<GrantedAuthority>();
			
			for (TRole role : roleList) {
				set.add(new SimpleGrantedAuthority("ROlE_" + role.getName()));
			}
			
			for (TPermission permission : permissionList) {
				set.add(new SimpleGrantedAuthority(permission.getName()));
			}
			
			//return new User(admin.getLoginacct(), admin.getUserpswd(), set);
			return new TSecurityAdmin(admin, set);
		} else {
			return null;
		}
	}
	
}
