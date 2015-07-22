<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/header.jsp" %>   

<c:if test="${param.id!=null}">
    ${conn.pushi(param.id)}
    ${conn.pushi(1)}
    <c:set var="row" value="${conn.selectOne('ws_get_document')}"/>
</c:if>
  <script type="text/javascript">
  
    </script>
    
   
      <div class="panel">
          <strong>${lang.get('name')}</strong><br>
          <c:out value="${row['name']}"/><br>
      
      </div>
      
      
      <div class="panel">
          <strong>${lang.get('category')}</strong><br>
      ${row['category_name']}
      </div>
      
          <div class="panelend">&nbsp;</div>

      ${conn.pushi(param.id)}
      ${conn.push('file')}
      <c:forEach var="att" items="${conn.select('ws_get_attachs')}">
          <div class="rotulo">
              <a href="userfiles/${param.id}/file/<c:url value="${att['name']}"/>" target="_blank">
                  <img class="icon" src="images/files/${att['icon']}"/><br>
                  ${att['name']}
              </a>
          </div>
      </c:forEach>
      <div class="rotuloclear">&nbsp;</div>
      <br>
      <br>
         
          
      ${lang.get('text')}<br>
      <c:if test="${row['isrichtext']!='t'}" >
      <div id="texto"><c:out value="${row['texthtml']}" /></div>
      </c:if>
      <c:if test="${row['isrichtext']=='t'}" >
      <div>${row['texthtml']}</div>
      </c:if>
   
      
      
      
    <script type="text/javascript">
          var texto = document.getElementById('texto');
          
          if (texto!=null) {
              texto.innerHTML = texto.innerHTML.replace(/\n/g, '<br>');
          }
          </script>
          
      
          <%@include file="WEB-INF/jsp/fundoheader.jsp" %>