<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/header.jsp" %>   
<div id="errormsg" style="display: none"></div>
 <script src="${pageContext.servletContext.contextPath}/ckeditor/ckeditor.js"></script>
<c:if test="${param.id!=null}">
    ${conn.pushi(param.id)}
    ${conn.pushi(2)}
    <c:set var="row" value="${conn.selectOne('ws_get_document')}"/>
</c:if>
<c:if test="${param.id==null}">
    <c:set var="row" value="${conn.selectOne('make_empty_document')}"/>
</c:if>

  <script type="text/javascript">
    function input_submit(status, del) {
    
    var xml = submit_form('n', 'ws_save_document', 's5='+status+'&b6='+del);
    
    if (xml!=null) {
        var t = window.top;
        
        t.xwindow2.close();
    }
        
   return false;

}

   function toggleCK() {
       if (document.getElementById('nb1').checked) {
           CKEDITOR.replace( 'ns2', 
           {
           filebrowserImageBrowseUrl: '${pageContext.servletContext.contextPath}/ck_get.jsp?iddoc=${row['id']}',
           //filebrowserImageUploadUrl: '/uploader/upload.php',
           filebrowserWindowWidth: '640',
           filebroserWindowHeight: '480'
           });
       } else {
           CKEDITOR.instances['ns2'].destroy();
       }
   }
		
    </script>
    
    
    
  <form action="#"  id="form_login" enctype="application/x-www-form-urlencoded" method="POST">
      <div class="rotulobig">
      <c:if test="${row['status']!='E'}">
          <button type='button' onclick="input_submit(' ', ''); return false;">${lang.get('save')}</button>
      
      </c:if>
      <c:if test="${row['status']!='N'}">
          <button type=button' onclick="input_submit('N', ''); return false;">${lang.get('save_and_unpublish')}</button>
      </c:if>
      <c:if test="${row['status']!='P' and row['level_priviledge']=='3'}">
          <button type='button'  onclick="input_submit('P', ''); return false;">${lang.get('save_and_publish')}</button>
      </c:if>
      <c:if test="${row['status']!='R' and ses.idUser!=0}">
          <button type='button'  onclick="input_submit('R', ''); return false;">${lang.get('copy_to_mydocs')}</button>
      </c:if>
      <c:if test="${row['id']!='E'}">
          <button type='button'  onclick="if (confirm('${lang.get('ask_delete_document')}')) {input_submit('P', 't');} return false;" >${lang.get('delete')}</button>
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
   
      
      ${lang.get('attach_file')}<br>
      <iframe src="fr_attach.jsp?id=${row['id']}" class="file" ></iframe>
      <br>
      <br>
      
            <div class="rotulobig">
      <c:if test="${row['status']!='E'}">
          <button type='button' onclick="input_submit(' ', ''); return false;">${lang.get('save')}</button>
      
      </c:if>
      <c:if test="${row['status']!='N'}">
          <button type=button' onclick="input_submit('N', ''); return false;">${lang.get('save_and_unpublish')}</button>
      </c:if>
      <c:if test="${row['status']!='P' and row['level_priviledge']=='3'}">
          <button type='button'  onclick="input_submit('P', ''); return false;">${lang.get('save_and_publish')}</button>
      </c:if>
      <c:if test="${row['status']!='R' and ses.idUser!=0}">
          <button type='button'  onclick="input_submit('R', ''); return false;">${lang.get('copy_to_mydocs')}</button>
      </c:if>
      <c:if test="${row['id']!='E'}">
          <button type='button'  onclick="if (confirm('${lang.get('ask_delete_document')}')) {input_submit('P', 't');} return false;" >${lang.get('delete')}</button>
      </c:if></div>
<div class="rotuloclear">&nbsp;</div>
      
      </form>
   
      <c:if test="${row['isrichtext']=='t'}">
          <script type="text/javascript">
              toggleCK();
              </script>
      </c:if>
      <%@include file="WEB-INF/jsp/fundoheader.jsp" %>