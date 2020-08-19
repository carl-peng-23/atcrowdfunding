<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh_CN">
  <head>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/jsp/common/css.jsp" %>
    <link rel="stylesheet" href="static/css/doc.min.css">
    <style>
    .tree li {
        list-style-type: none;
        cursor:pointer;
    }
    </style>
  </head>

  <body>

    <jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>
    
    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <ol class="breadcrumb">
                  <li><a href="#">首页</a></li>
                  <li><a href="#">数据列表</a></li>
                  <li class="active">新增</li>
                </ol>
            <div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
              <div class="panel-body">
                <form action="admin/doAdd" method="post" id="addForm">
                  <div class="form-group">
                    <label for="exampleInputPassword1">登陆账号</label>
                    <input type="text" class="form-control" id="exampleInputPassword1" name="loginacct" placeholder="请输入登陆账号">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">用户名称</label>
                    <input type="text" class="form-control" id="exampleInputPassword1" name="username" placeholder="请输入用户名称">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">邮箱地址</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" name="email" placeholder="请输入邮箱地址">
                    <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                  </div>
                  <button id="saveBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                </form>
              </div>
            </div>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/jsp/common/js.jsp" %>
        <script type="text/javascript">
            $(function () {
                $(".list-group-item").click(function(){
                    if ( $(this).find("ul") ) {
                        $(this).toggleClass("tree-closed");
                        if ( $(this).hasClass("tree-closed") ) {
                            $("ul", this).hide("fast");
                        } else {
                            $("ul", this).show("fast");
                        }
                    }
                });
            });
            
            $("#saveBtn").click(function(){
                $("#addForm").submit();
            });

            $("#resetBtn").click(function(){
                $(".form-control").val("");
            });
        </script>
  </body>
</html>
