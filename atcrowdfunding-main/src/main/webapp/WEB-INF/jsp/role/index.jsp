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

    <jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>
    
<div id="updateModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改角色</h4>
        <input type="hidden" id="updateId">
        <input type="text" class="form-control" id="roleName" 
                    name="roleName" autofocus>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="updateRole" type="button" class="btn btn-primary">修改</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="saveModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">添加角色</h4>
        <input type="text" class="form-control" id="saveRoleName" 
                    name="roleName" autofocus>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="saveRoleBtn" type="button" class="btn btn-primary">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- -----------------------------------分配权限模态框---------------------------------------------------- -->
<div id="assignPermissionModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">给角色分配权限</h4>
             <div class="zTreeDemoBackground left">
                 <ul id="treeDemo" class="ztree"></ul>
             </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="assignPermissionBtn" type="button" class="btn btn-primary">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

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
      <input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="likeQuery" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" id="saveRole" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th width="30"><input type="checkbox"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
                            
              </tbody>
              <tfoot>
                 <tr >
                     <td colspan="6" align="center">
                         <ul class="pagination">
                                
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
                
                initData(1);
            });
            
            $("tbody .btn-success").click(function(){
                window.location.href = "assignPermission.html";
            });
            
            var json = {
                    pageNum:1,
                    pageSize:2
                };
            
            $("#likeQuery").click(function(){
                json.condition = $("#condition").val();
                initData(1);
            });
            
            //=========================修改功能=============================
            $("tbody").on("click",".update",function(){
                // 获得要修改的id
                var id = $(this).attr("roleId");
                // 模态框
                $('#updateModal').modal({
                    show:true,
                    backdrop:false
                });
                $.ajax({
                    // 获取要修改的角色的信息
                    type:"get",
                    url:"role/getRole",
                    data:{id:id},
                    success:function(role) {
                        //设置隐藏域id，方便后面修改
                        $("#updateId").val(id);
                        // 回显
                        $("#roleName").val(role.name);
                    }
                });
            });
            
            $("#updateRole").click(function(){
	               $.ajax({
	                   type:"POST",
	                   url:"role/updateRole",
	                   data:{id:$("#updateId").val(),name:$("#roleName").val()},
	                   success:function(result) {
	                       if(result == "ok") {
	                           layer.msg('修改成功!', {icon: 1, time: 1000});  
	                           initData(json.pageNum);
	                       }else {
	                           layer.msg('修改失败!', {icon: 2, time: 1000});
	                       }
	                       $("#roleName").val("");
	                       $('#updateModal').modal('hide');
	                   }
	               });
            });
            
            //-------------------------修改功能over-----------------------------
            
            //=========================添加功能start=============================
            $("#saveRole").click(function(){
                $('#saveModal').modal({
                    show:true,
                    backdrop:false
                });
            });
            $("#saveRoleBtn").click(function(){
                   $.ajax({
                       type:"POST",
                       url:"role/saveRole",
                       data:{name:$("#saveRoleName").val()},
                       success:function(result) {
                           if(result == "ok") {
                               layer.msg('添加成功!', {icon: 1, time: 1000});  
                               initData(1);
                           }else {
                               layer.msg('添加失败!', {icon: 2, time: 1000});
                           }
                           $("#saveRoleName").val("");
                           $('#saveModal').modal('hide');
                       }
                   });
            });
            
            //-------------------------添加功能over-----------------------------

            //=========================删除功能start=============================
            
            $("tbody").on("click",".delete",function(){
                var id = $(this).attr("roleId");
                layer.confirm("确定删除吗", {icon: 3, title:'提示'},function(index) {
                    var i = -1;
                    $.ajax({
                    type:"POST",
                    url:"role/deleteRole",
                    data:{id:id},
                    beforeSend:function() {
                        i = layer.load(0, {time:10*1000});
                        return true;
                    },
                    success:function(result) {
                        layer.close(i);
                        if(result == "ok"){
                            layer.msg("删除成功", {icon : 1, time : 500});
                            initData(json.pageNum);
                        }else {
                            layer.msg("删除失败", {icon : 2, time : 500});
                        }
                    }
                });
                    layer.close(index);
                }, function(index) {
                    layer.msg("已取消", {icon : 0, time : 500});
                    layer.close(index);
                });
            });
            
            //-------------------------删除功能over-----------------------------
            
            //=========================给角色分配权限 功能start=============================
            var roleId;
            $("tbody").on("click",".assignPermission",function(){
                roleId = $(this).attr("roleId");
                //弹出模态框
                 $("#assignPermissionModal").modal({
                    show : true
                });
                initPermissionTree();
            });
            
            $("#assignPermissionBtn").click(function() {
                //获得角色id，以及复选框对应的权限id
                var json = {roleId : roleId};
                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                var nodes = treeObj.getCheckedNodes(true);
                var flag = false;
                $.each(nodes, function(i, node) {
                    json['ids[' + i + ']'] = node.id;
                    if(node.checked == true)
                       flag = true;
                });
                
                if(flag == false) {
                    $.ajax({
                    type : "POST",
                    url : "role/deleteRolePernissionRelationship",
                    data : {roleId, roleId},
                    success : function(result) {
                        if(result == "ok") {
                            $("#assignPermissionModal").modal('hide');
                            layer.msg('分配成功!', {icon: 6, time: 1000});
                        }else {
                            layer.msg('分配失败!', {icon: 5, time: 1000});
                        }
                    }
                });
                    return false;
                }
                
                                
                //发起异步请求插入t_role_permission角色权限表
                $.ajax({
                    type : "POST",
                    url : "role/saveRolePernissionRelationship",
                    data : json,
                    success : function(result) {
                        if(result == "ok") {
                            $("#assignPermissionModal").modal('hide');
                            layer.msg('分配成功!', {icon: 6, time: 1000});
                        }else {
                            layer.msg('分配失败!', {icon: 5, time: 1000});
                        }
                    }
                });
            });
            
            
            
            function initPermissionTree() {
                var setting = {
                    data: {
                        simpleData: {
                            enable: true,
                            pIdKey: "pid",
                        },
                        key: {
                            name: "title"
                        }
                    },
                    check: {
                        enable: true
                    },
                    view:{
                        addDiyDom: function(treeId, treeNode) {
                            $("#" + treeNode.tId + "_ico").removeClass();
                            $("#" + treeNode.tId + "_span").before("<span class='" + treeNode.icon +"'></span>");
                        }
                    }
                };

                $.get("permission/getPermissionTree",function(result){
                    var zNodes = result;
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    treeObj.expandAll(true);
                    
                    $.ajax({
                        type : "GET",
                        url : "role/getRolePermissionId",
                        data : {roleId : roleId},
                        success : function(result) {
                            //给复选框回显
                            $.each(result, function(i, e) {
                                var permissionId = e ;
                                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                                var node = treeObj.getNodeByParam("id", permissionId, null);
                                treeObj.checkNode(node, true, false , false);
                            });
                        }
                    });
                });
            }
            
            //-------------------------给角色分配权限 功能over-----------------------------

            //===================================================================
            
            function initData(pageNum){
                json.pageNum = pageNum;
                var index = -1;
                $.ajax({
                    type:"POST",
                    url:"role/loadData",
                    data:json,
                    beforeSend:function() {
                        index = layer.load(0, {time:10*1000});
                        return true;
                    },
                    success:function(result) {
                        layer.close(index);
                        initShow(result);
                        initNav(result);
                    }
                });
            }
           
            function initShow(result){
                var content = "";
                $(result.list).each(function(i, e) {
                    content += '<tr>';
	                content += '  <td>' + (i + 1) + '</td>';
	                content += '  <td><input type="checkbox"></td>';
	                content += '  <td>' + e.name + '</td>';
	                content += '  <td>';
	                content += '      <button type="button" roleId="' + e.id +'" class="assignPermission btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
	                content += '      <button type="button" roleId="' + e.id +'" class="update btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
	                content += '      <button type="button" roleId="' + e.id + '" class="delete btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
	                content += '  </td>';
	                content += '</tr>';
                });
                $("tbody").html(content);
            }
            
            function initNav(result) {
                var ul = $(".pagination");
                ul.html("");
                if(result.isFirstPage) {
                    ul.append("<li class='disabled'><a>上一页</a></li>");
                }else {
                    ul.append("<li><a onclick='initData(" + result.prePage +")'>上一页</a></li>");
                }
                $(result.navigatepageNums).each(function(i, e) {
                    if(e == result.pageNum) {
                        ul.append("<li class='active'><a onclick='initData(" + e +")'>" + e + "<span class='sr-only'>(current)</span></a></li>");
                    } else {
                        ul.append("<li><a onclick='initData(" + e +")'>" + e + "</a></li>");
                    }
                });
                if(result.isLastPage) {
                    ul.append("<li class='disabled'><a>下一页</a></li>");
                }else {
                    ul.append("<li><a onclick='initData(" + result.nextPage +")'>下一页</a></li>");
                }
            }
        </script>
  </body>
</html>
