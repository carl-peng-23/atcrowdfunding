package com.atecut.atcrowdfunding.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atecut.atcrowdfunding.bean.TMenu;
import com.atecut.atcrowdfunding.service.TMenuService;

@Controller
public class TMenuController {
	
	@Autowired
	TMenuService menuService;
	
	@RequestMapping("/menu/index")
	public String batchDelete() {
		return "menu/index";
	}
	
	@ResponseBody
	@RequestMapping("/menu/getMenuTree")
	public List<TMenu> getMenuTree() {
		List<TMenu> list = menuService.getMenuTree();
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/menu/saveMenu")
	public String saveMenu(TMenu menu) {
		menuService.saveMenu(menu);
		return "ok";
	}
	
	@ResponseBody
	@RequestMapping("/menu/updateMenu")
	public String updateMenu(TMenu menu) {
		menuService.updateMenu(menu);
		return "ok";
	}

	@ResponseBody
	@RequestMapping("/menu/deleteMenu")
	public String deleteMenu(@RequestParam(value = "id") Integer id) {
		menuService.deleteMenu(id);
		return "ok";
	}

	@ResponseBody
	@RequestMapping("/menu/getMentById")
	public TMenu getMentById(@RequestParam(value = "id") Integer id) {
		TMenu menu = menuService.getMenuById(id);
		return menu;
	}
}
