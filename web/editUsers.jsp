<%@include file="WEB-INF/jsp/top.jsp" %>
<c:set var="users" value="${conn.select('ws_get_managed_users')}"/>
<br>
<script type="text/javascript">
    function del(id) {
        if (confirm("${lang.get('ask_delete_user')}")) {
            var xml = submit_form('n', 'ws_delete_editor', 'i0='+id);
            
            if (xml!=null) {
                document.location.href = document.location.href;
            }
        }
    }
</script>
<button type="button" onclick="xwindow2.openIframe('${lang.get('new_user')}', 'editUser.jsp')">${lang.get('new_user')}</button>
<br>
<br>
<table class="data">
    <tr>
        <th>${lang.get('user')}</th>
        <th>${lang.get('group')}</th>
        <th>${lang.get('delete')}</th>
    </tr>
    <c:forEach var="usr" items="${users}">
        <tr>
            <td><a href="javascript:void(0)" onclick="xwindow2.openIframe('<c:out value="${usr['name']}"/>', 'editUser.jsp?id=${usr['id']}')"/><c:out value="${usr['name']}"/></a></td>
            <td><c:out value="${usr['name_group']}"/></td>
            <td><a href="javascript:void(0)" onclick="del(${usr['id']})" ><img src="images/edit-delete.png"/></a></td>
        </tr>
    </c:forEach>    
</table>
 <%@include file="WEB-INF/jsp/fundo.jsp" %>
   
