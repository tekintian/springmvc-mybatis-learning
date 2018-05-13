<%--
  @User: Tekin   @Date: 2018/5/13  @Time: 22:47
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Title</title>
</head>

<body>
<c:forEach items="${myitems }" var="item">
    <tr>
        <td>${item.name }</td>
        <td>${item.price }</td>
        <td><fmt:formatDate value="${item.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        <td>${item.detail }</td>

        <td><img src="<%=basePath %>${item.pic }" alt="pic">
            
            <a href="${pageContext.request.contextPath }/item/editItem.action?id=${item.id}">修改</a></td>

        
    </tr>
</c:forEach>

</body>
</html>