package com.atecut.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atecut.atcrowdfunding.bean.TAdmin;
import com.atecut.atcrowdfunding.bean.TRole;
import com.atecut.atcrowdfunding.service.TAdminService;
import com.atecut.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class TAdminController {
	
	Logger log = LoggerFactory.getLogger(TAdminController.class);
	
	@Autowired
	TAdminService adminService;
	@Autowired
	TRoleService roleService;
	
	@RequestMapping("/admin/index")
	public String index(@RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum,
						@RequestParam(value = "pageSize", required = false, defaultValue = "2") Integer pageSize, 
						@RequestParam(value = "condition", required = false, defaultValue = "") String condition, 
						Model model) {
		
		PageHelper.startPage(pageNum, pageSize); // 线程绑定
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("condition", condition);
		PageInfo<TAdmin> page = adminService.listAdminPage(paramMap);
		model.addAttribute("page", page);
		return "admin/index";
	}
	
	@RequestMapping("/admin/toAdd")
	public String toAdd() {
		return "admin/add";
	}
	
	@PreAuthorize("hasRole('PM - 项目经理')")
	@RequestMapping("/admin/doAdd")
	public String doAdd(TAdmin admin) {
		adminService.saveTAdmin(admin);
		return "redirect:/admin/index";
	}
	
	@RequestMapping("/admin/toUpdate")
	public String toUpdate(Integer id, Model model) {
		TAdmin admin = adminService.getTAdminById(id);
		model.addAttribute("admin", admin);
		return "admin/update";
	}

	@RequestMapping("/admin/doUpdate")
	public String toUpdate(TAdmin admin, String pageNum) {
		adminService.updateTAdmin(admin);
		return "redirect:/admin/index?pageNum=" + pageNum;
	}

	@RequestMapping("/admin/doDelete")
	public String toUpdate(Integer id, String pageNum) {
		adminService.deleteByATdminId(id);
		return "redirect:/admin/index?pageNum=" + pageNum;
	}

	@RequestMapping("/admin/batchDelete")
	public String batchDelete(String ids, String pageNum) {
		log.debug("ids={}", ids);
		log.debug("pageNum={}", pageNum);
		adminService.batchDeleteByATdminId(ids);
		return "redirect:/admin/index?pageNum=" + pageNum;
	}

	@RequestMapping("/admin/assignRole")
	public String assignRole(Integer id, Model model) {
		log.debug("id={}", id);
		Map<String,List<TRole>> map = roleService.getAssignedAndUnssignedRole(id);
		model.addAttribute("assignedAndUnssignedRole",map);
		return "/admin/assignRole";
	}
	
	@ResponseBody
	@RequestMapping("/admin/saveAdminAndRoleRelationship")
	public String saveAdminAndRoleRelationship(Integer adminId, Integer[] roleId) {
		roleService.saveAdminAndRoleRelationship(adminId, roleId);
		return "ok";
	}

	@ResponseBody
	@RequestMapping("/admin/deleteAdminAndRoleRelationship")
	public String deleteAdminAndRoleRelationship(Integer adminId, Integer[] roleId) {
		roleService.deleteAdminAndRoleRelationship(adminId, roleId);
		return "ok";
	}
}
