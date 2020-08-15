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
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <ul style="padding-left:0px;" class="list-group">
                    <li class="list-group-item tree-closed" >
                        <a href="main.html"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a> 
                    </li>
                    <li class="list-group-item">
                        <span><i class="glyphicon glyphicon glyphicon-tasks"></i> 权限管理 <span class="badge" style="float:right">3</span></span> 
                        <ul style="margin-top:10px;">
                            <li style="height:30px;">
                                <a href="user.html" style="color:red;"><i class="glyphicon glyphicon-user"></i> 用户维护</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="role.html"><i class="glyphicon glyphicon-certificate"></i> 角色维护</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="permission.html"><i class="glyphicon glyphicon-lock"></i> 许可维护</a> 
                            </li>
                        </ul>
                    </li>
                    <li class="list-group-item tree-closed">
                        <span><i class="glyphicon glyphicon-ok"></i> 业务审核 <span class="badge" style="float:right">3</span></span> 
                        <ul style="margin-top:10px;display:none;">
                            <li style="height:30px;">
                                <a href="auth_cert.html"><i class="glyphicon glyphicon-check"></i> 实名认证审核</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="auth_adv.html"><i class="glyphicon glyphicon-check"></i> 广告审核</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="auth_project.html"><i class="glyphicon glyphicon-check"></i> 项目审核</a> 
                            </li>
                        </ul>
                    </li>
                    <li class="list-group-item tree-closed">
                        <span><i class="glyphicon glyphicon-th-large"></i> 业务管理 <span class="badge" style="float:right">7</span></span> 
                        <ul style="margin-top:10px;display:none;">
                            <li style="height:30px;">
                                <a href="cert.html"><i class="glyphicon glyphicon-picture"></i> 资质维护</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="type.html"><i class="glyphicon glyphicon-equalizer"></i> 分类管理</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="process.html"><i class="glyphicon glyphicon-random"></i> 流程管理</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="advertisement.html"><i class="glyphicon glyphicon-hdd"></i> 广告管理</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="message.html"><i class="glyphicon glyphicon-comment"></i> 消息模板</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="project_type.html"><i class="glyphicon glyphicon-list"></i> 项目分类</a> 
                            </li>
                            <li style="height:30px;">
                                <a href="tag.html"><i class="glyphicon glyphicon-tags"></i> 项目标签</a> 
                            </li>
                        </ul>
                    </li>
                    <li class="list-group-item tree-closed" >
                        <a href="param.html"><i class="glyphicon glyphicon-list-alt"></i> 参数管理</a> 
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <ol class="breadcrumb">
                  <li><a href="#">首页</a></li>
                  <li><a href="#">数据列表</a></li>
                  <li class="active">新增</li>
                </ol>
            <div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
              <div class="panel-body">
                <form action="admin/doUpdate" method="post" id="updateForm">
                  <input type="hidden" name="id" value="${admin.id }">
                  <input type="hidden" name="pageNum" value="${param.pageNum }">
                  <div class="form-group">
                    <label for="exampleInputPassword1">登陆账号</label>
                    <input type="text" class="form-control" id="exampleInputPassword1" name="loginacct" placeholder="请输入登陆账号" value="${admin.loginacct }">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">用户名称</label>
                    <input type="text" class="form-control" id="exampleInputPassword1" name="username" placeholder="请输入用户名称" value="${admin.username }">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">邮箱地址</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" name="email" placeholder="请输入邮箱地址" value="${admin.email }">
                    <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                  </div>
                  <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
                  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                </form>
              </div>
            </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title" id="myModalLabel">帮助</h4>
          </div>
          <div class="modal-body">
            <div class="bs-callout bs-callout-info">
                <h4>测试标题1</h4>
                <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
              </div>
            <div class="bs-callout bs-callout-info">
                <h4>测试标题2</h4>
                <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
              </div>
          </div>
          <!--
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Save changes</button>
          </div>
          -->
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
            
            $("#updateBtn").click(function(){
                $("#updateForm").submit();
            });

            $("#resetBtn").click(function(){
                $(".form-control").val("");
            });
        </script>
  </body>
</html>
