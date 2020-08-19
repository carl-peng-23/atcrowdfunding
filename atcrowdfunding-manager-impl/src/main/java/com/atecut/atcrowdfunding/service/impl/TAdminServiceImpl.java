package com.atecut.atcrowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import javax.security.auth.login.LoginException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atecut.atcrowdfunding.bean.TAdmin;
import com.atecut.atcrowdfunding.bean.TAdminExample;
import com.atecut.atcrowdfunding.bean.TAdminExample.Criteria;
import com.atecut.atcrowdfunding.mapper.TAdminMapper;
import com.atecut.atcrowdfunding.service.TAdminService;
import com.atecut.atcrowdfunding.util.AppDateUtils;
import com.atecut.atcrowdfunding.util.Const;
import com.atecut.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageInfo;

@Service
public class TAdminServiceImpl implements TAdminService {
	
	@Autowired
	TAdminMapper adminMapper;

	@Override
	public TAdmin getTAdminByLogin(Map<String, Object> paramMap) throws LoginException {
		
		// 1、密码加密
		
		// 2、查询用户
		String loginacct = (String)paramMap.get("loginacct");
		String userpswd = (String)paramMap.get("userpswd");
		
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(loginacct);
		List<TAdmin> list = adminMapper.selectByExample(example);

		// 3、判断用户是否为null
		
		if(list != null && list.size() == 1) {
			TAdmin admin = list.get(0);
			// 4、判断密码是否一致
			if(admin.getUserpswd().equals(MD5Util.digest(userpswd))) {
				// 5、返回结果
				return admin;
			}else {
				throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
			}
		}else {
			throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
		}
	}


	@Override
	public PageInfo<TAdmin> listAdminPage(Map<String, Object> paramMap) {
		TAdminExample example = new TAdminExample();
		String condition = (String) paramMap.get("condition");
		if(!"".equals(condition)) {
			example.createCriteria().andLoginacctLike("%" + condition + "%");
			Criteria criteria2 = example.createCriteria();
			criteria2.andUsernameLike("%" + condition + "%");
			Criteria criteria3 = example.createCriteria();
			criteria3.andEmailLike("%" + condition + "%");
			example.or(criteria2);
			example.or(criteria3);
		}
		
		example.setOrderByClause("createtime desc");
		List<TAdmin> list = adminMapper.selectByExample(example);
		PageInfo<TAdmin> page = new PageInfo<TAdmin>(list, 5);
		return page;
	}


	@Override
	public void saveTAdmin(TAdmin admin) {
		admin.setUserpswd("123456");
		admin.setCreatetime(AppDateUtils.getFormatTime());
		// 如果admin中属性为null，为null的属性不参加保存
		adminMapper.insertSelective(admin);
	}


	@Override
	public TAdmin getTAdminById(Integer id) {
		TAdmin admin = adminMapper.selectByPrimaryKey(id);
		return admin;
	}


	@Override
	public void updateTAdmin(TAdmin admin) {
		adminMapper.updateByPrimaryKeySelective(admin);
	}


	@Override
	public void deleteByATdminId(Integer id) {
		adminMapper.deleteByPrimaryKey(id);
	}


	@Override
	public void batchDeleteByATdminId(String ids) {
		adminMapper.batchDeleteByATdminId(ids);
	}
	
}
