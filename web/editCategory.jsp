<%@include file="/WEB-INF/jsp/header.jsp" %>

<div id='errormsg' style='display: none'></div>

<c:if test="${param.id!=null}">
${conn.pushi(param.id)}
<c:set var="cat" value="${conn.selectOne('ws_get_category_info')}"/>
</c:if>


<div class="panel">
<input type="hidden" id="ni0" value="<c:out value="${param.id}"/>" />

${lang.get('name')}<br>
<input type="text" id="ns1" value="<c:out value="${cat['name']}"/>" />

<br>
<br>
${lang.get('email_comments')}<br>
<input type="text" id="ns2" value="<c:out value="${cat['email']}"/>" />

<br>
<br>
<button type="button" onclick="if (submit_form('n', 'ws_save_category')!=null) window.parent.xwindow2.close()" value="${lang.get('ok')}">${lang.get('ok')}</button>
</div>


<%@include file="/WEB-INF/jsp/fundoheader.jsp" %>
