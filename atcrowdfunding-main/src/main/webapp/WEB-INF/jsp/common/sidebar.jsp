<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-sm-3 col-md-2 sidebar">
    <div class="tree">
        <ul style="padding-left:0px;" class="list-group">
            <c:forEach items="${menuList }" var="parent">
                <c:if test="${empty parent.children }">
                    <li class="list-group-item tree-closed" >
                        <a href="${parent.url }"><i class="${parent.icon }"></i> ${parent.name }</a> 
                    </li>
                </c:if>
                <c:if test="${not empty parent.children }">
                    <li class="list-group-item tree-closed">
                        <span><i class="${parent.icon }"></i> ${parent.name } <span class="badge" style="float:right">${parent.children.size() }</span></span> 
                        <ul style="margin-top:10px;display:none;">
                            <c:forEach items="${parent.children }" var="children">
	                            <li style="height:30px;">
	                                <a href="${children.url }"><i class="${children.icon }"></i> ${children.name }</a> 
	                            </li>
	                        </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
</div>
