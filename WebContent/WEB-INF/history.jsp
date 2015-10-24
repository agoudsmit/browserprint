<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%-- These comments are to prevent excess whitespace in the output.
--%><%@page session="false"%><%--
--%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%--
--%><jsp:useBean id="historyListBean" class="beans.HistoryListBean" scope="request" /><%--
--%><jsp:useBean id="chrsBean" class="beans.CharacteristicsBean" scope="request" /><%--
--%><jsp:useBean id="uniquenessBean" class="beans.UniquenessBean" scope="request" /><%--
--%><%@taglib prefix="common" tagdir="/WEB-INF/tags"%><%--
--%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Browserprint</title>
	<link type="text/css" href="style.css" rel="stylesheet">
	<script type="text/javascript" src="scripts/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="scripts/jquery-dateFormat.min.js"></script>
</head>
<body>
<%@include file="header.html" %>
	<p>
		View past browser fingerprints.
	</p>
	<c:if test="${ !requestScope.cookiesEnabled }"><p>
		To keep track of your history you need cookies enabled.
	</p></c:if>
	<form action="history" method="get">
		<select name="sampleID" id="historySelector">
			<c:forEach var="history" items="${ historyListBean.history }"><option value="${ history.sampleID }">${ history.timestamp }</option></c:forEach>
		</select>
		<script type="text/javascript">
		$('#historySelector > option').each(function() {
			var regex = /^(\d+)\/(\d+)\/(\d+), (\d+):(\d+):(\d+) UTC$/;
			var match = regex.exec($(this).text());
			var newDate = new Date(Date.UTC(match[3], match[2], match[1], match[4], match[5], match[6], 0));
			$(this).text($.format.date(newDate, 'dd/MM/yyyy, HH:mm:ss'));
		});
		</script>
		<input type="submit" value="View"/>
		<input type="submit" value="Compare to"/>
	</form>
<common:displayFingerprint uniquenessBean="${ uniquenessBean }" chrsBean="${ chrsBean }"/>
<%@include file="footer.jsp" %>
</body>
</html>