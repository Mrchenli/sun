<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/22
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>部署流程定义</h1>
<form action="${pageContext.request.contextPath}/deploy.do" method="post" enctype="multipart/form-data">
    BPMN:<Input type="file" name="bpmn"><Br>
    png:<Input type="file" name="png"><Br>
    <input type="submit" value="上传">
</form>
</body>
</html>

