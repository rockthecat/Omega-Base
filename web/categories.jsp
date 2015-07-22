<%@include file="/WEB-INF/jsp/top.jsp" %>

<script type="text/javascript">
    function del_category(id) {
        if (confirm("${lang.get('ask_delete_category')}")) {
            var xml = submit_form('nn', 'ws_delete_category', 'i0='+id);
            
            if (xml!=null) {
                document.location.href = document.location.href;
            }
        }
            
    }
</script>

<button type="button" onclick="xwindow2.openIframe('${lang.get('new_category')}', 'editCategory.jsp')" value="${lang.get('new_category')}">${lang.get('new_category')}</button>

<br>
<br>
<table class="data">
    <tr>
        <th>${lang.get('category')}</th>
        <th>${lang.get('groups')}</th>
        <th>${lang.get('delete')}</th>
    </tr>
    
    <c:forEach var="cat" items="${conn.select('ws_get_categories2')}">
        <tr>
            <td><a href="javascript:void(0)" onclick="xwindow2.openIframe('<c:out value="${cat['name']}"/>', 'editCategory.jsp?id=${cat['id']}')"><c:out value="${cat['name']}"/></a></td>
            <td>${cat['groups']}</td>
            <td><a href="javascript:void(0)" onclick="del_category(${cat['id']})">
                    <img src="images/edit-delete.png" />
                </a>
            </td>
        </tr>
    </c:forEach>
</table>
       


<%@include file="/WEB-INF/jsp/fundo.jsp" %>
