<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
<head>
<base href="<%=basePath %>">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="keys" content="">
<meta name="author" content="">
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<link rel="stylesheet" href="static/css/login.css">
<style>
</style>
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<div>
				<a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a>
			</div>
		</div>
	</div>
	</nav>

	<div class="container">

		<form id="loginForm" class="form-signin" role="form" action="doLogin"
			method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<h2 class="form-signin-heading">
			    <i class="glyphicon glyphicon-log-in"></i> 用户登录
			</h2>
			<c:if test="${!empty SPRING_SECURITY_LAST_EXCEPTION.message }">
			    <div class="form-group has-success has-feedback" style="color:red">${SPRING_SECURITY_LAST_EXCEPTION.message }</div>
			</c:if>
			<div class="form-group has-success has-feedback">
				<input type="text" class="form-control" id="loginacct" value="zhangsan" 
					name="loginacct" placeholder="请输入登录账号" autofocus>
					<span class="glyphicon glyphicon-user form-control-feedback"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<input type="password" class="form-control" id="userpswd"
					name="userpswd" placeholder="请输入登录密码" style="margin-top:10px;" value="123456">
				<span class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>

			<div class="checkbox">
				<label> <input type="checkbox" name="remember-me">
					记住我
				</label> <br> <label> 忘记密码 </label> <label style="float:right">
					<a href="reg.html">我要注册</a>
				</label>
			</div>
			<a class="btn btn-lg btn-success btn-block" onclick="dologin()">
				登录</a>
		</form>
	</div>
	<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
	<script>
		function dologin() {
			$("#loginForm").submit();
		}
	</script>
</body>
</html>
