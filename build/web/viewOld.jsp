<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/header.jsp" %>   
<div id="errormsg" style="display:none"></div>

<c:if test="${param.id!=null}">
    ${conn.pushi(param.id)}
    ${conn.pushi(1)}
    <c:set var="row" value="${conn.selectOne('ws_get_old_document')}"/>
</c:if>
 
    
    <div class="rotulobig">
        <button type='button' onclick="document.location.href='${header['referer']}';">${lang.get('back')}</button>
    </div>
      <br>
      <br>
      
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
      <c:forTokens var="att" items="${row['atts']}" delims="|">
          <c:if test="${fn:split(att, ';')[1]=='file'}">
              <div class="rotulo">
                 <a target="_blank" href="userfiles/o${param.id}/file/<c:url value="${fn:split(att, ';')[2]}"/>">
                 <img class='icon' src='images/files/${fn:split(att, ';')[0]}'/><br>
                 <c:out value="${fn:split(att, ';')[2]}"/></a>
              </div>
              </c:if>
       </c:forTokens>
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
      <br>
      <br>
   
      
      
      
    <div class="rotulobig">
        <button type='button' onclick="document.location.href='${header['referer']}';">${lang.get('back')}</button>
    </div>
      
      <script type="text/javascript">
          var texto = document.getElementById('texto');
          
          if (texto!=null) {
              texto.innerHTML = texto.innerHTML.replace(/\n/g, '<br>');
          }
          </script>
          
      
      <%@include file="WEB-INF/jsp/fundoheader.jsp" %>