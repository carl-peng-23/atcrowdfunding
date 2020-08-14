package com.atecut.atcrowdfunding.exception;

// 继承RuntimeExceptino，原因：业务层事务回滚，spring声明事务默认只对RuntimeException进行回滚
public class LoginException extends RuntimeException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public LoginException() {
		
	}

	public LoginException(String message) {
		super(message);
	}
	
}
