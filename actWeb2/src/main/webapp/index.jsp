<%@page isELIgnored="false" contentType="text/html;charset=utf-8" language="java" %>
<html>
<head>
    <title>欢迎页面</title>
</head>
<body>
<h1>用户登录</h1>
<form action="${pageContext.request.contextPath}/login.do" method="post">
    用户名：<input name="uname" type="text"><br>
    <input type="submit" value="登录">
</form>
</body>
</html>
