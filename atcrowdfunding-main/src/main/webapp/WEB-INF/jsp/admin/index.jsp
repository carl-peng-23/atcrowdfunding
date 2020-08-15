<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh_CN">
  <head>
    <base href="<%=basePath %>">
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
    table tbody tr:nth-child(odd){background:#F4F4F4;}
    table tbody td:nth-child(even){color:#C00;}
    </style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div> 
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
                <div class="btn-group">
                  <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                    <i class="glyphicon glyphicon-user"></i> 张三 <span class="caret"></span>
                  </button>
                      <ul class="dropdown-menu" role="menu">
                        <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                        <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                        <li class="divider"></li>
                        <li><a href="index.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                      </ul>
                </div>
            </li>
            <li style="margin-left:10px;padding-top:8px;">
                <button type="button" class="btn btn-default btn-danger">
                  <span class="glyphicon glyphicon-question-sign"></span> 帮助
                </button>
            </li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
              </div>
              <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='admin/toAdd'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th width="30"><input type="checkbox"></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${page.list }" var="admin" varStatus="status">
	                <tr>
	                  <td>${status.count}</td>
	                  <td><input type="checkbox"></td>
	                  <td>${admin.loginacct }</td>
	                  <td>${admin.username }</td>
	                  <td>${admin.email }</td>
	                  <td>
	                      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
	                      <button type="button" class="btn btn-primary btn-xs" onclick="window.location.href='admin/toUpdate?pageNum=${page.pageNum }&id=${admin.id}'"><i class=" glyphicon glyphicon-pencil" ></i></button>
	                      <button type="button" adminId="${admin.id }" class="deleteBtnClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
<%-- 	                      <button type="button" class="btn btn-danger btn-xs" onclick="window.location.href='admin/doDelete?pageNum=${page.pageNum }&id=${admin.id}'"><i class=" glyphicon glyphicon-remove"></i></button> --%>
	                  </td>
	                </tr>
	            </c:forEach>
              </tbody>
              <tfoot>
                 <tr>
                     <td colspan="6" align="center">
                        <ul class="pagination">
                            <c:if test="${!page.isFirstPage }">
                                <li><a href="admin/index?pageNum=${page.prePage }">上一页</a></li>
                            </c:if>
                            <c:if test="${page.isFirstPage }">
                                <li class="disabled"><a>上一页</a></li>
                            </c:if>
                              <c:forEach items="${page.navigatepageNums }" var="num">
                                <c:if test="${num == page.pageNum }">
                                    <li class="active"><a href="admin/index?pageNum=${num }">${num }<span class="sr-only">(current)</span></a></li>
                                </c:if>
                                <c:if test="${num != page.pageNum }">
                                    <li><a href="admin/index?pageNum=${num }">${num }</a></li>
                                </c:if>   
                              </c:forEach>
                            <c:if test="${page.isLastPage }">
                                <li class="disabled"><a>下一页</a></li>
                            </c:if>
                            <c:if test="${!page.isLastPage }">
                                <li><a href="admin/index?pageNum=${page.nextPage }">下一页</a></li>
                            </c:if>
                         </ul>
                     </td>
                 </tr>

              </tfoot>
            </table>
          </div>
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
            
            $(".deleteBtnClass").click(function(){
                var id = $(this).attr("adminId");
                layer.confirm('确认删除',{btn:['确定','取消']},function(){
                    window.location.href="admin/doDelete?pageNum=${page.pageNum }&id=" + id;
                    layer.close;
                },function(){
                    layer.close;
                });
            });
        </script>
  </body>
</html>
