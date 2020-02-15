<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/22
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">

</head>
<body>
<Table width="100%" align="center">
    <Tr>
        <Th>序号</Th>
        <Th>流程定义ID</Th>
        <Th>流程定义KEY</Th>
        <Th>版本</Th>
        <Th>BPMN</Th>
        <Th>PNG</Th>
        <Th>删除</Th>
    </Tr>
    <c:forEach items="${requestScope.list}" var="k" varStatus="st">
        <Tr align="center">
            <Td>${st.count}</Td>
            <Td>${k.id}</Td>
            <Td>${k.key}</Td>
            <Td>${k.version}</Td>
            <Td>
                <a target="_blank" href="${pageContext.request.contextPath}/showResources/${k.deploymentId}/${k.resourceName}.do">查看BPMN</a>
            </Td>
            <Td>
                <a target="_blank" href="${pageContext.request.contextPath}/showResources/${k.deploymentId}/${k.diagramResourceName}.do">查看PNG</a>
            </Td>
            <Td><a href="${pageContext.request.contextPath}/del/${k.deploymentId}.do">删除</a></Td>
        </Tr>
    </c:forEach>
</Table>
</body>
</html>
