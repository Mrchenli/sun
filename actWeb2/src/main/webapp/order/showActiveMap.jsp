<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/28
  Time: 11:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body style="margin: 0px">
<img style="position: absolute" src="${pageContext.request.contextPath}/showResources/${deploymentId}/${png}.do">
<div style="position: absolute;border-radius: 13px;border: 5px red solid;top:${y}px;left:${x}px;width:${width-6}px;height:${height-6}px;"></div>
</body>
</html>
