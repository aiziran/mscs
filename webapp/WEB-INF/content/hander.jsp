<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
 
    <title>登录</title>
   <%@ include file="/common/taglibs.jsp"%>
     <link rel="shortcut icon" href="${ctx}/bootstrap/docs-assets/ico/favicon.png">
    <link href="${ctx}/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/bootstrap/css/signin.css" rel="stylesheet">
    

  </head>

  <body>
    <div class="container">
      <form id="loginForm" class="form-signin" role="form" action='<c:url value="/hander/hander!hander.action"/>' >
        <h2 class="form-signin-heading">欢迎登录</h2>
        <input type="text" class="form-control" id="userId" name="j_username" placeholder="用户名" required autofocus>
        <input type="password" class="form-control"   id="userPassword" name="j_password" placeholder="密码" required>
       
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
      </form>

    </div> 
  </body>
</html>
