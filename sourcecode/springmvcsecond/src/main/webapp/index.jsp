<%--
  @User: Tekin   @Date: 2018/5/13  @Time: 23:05
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>SpringMVC test</title>
</head>

<body>
<ul>
    <li><a href="<%=basePath %>items/testItems.action">test Items</a></li>
</ul>

</body>
</html>