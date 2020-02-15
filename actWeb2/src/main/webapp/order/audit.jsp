<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/28
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <style>
        b{
            font-size: 25px;
            font-family: 楷体;
        }
    </style>
</head>
<body>
<h1>采购单审核</h1>
<form action="${pageContext.request.contextPath}/submitAudit.do" method="post">
    <input type="hidden" name="orderId" value="${orderId}">
    <input type="hidden" name="auditType" value="${auditType}">
    <input type="hidden" name="taskId" value="${taskId}">
    <Table width="50%">
        <Tr>
            <td>采购单名称:</td><td><B style="color: red">${m.name}</B></td>
        </Tr>
        <Tr>
            <td>采购单金额:</td><td><B style="color: blue"><fmt:formatNumber type="currency" value="${m.price}"/></B></td>
        </Tr>
        <Tr>
            <td>采购单详情:</td><td><b>${m.content}</b></td>
        </Tr>
        <Tr>
            <td>经办人:</td><td><B style="color: red">${m.user_id}</B></td>
        </Tr>
        <Tr>
            <td>申请时间:</td><td><B>${m.createtime}</B></td>
        </Tr>
        <Tr>
            <td valign="top">审核意见:</td>
            <td><textarea cols="50" rows="5" name="auditInfo" placeholder="请输入审核意见"></textarea></td>
        </Tr>
        <Tr>
            <td>审核结果:</td>
            <td>
                <input type="radio" name="status" value="1" checked>同意
                <input type="radio" name="status" value="0" >不同意
            </td>
        </Tr>
        <Tr>
            <td colspan="2" align="center">
                <input type="submit" value="提交审核意见">
            </td>
        </Tr>
    </Table>
</form>

</body>
</html>
