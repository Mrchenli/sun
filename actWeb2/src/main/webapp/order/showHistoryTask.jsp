<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/28
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<h1>历史任务</h1>
<Table width="100%" align="center">
    <Tr>
        <th>序号</th>
        <th>任务名称</th>
        <th>负责人</th>
        <th>任务开始时间</th>
        <th>任务结束时间</th>
    </Tr>
    <c:forEach items="${requestScope.list}" varStatus="st" var="m">
        <TR align="center">
            <TD>${st.count}</TD>
            <TD>${m.name}</TD>
            <TD>${m.assignee}</TD>
            <TD>
                <fmt:formatDate value="${m.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </TD>
            <TD>
                <fmt:formatDate value="${m.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </TD>
        </TR>
    </c:forEach>
</Table>
</body>
</html>
