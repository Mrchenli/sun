<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/26
  Time: 20:47
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
<body style="margin: 0px">
<H1>正在运行中的流程实例</H1>
<Table width="100%" align="center">
    <Tr>
        <th>序号</th>
        <th>采购单名称</th>
        <th>采购单金额</th>
        <th>采购单详情</th>
        <th>经办人</th>
        <th>创建时间</th>
        <th>当前任务阶段</th>
        <th>流程实例id</th>
        <th>历史任务</th>
        <th>查看流程图</th>
        <Th>删除流程实例</Th>
    </Tr>
    <c:forEach items="${requestScope.list}" var="m" varStatus="st">
        <Tr align="center">
            <TD>${st.count}</TD>
            <TD>${m.name}</TD>
            <TD><fmt:formatNumber type="currency" value="${m.price}"/></TD>
            <TD>${m.content}</TD>
            <TD>${m.user_id}</TD>
            <TD>${m.createtime}</TD>
            <TD>
                <c:choose>
                    <c:when test="${m.actDef=='createOrder'}">
                        <b style="color: red">提交采购单</b>
                    </c:when>
                    <c:when test="${m.actDef=='firstAudit'}">
                        <b style="color: red">部门经理审核</b>
                    </c:when>
                    <c:when test="${m.actDef=='secondAudit'}">
                        <b style="color: red">校长审核</b>
                    </c:when>
                    <c:when test="${m.actDef=='thirdAudit'}">
                        <b style="color: red"> 财务审核</b>
                    </c:when>
                </c:choose>
            </TD>
            <TD>${m.processInstanceId}</TD>
            <TD>
                <a href="${pageContext.request.contextPath}/showHistoryTask/${m.processInstanceId}.do">历史任务</a>
            </TD>
            <TD>
                <a href="${pageContext.request.contextPath}/showActiveMap/${m.processInstanceId}.do">流程图</a>
            </TD>
            <TD>
                <a href="${pageContext.request.contextPath}/delProcessInstance/${m.processInstanceId}.do">删除</a>
            </TD>
        </Tr>
    </c:forEach>
</Table>
</body>
</html>
