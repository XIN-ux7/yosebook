<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>top</title>
<base target="body">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
body {
	font-size: 14px;
	font-family: "microsoft yahei";
	background: #758a99;/*页面背景*/
	color: #e0eee8;/*页面文本*/
}

p {
	text-align: center;
	line-height: 30px;
	font-size: 30px;
	margin-top: 25px;
}

a {
	color: #e0eee8;
	margin-left: 6px;
	text-decoration: none;
}

a:hover {
	color: #bbcdc5;
}

.bodr_lf {
	border-left: 1px solid #bbb;
	border-right: 1px solid #bbb;
	padding-left: 10px;
	padding-right: 10px;
}
</style>
</head>

<body>
    <p>YW后台管理</p>
    <div style="line-height: 10px;">
        <span style="margin-left: 10px; color: #e0eee8;">管理员：${sessionAdmin.adminname }</span> <a
            target="_top" href="<c:url value='/admin/admin/quit.do'/>">退出</a>
        <span style="padding-left: 50px;"> <a
            href="<c:url value='/admin/category/findAll.do'/>">分类管理</a>
            <a class="bodr_lf"
            href="<c:url value='/adminjsps/admin/book/main.jsp'/>">图书管理</a>
            <a href="<c:url value='/admin/order/findAll.do'/>">订单管理</a>
        </span>
    </div>
</body>
</html>
