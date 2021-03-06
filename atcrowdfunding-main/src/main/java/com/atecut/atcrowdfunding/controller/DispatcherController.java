package com.atecut.atcrowdfunding.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atecut.atcrowdfunding.bean.TMenu;
import com.atecut.atcrowdfunding.service.TAdminService;
import com.atecut.atcrowdfunding.service.TMenuService;

@Controller
public class DispatcherController {
	
	Logger log = LoggerFactory.getLogger(DispatcherController.class);
	
	@Autowired
	TAdminService adminService;
	
	@Autowired
	TMenuService menuService;

	@RequestMapping("/index")
	public String index() {
		log.debug("跳转到系统主页面");
		return "index";
	}

	@RequestMapping("/login")
	public String login() {
		log.debug("跳转到登录页面");
		return "login";
	}
	
//	@RequestMapping("/doLogin")
//	public String doLogin(String loginacct, String userpswd, HttpSession session, Model model) {
//		log.debug("开始登录");
//		log.debug("账号:{},密码:{}", loginacct, userpswd);
//		Map<String,Object> paramMap = new HashMap<String,Object>();
//		paramMap.put("loginacct", loginacct);
//		paramMap.put("userpswd", userpswd);
//		try {
//			TAdmin admin = adminService.getTAdminByLogin(paramMap);
//			session.setAttribute(Const.LOGIN_ADMIN, admin);
//			log.debug("登录成功");
//			List<TMenu> menuList = menuService.listMenuAll();
//			session.setAttribute("menuList", menuList);
//			return "redirect:/main";
//		} catch (Exception e) {
//			e.printStackTrace();
//			log.debug("登录失败={}", e.getMessage());
//			model.addAttribute("message", e.getMessage());
//			return "login";
//		}
//	}
	
	@RequestMapping("/main")
	public String main(HttpSession session) {
		log.debug("跳转到后台系统main页面");
		
		List<TMenu> menuList = menuService.listMenuAll();
		session.setAttribute("menuList", menuList);
		
		if(session.getAttribute("menuList") == null)
			return "redirect:/login";
		return "main";
	}
	
//	@RequestMapping("/logout")
//	public String logout(HttpSession session) {
//		log.debug("注销，跳转到主页");
//		if(session != null) {
//			session.removeAttribute(Const.LOGIN_ADMIN);
//			session.invalidate();
//		}
//		return "redirect:/index";
//	}
}
