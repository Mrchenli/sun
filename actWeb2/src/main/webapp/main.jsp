<%--
  Created by IntelliJ IDEA.
  User: 23625
  Date: 2019/12/21
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>欢迎</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery-easyui-1.2.6/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery-easyui-1.2.6/themes/icon.css">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.2.6/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.2.6/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
<table width="100%" height="100%">
    <tr height="100px">
        <td colspan="2">
            ${sessionScope.uname}
            <A href="${pageContext.request.contextPath}/logout.do">退出</A>
        </td>
    </tr>
    <tr align="center">
        <td valign="top" width="15%" height="100%">
            <div class="easyui-accordion" animate="true" title="菜单" fit="true">
                <div iconCls="icon-add" title="部署管理" style="padding:5px">
                    <a href="${pageContext.request.contextPath}/flow/deploy.jsp" target="right">部署流程定义</a>
                    <br>
                    <a href="${pageContext.request.contextPath}/showProcessDefinition.do" target="right">查看流程定义</a>
                </div>
                <div iconCls="icon-search" title="流程监控" style="padding:5px">
                    <a href="${pageContext.request.contextPath}/showProcessInstance.do" target="right">查询正在执行流程实例</a>
                </div>
                <div iconCls="icon-edit" title="采购管理" selected="true" style="padding:5px">
                    <a href="${pageContext.request.contextPath}/order/createOrder.jsp" target="right">创建采购单</a>
                    <br>
                    <a href="${pageContext.request.contextPath}/queryPersonTask.do" target="right">办理任务</a>
                    <br>
                    <a href="${pageContext.request.contextPath}/showGroupTask.do" target="right">拾取任务</a>
                </div>
            </div>
        </td>
        <td>
            <iframe name="right" src="flow/right.jsp" style="width: 100%;height: 100%" frameborder="0"></iframe>
        </td>
    </tr>
</table>
</body>
</html>
