<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/29
  Time: 20:51
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
<h1>可拾取任务列表</h1>
<Table width="100%" align="center">
    <Tr>
        <Th>序号</Th>
        <Th>采购单名称</Th>
        <Th>采购单金额</Th>
        <Th>采购单详情</Th>
        <Th>经办人</Th>
        <Th>创建时间</Th>
        <Th>任务名称</Th>
        <Th>处理采购单</Th>
    </Tr>
    <c:forEach items="${requestScope.list}" var="m" varStatus="st">
        <Tr align="center">
            <Td>${st.count}</Td>
            <Td>${m.name}</Td>
            <Td>
                <fmt:formatNumber type="currency" value="${m.price}"/>
            </Td>
            <Td>${m.content}</Td>
            <Td>${m.user_id}</Td>
            <Td>
                <fmt:formatDate value="${m.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </Td>
            <Td><B style="color: red">${m.taskName}</B></Td>
            <Td>
                <A href="${pageContext.request.contextPath}/claimTask/${m.taskId}.do">拾取任务</A>
            </Td>
        </Tr>
    </c:forEach>
</Table>
</body>
</html>
