   <%@include file="WEB-INF/jsp/header.jsp" %>
   
   <table class="data" >
      <tr>
          <th>${lang.get('date')}</th>
          <th>${lang.get('addr')}</th>
          <th>${lang.get('action')}</th>
          <th>${lang.get('user')}</th>
</tr>
${conn.pushi(param.id)}
${conn.pushb(true)}

<c:forEach var="row" items="${conn.select('ws_get_historic')}">
    <tr>
        <td>${row['date']}</td>
        <td>${row['addr']}</td>
        <td>
            <a href="viewOld.jsp?id=${row['id']}">${lang.get('view')}</a>
            <a href="editDocumentOld.jsp?id=${row['id']}">${lang.get('edit')}</a>
            &nbsp; ${row['action']}
        </td>
        <c:if test="${row['id_user']!=null}">
            <td><a class="blue" href="restrict/editUser.jsp?id=${row['id_user']}"><c:out value="${row['name_user']}"/></a></td>
        </c:if>
        <c:if test="${row['id_user']==null}">
            <td>&nbsp;</td>
        </c:if>
    </tr>
</c:forEach>

      </table>
   
<%@include file="WEB-INF/jsp/fundoheader.jsp" %>    