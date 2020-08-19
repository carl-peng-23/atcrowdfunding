<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/jsp/common/css.jsp" %>
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
                  <li class="active">分配角色</li>
                </ol>
            <div class="panel panel-default">
              <div class="panel-body">
                <form role="form" class="form-inline">
                  <div class="form-group">
                    <label for="exampleInputPassword1">未分配角色列表</label><br>
                    <select id="unassignedRole" class="form-control" multiple size="10" style="width:250px;overflow-y:auto;">
                        <c:forEach items="${assignedAndUnssignedRole.unassigned }" var="unassigned">
                            <option value="${unassigned.id }">${unassigned.name }</option>
                        </c:forEach>
                    </select>
                  </div>
                  <div class="form-group">
                        <ul>
                            <li id="leftToRight" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                            <br>
                            <li id="rightToleft" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
                  </div>
                  <div class="form-group" style="margin-left:40px;">
                    <label for="exampleInputPassword1">已分配角色列表</label><br>
                    <select id="assignedRole" class="form-control" multiple size="10" style="width:250px;overflow-y:auto;">
                       <c:forEach items="${assignedAndUnssignedRole.assigned }" var="assigned">
                            <option value="${assigned.id }">${assigned.name }</option>
                        </c:forEach>
                    </select>
                  </div>
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
            
            $("#leftToRight").click(function() {
                //把用户id和角色id拼串
                var str = 'adminId=' + ${param.id};
                $("#unassignedRole option:selected").each(function(i, e) {
                    str = str + '&roleId=' + e.value; 
                });
                if($("#unassignedRole option:selected").length == 0) {
                    layer.msg("请加入角色!", {icon : 6, time : 1000});
                    return false;
                }
                //发送到后端
                $.ajax({
                    type : "POST",
                    url : "admin/saveAdminAndRoleRelationship",
                    data : str,
                    success : function(result) {
                        if(result == "ok") {
                            layer.msg("分配角色成功!", {icon : 1, time : 1000}, function() {
                                $("#assignedRole").append($("#unassignedRole option:selected").clone());
                                $("#unassignedRole option:selected").remove();
                            });
                        }else {
                            layer.msg("分配角色失败!", {icon : 2, time : 1000});
                        }
                    }
                });
            });
            $("#rightToleft").click(function() {
                //把用户id和角色id拼串
                var str = 'adminId=' + ${param.id};
                $("#assignedRole option:selected").each(function(i, e) {
                    str = str + '&roleId=' + e.value; 
                });
                if($("#assignedRole option:selected").length == 0) {
                    layer.msg("请选择角色!", {icon : 6, time : 1000});
                    return false;
                }
                //发送到后端
                $.ajax({
                    type : "POST",
                    url : "admin/deleteAdminAndRoleRelationship",
                    data : str,
                    success : function(result) {
                        if(result == "ok") {
                            layer.msg("删除角色成功!", {icon : 1, time : 1000}, function() {
                                $("#unassignedRole").append($("#assignedRole option:selected").clone());
                                $("#assignedRole option:selected").remove();
                            });
                        }else {
                            layer.msg("删除角色失败!", {icon : 2, time : 1000});
                        }
                    }
                });
            });
        </script>
  </body>
</html>

