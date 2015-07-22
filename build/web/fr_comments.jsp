<%@include file="WEB-INF/jsp/header.jsp" %>
<script type="text/javascript">
    function delete_comm(id) {
        if (!confirm("${lang.get('ask_delete_comment')}"))
            return;
        
        var xml = submit_form('_never_', 'ws_delete_comment', 'i0='+id);
        
        if (xml) {
            document.location.href = "fr_comments.jsp?id=${param.id}";
        }
    }
    
    function add_comm() {
        var xml = submit_form('n', 'ws_add_comment');
        
        if (xml!=null) {
            document.location.href = "fr_comments.jsp?id=${param.id}";
        }
    }
</script>
<div id="errormsg" style="display: none"></div>

    <form action="#" method="post">
        ${lang.get('add_comment')}<br>
        <input type="text" id="ns1" />
        <input type="hidden" id="ni0" value="${param.id}"/>
        <button type="submit" value="${lang.get('ok')}" onclick="add_comm(); return false;" >${lang.get('ok')}</button>
    </form>
    
<br>

<table class="data">
    <tr>
        <th>${lang.get('user')}</th>
        <th>${lang.get('date')}</th>
        <th>${lang.get('comment')}</th>
        <th>${lang.get('delete')}</th>
    </tr>
    ${conn.pushi(param.id)}
    <c:forEach var="row" items="${conn.select('ws_get_comments')}">
        <tr>
            <td>${row['name_user']}</td>
            <td>${row['date']}</td>
            <td>${row['msg']}</td>
            <c:if test="${row['level_priviledge']>=3}">
                <td><a href="javascript:delete_comm(${row['id']})"><img src="images/edit-delete.png" class="icon"/></a></td>
            </c:if>
            <c:if test="${row['level_priviledge']<3}">
                <td>&nbsp;</td>
            </c:if>
        </tr>
    </c:forEach>
</table>
    
<%@include file="WEB-INF/jsp/fundoheader.jsp" %>