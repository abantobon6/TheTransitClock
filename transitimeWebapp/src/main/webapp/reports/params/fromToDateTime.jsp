<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="" scope="session" />
<fmt:setLocale value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" />
<fmt:requestEncoding value = "UTF-8" />
<fmt:setBundle basename="org.transitclock.i18n.text" />
<%-- For specifying a begin date & time and an end date & time --%>

<link href="../javascript/air-datepicker/css/datepicker.css" rel="stylesheet" type="text/css">
<script src="../javascript/air-datepicker/js/datepicker.min.js"></script>

<!-- Include English language -->
<script src="../javascript/air-datepicker/js/i18n/datepicker.en.js"></script>


<!-- air-datepicker has a bug where need to set the following css style
     to prevent days in calendar from wrapping to next line when mouse
     is hovered over a date. -->
<style>
*, *::after, *::before {
    box-sizing: border-box;
}

/* Change color of dates between from date and to date so more visible */
.datepicker--cell.-in-range- {
    background: rgba(92, 196, 239, 0.5);
    }

/* Round the corners even more to emphasize that showing a date range */
.datepicker--cell.-range-from- {
	border-radius: 6px 0 0 6px;
}
.datepicker--cell.-range-to- {
	border-radius: 0 6px 6px 0;
}

</style>

<script>
$(function() {
  var calendarIconTooltip = "Popup calendar to select date";

  $( "#beginDate" ).datepicker({
	dateFormat: "mm-dd-yy",
    showOtherMonths: true,
    selectOtherMonths: true,
    // Show button for calendar
    buttonImage: "images/calendar.png",
    buttonImageOnly: true,
    showOn: "both",
    // Don't allow going past current date
    maxDate: 0,
    // onClose is for restricting end date to be after start date,
    // though it is potentially confusing to user
    onClose: function( selectedDate ) {
      $( "#endDate" ).datepicker( "option", "minDate", selectedDate );
      // Strangely need to set the title attribute for the icon again
      // so that don't revert back to a "..." tooltip
      $(".ui-datepicker-trigger").attr("title", calendarIconTooltip);
    }
  });
  $( "#endDate" ).datepicker({
	dateFormat: "mm-dd-yy",
    showOtherMonths: true,
    selectOtherMonths: true,
    // Show button for calendar
    buttonImage: "images/calendar.png",
    buttonImageOnly: true,
    showOn: "both",
    // Don't allow going past current date
    maxDate: 0,
    // onClose is for restricting end date to be after start date,
    // though it is potentially confusing to user
    onClose: function( selectedDate ) {
      $( "#beginDate" ).datepicker( "option", "maxDate", selectedDate );
      // Strangely need to set the title attribute for the icon again
      // so that don't revert back to a "..." tooltip
      $(".ui-datepicker-trigger").attr("title", calendarIconTooltip);
    }
  });

  // Use a better tooltip than the default "..." for the calendar icon
  $(".ui-datepicker-trigger").attr("title", calendarIconTooltip);
});
</script>

<%
String currentDateStr = org.transitime.utils.Time.dateStr(new java.util.Date());
%>

  <div class="param">
    <label for="beginDate"><fmt:message key="div.bd" /></label>
    <input type="text" id="beginDate" name="beginDate"
    	title="The first day of the range you want to examine data for.
    	<br><br> Begin date must be before the end date."
    	size="10"
    	value="<%= currentDateStr%>" />
  </div>

  <div class="param">
    <label for="endDate"><fmt:message key="div.ed" /></label>
    <input type="text" id="endDate" name="endDate"
    	title="The last date of the range you want to examine data for.
    	<br/><br/> End date must be after the begin date."
    	size="10"
    	value="<%= currentDateStr%>" />
  </div>

  <div class="param">
    <label for="beginTime"><fmt:message key="div.bt" /></label>
    <input id="beginTime" name="beginTime"
    	title="Optional begin time of day to limit query to. Useful if
    	    want to see result just for rush hour, for example. Leave blank
    		if want data for entire day.
    		<br/><br/>Format: hh:mm, as in '07:00' for 7AM."
    	size="3"
    	value="" /> <span class="note">(hh:mm)</span>
  </div>

  <div class="param">
    <label for="endTime"><fmt:message key="div.et" /></label>
    <input id="endTime" name="endTime"
    	title="Optional end time of day to limit query to. Useful if
    	    want to see result just for rush hour, for example. Leave blank
    		if want data for entire day.
    		<br/><br/>Format: hh:mm, as in '09:00' for 9AM.
    		Use '23:59' for midnight."
    	size="3"
    	value="" /> <span class="note">(hh:mm)</span>
  </div>
