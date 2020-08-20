package com.atecut.atcrowdfunding.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

@EnableGlobalMethodSecurity(prePostEnabled = true)
@EnableWebSecurity
@Configuration
public class AtcrowdFundingSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	UserDetailsService userDetailsService;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		
		auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());
	}

	/**
	 * 1、自定义请求授权访问规则
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/static/**", "/welcome.jsp").permitAll().anyRequest().authenticated();
		
		http.formLogin().loginPage("/login").loginProcessingUrl("/doLogin").usernameParameter("loginacct").passwordParameter("userpswd")
			.defaultSuccessUrl("/main").permitAll();
		
		http.logout().logoutSuccessUrl("/index");
		
		http.csrf().disable();
		
		http.rememberMe();
		
		http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
			
			@Override
			public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException)
					throws IOException, ServletException {
				String type = request.getHeader("X-Requested-With");
				
				if("XMLHttpRequest".equals(type)) {
					response.getWriter().print("403");
				}else {
					request.getRequestDispatcher("/WEB-INF/jsp/error/error403.jsp").forward(request, response);
				}
			}
		});
		
	}
}
