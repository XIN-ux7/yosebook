<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>main</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8">

<link rel="stylesheet" type="text/css"
    href="<c:url value='/jsps/css/main.css'/>">
</head>

<body>
    <table class="table" align="center" style="border-radius: 3px;">
        <tr class="trTop">
            <td colspan="2" class="tdTop">
                <iframe frameborder="0"
                    src="<c:url value='/jsps/top.jsp'/>" name="top"></iframe>
            </td>
        </tr>
        <tr>
            <td class="tdLeft" rowspan="2"><iframe frameborder="0"
                    src="<c:url value='/category/findAll.do'/>" name="left"></iframe>
            </td>
            <td class="tdSearch" style="border-bottom-width: 0px;">
                <iframe frameborder="0"
                    src="<c:url value='/jsps/search.jsp'/>"
                    name="search"></iframe>
            </td>
        </tr>
        <tr>
            <td style="border-top-width: 0px;"><iframe
                    frameborder="0"
                    src="<c:url value='/jsps/body.jsp'/>" name="body"></iframe>
            </td>
        </tr>
        <tr><td colspan="2" align="center">@我的个人图书商城</td></tr>
    </table>
</body>
</html>
