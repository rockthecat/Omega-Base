<%@include file="WEB-INF/jsp/header.jsp" %>
<div id="errormsg" style="display: none"></div>
<c:if test="${param.id!=null}">
${conn.pushi(-1)}
${conn.pushi(param.id)}
<c:set var="usr" value="${conn.selectOne('ws_get_managed_user_info')}"/>
</c:if>
<br>
<div class="panel">
<input type="hidden" id="ni0" value="${param.id}" />
${lang.get('name')}<br>
<input type="text" id="ns1" value="<c:out value="${usr['name']}"/>"/>
<br>
<br>

${lang.get('login')}<br>
<input type="text" id="ns2" value="<c:out value="${usr['login']}"/>"/>
<br>
<br>

${lang.get('group')}<br>
<select id='ni3'>
    <c:forEach var="grp" items="${conn.select('ws_get_managed_groups')}">
        <option value="${grp['id']}" ${grp['id']==usr['id_group'] ? 'selected' : ''} ><c:out value="${grp['name']}"/></option>
    </c:forEach>
</select>
<br>
<br>


${lang.get('new_password')}<br>
<input type='password' id='ns4' value='' />
<br>
<br>


${lang.get('new_password2')}<br>
<input type='password' id='ns5' value='' />
<br>
<br>
${param.id!=null ? lang.get('password_blank') : ''}<br>
<br>
<button type="button" onclick="if (submit_form('n', 'ws_save_managed_user')!=null) window.parent.xwindow2.close()" value="${lang.get('ok')}" >${lang.get('ok')}</button>

</div>

<div class="panelend">&nbsp;</div>


   