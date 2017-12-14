<%@page import="org.transitime.db.webstructs.WebAgency"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" lang="${language}">
<%
String agencyId = request.getParameter("a");
if (agencyId == null || agencyId.isEmpty()) {
    response.getWriter().write("You must specify agency in query string (e.g. ?a=mbta)");
    return;
}
%>
<html>
<head>
  <%@include file="/template/includes.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title><fmt:message key="div.historical" /></title>
</head>
<body>
<%@include file="/template/header.jsp" %>
<div id="mainDiv">
<div id="title"><fmt:message key="div.hrf" /> <%= WebAgency.getCachedWebAgency(agencyId).getAgencyName() %></div>

<div id="subtitle"><fmt:message key="div.pa" /><br/><span style="font-size: small"><fmt:message key="div.ofa" /></span></div>
<ul class="choicesList">
  <li><a href="predAccuracyRangeParams.jsp?a=<%= agencyId %>"
    title="Shows percentage of predictions that were accurate
    to within the specified limits.">
      <fmt:message key="div.prediction" /></a></li>
  <li><a href="predAccuracyIntervalsParams.jsp?a=<%= agencyId %>"
    title="Shows average prediction accuracy for each prediction length. Also
hows upper and lower bounds. Allows one to see for a specified percentage
what the prediction accuracy is for predictions that lie between the
specified accuracy range.">
      <fmt:message key="div.predictionaccuracy" /></a></li>
  <li><a href="predAccuracyScatterParams.jsp?a=<%= agencyId %>"
    title="Shows each individual datapoint for prediction accuracy. Useful for
finding specific issues with predictions.">
      <fmt:message key="div.predictionscatter" /></a></li>
  <li><a href="predAccuracyCsvParams.jsp?a=<%= agencyId %>"
    title="For downloading prediction accuracy data in CSV format.">
      <fmt:message key="div.csv" /></a></li>
</ul>

<div id="subtitle"><fmt:message key="div.sar" /></div>
<ul class="choicesList">
  <li><a href="schAdhByRouteParams.jsp?a=<%= agencyId %>"
    title="Displays historic schedule adherence data by route in a bar chart.
    Can compare schedule adherence for multiple routes.">
      <fmt:message key="div.scheduleroutr" /></a></li>
  <li><a href="schAdhByStopParams.jsp?a=<%= agencyId %>"
    title="Displays schedule adherence by stop.">
      <fmt:message key="div.schedulebystop" /></a></li>
  <li><a href="schAdhByTimeParams.jsp?a=<%= agencyId %>"
    title="Displays historic schedule adherence data for a route grouped by
    how early/late. The resulting bell curve shows the distribution of
    early/late times. ">
      <fmt:message key="div.earlylate" /></a></li>
</ul>

<div id="subtitle"><fmt:message key="div.ar" /></div>
<ul class="choicesList">
  <li><a href="avlMapByRouteParams.jsp?a=<%= agencyId %>"
    title="Displays historic AVL data for a route in a map.">
      <fmt:message key="div.avldata" /></a></li>
  <li><a href="avlMapByVehicleParams.jsp?a=<%= agencyId %>"
    title="Displays historic AVL data for a vehicle in a map.">
      <fmt:message key="div.datainmap" /></a></li>
  <li><a href="lastAvlReport.jsp?a=<%= agencyId %>"
    title="Displays the last time each vehicle reported its GPS position over the last 24 hours.">
      <fmt:message key="div.lastgps" /></a></li>
</ul>

<div id="subtitle"><fmt:message key="div.mr" /></div>
<ul class="choicesList">
  <li><a href="scheduleHorizStopsParams.jsp?a=<%= agencyId %>"
    title="Displays in a table the schedule for a specified route.">
      <fmt:message key="div.schedulefor" /></a></li>
  <li><a href="scheduleVertStopsParams.jsp?a=<%= agencyId %>"
    title="Displays in a table the schedule for a specified route. Stops listed
    vertically which is useful for when there are not that many trips per day.">
      <fmt:message key="div.sfrvss" /></a></li>
</ul>
</div>
</body>
</html>
