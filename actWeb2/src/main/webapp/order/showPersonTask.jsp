<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/26
  Time: 14:34
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
    <Table width="100%" align="center">
        <Tr>
            <Th>序号</Th>
            <Th>采购单名称</Th>
            <Th>采购单金额</Th>
            <Th>采购单详情</Th>
            <Th>经办人</Th>
            <Th>创建时间</Th>
            <Th>任务名称</Th>
            <Th>任务负责人</Th>
            <Th>处理采购单</Th>
        </Tr>
        <c:forEach items="${requestScope.list}" var="m" varStatus="st">
            <tr>
                <td>${st.count}</td>
                <td>${m.name}</td>
                <td><fmt:formatNumber type="currency" value="${m.price}" /></td>
                <td>${m.content}</td>
                <td>${m.user_id}</td>
                <td><fmt:formatDate value="${m.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td><b style="color: red">${m.taskName}</b></td>
                <td>${m.assignee}</td>
                <td>
                    <c:choose>
                        <c:when test="${m.taskDef=='createOrder'}">
                            <a href="${pageContext.request.contextPath}/complete/${m.taskId}.do">提交采购单</a>
                        </c:when>
                        <c:when test="${m.taskDef=='firstAudit'}">
                            <a href="${pageContext.request.contextPath}/audit/${m.id}/${m.taskDef}/${m.taskId}.do">部门经理审核</a>
                        </c:when>
                        <c:when test="${m.taskDef=='secondAudit'}">
                            <a href="${pageContext.request.contextPath}/audit/${m.id}/${m.taskDef}/${m.taskId}.do">校长审核</a>
                        </c:when>
                        <c:when test="${m.taskDef=='thirdAudit'}">
                            <a href="${pageContext.request.contextPath}/audit/${m.id}/${m.taskDef}/${m.taskId}.do">财务审核</a>
                        </c:when>
                        <c:when test="${m.taskDef=='settlement'}">
                            <a href="${pageContext.request.contextPath}/settlement/${m.taskId}.do">财务结算</a>
                        </c:when>
                        <c:when test="${m.taskDef=='storage'}">
                            <a href="${pageContext.request.contextPath}/storage/${m.taskId}.do">采购入库</a>
                        </c:when>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </Table>
</body>
</html>
