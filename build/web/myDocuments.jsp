<%@include file="WEB-INF/jsp/top.jsp" %>

<c:if test="${ses.idUser==0}">
    <c:redirect url="error.jsp"/>
</c:if>

<form action="myDocuments.jsp" method="POST" >
    <div class="panel">
        ${lang.get('search')}<br>
        <input type="text" name="txt" value="<c:out value="${param.txt}"/>" />
    </div>
        
        <div class="panel">
            <br>
            <button type="submit" value="${lang.get('ok')}" >${lang.get('ok')}</button>
        </div>
        
        <div class="panelend"></div>
        <br>
        <button type='button' onclick="xwindow2.open('${lang.get('new_document')}', '<iframe class=\'total\' src=\'editDocument.jsp\'></iframe>')" >${lang.get('new_document')}</button>
        <button type='button' onclick='delSelected()' >${lang.get('del_selected')}</button>
        
</form>
            ${conn.push(param.txt)}
            ${conn.pushi(0)}
            ${conn.push('R')}
            ${conn.pushi(0)}
            ${conn.pushi(0)}
            <br> 
            
<script type="text/javascript">
    function delSelected() {
        if (window.confirm("${lang.get('ask_delete_docs')}")) {
            var docs = document.getElementsByName('odel');
            
            var str = '';
            
            for(var i = 0;i<docs.length;i++) {
                if (!docs[i].checked)
                    continue;
                
                if (str=='') {
                    str = docs[i].value;
                } else {
                    str += '|'+docs[i].value;
                }
            }    
            
            call_sp('ws_del_many_documents', 's0='+str);
            document.location.href = document.location.href;
        }
    }
    
    function open2(id, name) {
        var html = "<div class='total'>"+
                   "<div id='tabid' class='rotulobig'></div>"+
                   "<div id='clientid' ></div>"+
                   "</div>";
                   
        var tabs = new Array();
        var urls = new Array();
                        
        tabs.push("${lang.get('view')}");
        urls.push('view.jsp?id='+id);
        
        tabs.push('${lang.get('edit')}');
        urls.push('editDocument.jsp?id='+id);
                            
        tabs.push('${lang.get('historic')}');
        urls.push('viewHistoric.jsp?id='+id);                            
                        
        xwindow2.open(name, html);
                        var tabs = new TabsH('clientid', 'tabid',
                        tabs,
                        urls,
                        getHeight()-90);
    }
</script>
<table class="data">
    <tr>
        <th class="chk">${lang.get('delete')}</th>
        <th>${lang.get('name')}</th>
        <th>${lang.get('attachments')}</th>
    </tr>
    <c:forEach var="doc" items="${conn.select('ws_search')}">
        <tr>
            <td><input class="radio" type="checkbox"  name="odel" value="${doc['id']}"/></td>
            <td><a href="javascript:void(0)" onclick="open2(${doc['id']}, '<c:out value="${doc['name']}"/>')" ><c:out value="${doc['name']}"/></a>
            <c:if test="${doc['foundtxt']=='t'}">
               <img src="images/dialog-ok-apply.png" class="small"/>
            </c:if>
            </td>
            <td>
                <c:forTokens items="${doc['attachs']}" delims="|" var="at" >
                    <c:set var="ats" value="${fn:split(at, ';')}"/>
                    <div class="rotulo">
                        <a href="userfiles/${doc['id']}/file/<c:out value="${ats[3]}"/>" target="_blank" >
                        <img src="images/files/${ats[1]}" class="icon"/> 
                        <c:if test="${ats[2]=='true'}">
                            <img src="images/dialog-ok-apply.png" class="small"/>
                        </c:if>
                        <br>${ats[3]}
                        </a>
                    </div>
                         
                </c:forTokens>
            </td>
        </tr>
    </c:forEach>
</table>  
        
  <%@include file="WEB-INF/jsp/fundo.jsp" %>