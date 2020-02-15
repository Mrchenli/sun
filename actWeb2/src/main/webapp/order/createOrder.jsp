<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/26
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        b{
            font-family: 楷体;
            font-size: 25px;
        }
    </style>
</head>
<body>
<h1>创建采购单</h1>
    <form action="${pageContext.request.contextPath}/createOrder.do" method="post">
        <B>采购单名称:</B><input type="text" name="name" placeholder="请输入采购单名称"/><Br>
        <B>采购单金额:</B><input type="text" name="price"  placeholder="请输入采购单金额"/><Br>
        <b>采购单详情:</b><TEXTAREA name="content" cols="50" rows="5" placeholder="请输入采购详情"></TEXTAREA><Br>
        <input type="submit" value="创建采购单"/>
    </form>
</body>
</html>
