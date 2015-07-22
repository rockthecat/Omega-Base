<%@include file="WEB-INF/jsp/header.jsp" %>

<script type="text/javascript">
    function del_attach(id) {
        if (confirm("${lang.get('ask_delete_attachment')}")) {
            var xml = call_sp("ws_del_attach", "i0="+id);
            
            if (xml!=null) {
                document.location.href = document.location.href;
            }
        }
    }
    </script>

<jsp:useBean id="icons" class="org.omegabase.indexer.OmegaViewer"/>

${conn.pushi(param.id)}
${conn.push('file')}
<div>
<c:forEach var="at" items="${conn.select('ws_get_attachs')}">
    <div class='rotulo'>
         <a href="javascript:del_attach(${at['id']})" class="small">
        <img src="images/edit-delete.png"/>
    </a>
        <a target="_blank" href="userfiles/${param.id}/file/<c:url value="${at['name']}"/>" >
            <img class='icon' src='${icons.viewIcon(at['name'], pageContext.servletContext.contextPath)}'/><br>
    <c:out value="${at['name']}" /></a>
    
   
    </div>
</c:forEach>
</div>
<div class='rotuloclear'>&nbsp;</div>
<form action="callspmultipart" method="post" enctype="multipart/form-data" accept-charset="UTF-8" >
    <input type="hidden" name="func" value="ws_save_attach" />
    <input type="hidden" name="i0" value="${param.id}" />
    <input type="hidden" name="s2" value="file" />
    <input type="file" name="bl1" onchange="form.submit()" /><br>
    ${lang.get('pdf_odf_indexed')}
</form>

    <%@include file="WEB-INF/jsp/fundoheader.jsp" %>