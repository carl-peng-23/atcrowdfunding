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
<!--     添加菜单的模态框 -->
<div class="modal fade" tabindex="-1" role="dialog" id="saveModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">添加菜单</h4>
      </div>
      <input type="hidden" id="pid">
      <div>
          <label for="name">菜单名称</label>
          <input type="text" class="form-control" id="name" name="name" placeholder="请输入菜单名称">
      </div>
      <div>
          <label for="icon">图标</label>
          <input type="text" class="form-control" id="icon" name="icon" placeholder="请输入icon">
      </div>
      <div>
          <label for="url">地址</label>
          <input type="text" class="form-control" id="url" name="url" placeholder="请输入url">
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" id="saveBtn" class="btn btn-primary">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!--     修改菜单的模态框 -->
<div class="modal fade" tabindex="-1" role="dialog" id="updateModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改菜单</h4>
      </div>
      <input type="hidden" id="update-id">
      <div>
          <label for="name">菜单名称</label>
          <input type="text" class="form-control" id="update-name" name="name">
      </div>
      <div>
          <label for="icon">图标</label>
          <input type="text" class="form-control" id="update-icon" name="icon">
      </div>
      <div>
          <label for="name">地址</label>
          <input type="url" class="form-control" id="update-url" name="url">
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" id="updateBtn" class="btn btn-primary">修改</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

    <jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"></jsp:include>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 菜单列表</h3>
              </div>
              
              <div class="zTreeDemoBackground left">
                   <ul id="treeDemo" class="ztree"></ul>
              </div>
    
              <div class="panel-body">
 <hr style="clear:both;">
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
            
            initMenuTree();
            
            function initMenuTree() {
                var setting = {
		            data: {
		                simpleData: {
		                    enable: true,
		                    pIdKey: "pid",
                            rootPId: 0
		                }
		            },
		            view:{
				        addDiyDom: function(treeId, treeNode) {
				            $("#" + treeNode.tId + "_ico").removeClass();
				            $("#" + treeNode.tId + "_span").before("<span class='" + treeNode.icon +"'></span>");
				        },
				        addHoverDom: function(treeId, treeNode){  
                            var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                            aObj.removeAttr("href");
                            if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                            var s = '<span id="btnGroup'+treeNode.tId+'">';
                            if ( treeNode.level == 0 ) {
                                s += '<a onclick="saveMenu(' + treeNode.id + ')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                            } else if ( treeNode.level == 1 ) {
                                s += '<a onclick="updateMenu(' + treeNode.id + ')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                                if (treeNode.children.length == 0) {
                                    s += '<a onclick="deleteMenu(' + treeNode.id + ')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                                }
                                s += '<a onclick="saveMenu(' + treeNode.id + ')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                            } else if ( treeNode.level == 2 ) {
                                s += '<a onclick="updateMenu(' + treeNode.id + ')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                                s += '<a onclick="deleteMenu(' + treeNode.id + ')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                            }
            
                            s += '</span>';
                            aObj.after(s);
                        },
                        removeHoverDom: function(treeId, treeNode){
                            $("#btnGroup"+treeNode.tId).remove();
                        }
				    }
		        };

		        $.get("menu/getMenuTree",function(result){
		            var zNodes = result;
		            zNodes.push({id: 0,name: "菜单列表", icon: "glyphicon glyphicon-triangle-bottom"});
		            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
		            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    treeObj.expandAll(true);
		        });
            }
            //=======================================添加 开始=============================================
            function saveMenu(pid) {
                $("#saveModal").modal({
                    show : true
                });
                
                $("#pid").val(pid);
            }
            
            $("#saveBtn").click(function() {
                    var pid = $("#pid").val();
                    var name = $("#name").val();
                    var icon = $("#icon").val();
                    var url = $("#url").val();
                    var index = -1;
                    $.ajax({
                        type : "POST",
                        url : "menu/saveMenu",
                        data : {pid : pid, name : name, icon : icon, url : url},
                        beforeSend : function() {
                            index = layer.load(0, {time:5*1000});
                            return true;
                        },
                        success : function(result) {
                            if(result == "ok") {
                                layer.msg("添加成功", {icon : 1, time : 500});
                                initMenuTree();
                            }else {
                                layer.msg("添加失败", {icon : 2, time : 500});
                            }
                            layer.close(index);
                            $("#saveModal").modal('hide');
                        }
                    });
                    $("#name").val("");
                    $("#icon").val("");
                    $("#url").val("");
                });
            //=======================================添加 结束=============================================
            
            
            //=======================================修改 开始=============================================
            function updateMenu(id) {
                //弹出模态框
                 $("#updateModal").modal({
                    show : true
                });
                //回显
                var index = -1;
                $.ajax({
                    type : "GET",
                    url : "menu/getMentById",
                    data : {id : id},
                    beforeSend : function() {
                            index = layer.load(0, {time:5*1000});
                            return true;
                        },
                    success : function(result) {
                        $("#update-id").val(result.id);
                        $("#update-name").val(result.name);
                        $("#update-icon").val(result.icon);
                        $("#update-url").val(result.url);
                    }
                });
                layer.close(index);
            }
            
            //点击修改按钮
            $("#updateBtn").click(function() {
                var index = -1;
                $.ajax({
                    type : "POST",
                    url : "menu/updateMenu",
                    data : {id : $("#update-id").val(), name : $("#update-name").val(), icon :  $("#update-icon").val(), url : $("#update-url").val()},
                    beforeSend : function() {
                            index = layer.load(0, {time:5*1000});
                            return true;
                        },
                    success : function(result) {
                        if(result == "ok") {
                                layer.msg("修改成功", {icon : 1, time : 500});
                                initMenuTree();
                            }else {
                                layer.msg("修改失败", {icon : 2, time : 500});
                            }
                    }
                });
                layer.close(index);
                $("#updateModal").modal("hide");
                initMenuTree();
            });
            //=======================================修改 结束=============================================
            
            //=======================================删除 开始=============================================
            function deleteMenu(id) {
                layer.confirm("确定删除吗", {icon: 3, title:'提示'},function(index) {
                    var i = -1;
                    $.ajax({
                    type:"POST",
                    url:"menu/deleteMenu",
                    data:{id:id},
                    beforeSend:function() {
                        i = layer.load(0, {time:10*1000});
                        return true;
                    },
                    success:function(result) {
                        layer.close(i);
                        if(result == "ok"){
                            layer.msg("删除成功", {icon : 1, time : 500});
                            initMenuTree();
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
            }
            //=======================================删除 结束=============================================
        </script>
  </body>
</html>
