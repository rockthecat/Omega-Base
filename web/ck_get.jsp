<%@include file="WEB-INF/jsp/header.jsp"%>

<div>
${conn.pushi(param.iddoc)}		
${conn.push('ck')}
<c:forEach var="row" items="${conn.select('ws_get_attachs')}">
    <div class="rotulo">

        <a href="javascript:save('<c:out value="${row['name']}"/>');" >
            <img src='userfiles/${param.iddoc}/ck/<c:out value="${row['name']}"/>' class='imgchoose' />
        </a>

        <a href='#' onclick='query_delete(${row['id']}); return false;'>
        <img src='images/edit-delete.png' class='icon' title="${lang.get('title_delete_image')}" />
        </a>

     </div>
</c:forEach>
<div class="rotuloclear">&nbsp;</div>
</div>

<script  type="text/javascript" >
     function save(url) {
	window.opener.CKEDITOR.tools.callFunction("${param.CKEditorFuncNum}", "${pageContext.servletContext.contextPath}/userfiles/${param.iddoc}/ck/"+url);
        window.close();
}

function query_delete(id) {
	if (window.confirm("${lang.get('ask_delete_image')}")) {
        	var xml = call_sp('ws_del_attach', 'i0='+id);
                
                if (xml!=null) {
                    document.location.href = document.location.href;
                }
        }
}

     </script>
     
     
   <form action="callspmultipart" enctype="multipart/form-data" method="POST">
       <input type="hidden" name="func" value="ws_save_attach" />
       <input type="hidden" name="i0" value="${param.iddoc}"/>
       <input type="file" name="bl1" accept="image/*" onchange="form.submit()"/>
        <input type="hidden" name="s2" value="ck" />
        <input type="hidden" name="CKEditorFuncNum" value="${param.CKEditorFuncNum}" />
        </form>
   
        <%@include file="WEB-INF/jsp/fundoheader.jsp" %>
      
	
      