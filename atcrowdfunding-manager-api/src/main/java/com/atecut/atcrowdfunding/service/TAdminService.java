package com.atecut.atcrowdfunding.service;

import java.util.Map;

import javax.security.auth.login.LoginException;

import com.atecut.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

public interface TAdminService {
	
	/**
	 * 通过账号密码查询admin
	 * @param paramMap
	 * @return
	 * @throws LoginException
	 */
	TAdmin getTAdminByLogin(Map<String, Object> paramMap) throws LoginException;
	
	/**
	 * 分页查询admin集合
	 */
	PageInfo<TAdmin> listAdminPage(Map<String, Object> paramMap);
	
	/**
	 * 保存TAdmin
	 */
	void saveTAdmin(TAdmin admin);
	
	/**
	 * 通过id查询TAdmin
	 * @return
	 */
	TAdmin getTAdminById(Integer id);
	
	/**
	 * 修改TAdmin
	 * @param admin
	 */
	void updateTAdmin(TAdmin admin);
	
	/**
	 * 根据主键删除TAdmin
	 * @param id
	 */
	void deleteByATdminId(Integer id);
	
	/**
	 * 批量删除
	 * @param ids
	 */
	void batchDeleteByATdminId(String ids);
}
