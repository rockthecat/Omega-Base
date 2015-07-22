<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/header.jsp" %>   
<div id='errormsg' style="display: none"></div>
 <script src="${pageContext.servletContext.contextPath}/ckeditor/ckeditor.js"></script>
    ${conn.pushi(param.id)}
    ${conn.pushi(2)}
    <c:set var="row" value="${conn.selectOne('ws_get_old_document')}"/>
  <script type="text/javascript">
    function input_submit(status, del) {
    
    var xml = submit_form('n', 'ws_save_document', 's5='+status+'&b6='+del);
    
    if (xml!=null) {
       window.top.xwindow2.close();
   }
        
   return false;

}

   function toggleCK() {
       if (document.getElementById('nb1').checked) {
           CKEDITOR.replace( 'ns2', 
           {
           });
       } else {
           CKEDITOR.instances['ns2'].destroy();
       }
   }
		
    </script>
    
    
    
  <form action="#"  id="form_login" enctype="application/x-www-form-urlencoded" method="POST">
      <div class="rotulobig">
          <button type='button' onclick="document.location.href='${header['referer']}'">${lang.get('back')}</button>
          <button type="button" onclick="input_submit(' ', ''); return false;">${lang.get('save')}</button>
      <c:if test="${row['status']=='P' or row['status']==null or row['status']=='R'}">
          <button type="button" onclick="input_submit('N', ''); return false;">${lang.get('save_and_unpublish')}</button>
      </c:if>
      <c:if test="${((row['status']!='P' or row['status']==null) and row['level_priviledge']=='3')  or row['status']=='R'}">
          <button type='button'  onclick="input_submit('P', ''); return false;">${lang.get('save_and_publish')}</button>
      </c:if>
      <c:if test="${row['status']!='R'}">
          <button type='button' onclick="input_submit('R', ''); return false;">${lang.get('copy_to_mydocs')}</button>
      </c:if>
      </div>
      <div class="rotuloclear">&nbsp;</div>
      
      <div class="panel">
      
      ${lang.get('name')}<br>
      <input id="ns0" type="text" value="<c:out value="${row['name']}"/>" />
      
      </div>
      
      
      <div class="panel">
      ${lang.get('category')}<br>
      <select id="ni4" >
          <option value="0" >${lang.get('select_one')}</option>
          ${conn.pushb(false)}
          ${conn.pushi(2)}
          <c:forEach var="cat" items="${conn.select('get_categories')}">
              <option value="${cat['id']}" ${cat['id'] == row['id_category'] ? 'selected' : ''} ><c:out value="${cat['name']}"/></option>
          </c:forEach>
      </select>
      </div>
      
      <div class="panel">
          <br>
      <label>
      <input type="checkbox" id="nb1" class="radio" onclick="toggleCK()" ${row['isrichtext']=='t' ? 'checked' : ''} />
      ${lang.get('richtext')}</label>
      </div>
      
      
          <div class="panelend">&nbsp;</div>
      
      ${lang.get('text')}<br>
      <textarea id="ns2" class="txt"><c:out value="${row['texthtml']}"/></textarea>
      <br>
      <br>
      <input type="hidden" id="ni3" value="${row['id']!=null ? row['id'] : '0'}" />
   
      
      <div>
          <c:forTokens var="att" items="${row['atts']}" delims="|">
              <c:if test="${fn:split(att, ';')[1]=='file'}">
              <div class="rotulo">
                 <a target="_blank" href="userfiles/o${param.id}/file/${fn:split(att, ';')[2]}">
                 <img class='icon' src='images/files/${fn:split(att, ';')[0]}'/><br>
                 <c:url value="${fn:split(att, ';')[2]}"/></a>
              </div>
              </c:if>
           </c:forTokens>
          <div class="rotuloclear">&nbsp;</div>
      </div>
      
      
       <div class="rotulobig">
          <button type='button' onclick="document.location.href='${header['referer']}'">${lang.get('back')}</button>
          <button type="button" onclick="input_submit(' ', ''); return false;">${lang.get('save')}</button>
      <c:if test="${row['status']=='P' or row['status']==null or row['status']=='R'}">
          <button type="button" onclick="input_submit('N', ''); return false;">${lang.get('save_and_unpublish')}</button>
      </c:if>
      <c:if test="${((row['status']!='P' or row['status']==null) and row['level_priviledge']=='3')  or row['status']=='R'}">
          <button type='button'  onclick="input_submit('P', ''); return false;">${lang.get('save_and_publish')}</button>
      </c:if>
      <c:if test="${row['status']!='R'}">
          <button type='button' onclick="input_submit('R', ''); return false;">${lang.get('copy_to_mydocs')}</button>
      </c:if>
      </div>
      </form>
   
      <c:if test="${row['isrichtext']=='t'}">
          <script type="text/javascript">
              toggleCK();
              </script>
      </c:if>
      <%@include file="WEB-INF/jsp/fundoheader.jsp" %>