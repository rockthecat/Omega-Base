<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/top.jsp" %>

<c:set var="perm" value="${conn.selectOne('check_superuser')}" />
<c:set var="grps" value="${conn.select('ws_get_groups')}"/>

<script type="text/javascript">
    function setCanUse(c) {
        document.getElementById('ni1').disabled = !c;
    }
    
    function setCanInscribe(c) {
        document.getElementById('ni3').disabled = !c;
    }
    
    function save() {
        var xml = submit_form('n', 'ws_save_configuration');
        
        if (xml!=null) {
            alert("${lang.get('data_saved')}");
        }
    }

</script>
<form action="#" method="post">
    <div class="panel">
        
    <label>
    <input type="checkbox" class="radio" id="nb0" ${app.configuration['anonymous_can_use']=='t'?'checked':''} onclick="setCanUse(this.checked)" />
    ${lang.get('anon_can_write')}
    </label>
    
    
    <br>
     <label>
    <input type="checkbox" class="radio" id="nb2" ${app.configuration['anonymous_can_inscribe']=='t'?'checked':''} onclick="setCanInscribe(this.checked)" />
    ${lang.get('anon_can_inscribe')}
    </label>
    <br>
    <br>
    
    ${lang.get('anom_group')}<br>
    <select id="ni1">
        <c:forEach items="${grps}" var="grp">
            <option value="${grp['id']}" ${app.configuration['anonymous_group']==grp['id'] ? 'selected':''} ><c:out value="${grp['name']}"/></option>
        </c:forEach>
    </select>
    <br>
    ${lang.get('anom_inscribe_group')}<br>
    <select id="ni3">
        <c:forEach items="${grps}" var="grp">
            <option value="${grp['id']}" ${app.configuration['anonymous_inscribe_group']==grp['id'] ? 'selected':''} ><c:out value="${grp['name']}"/></option>
        </c:forEach>
    </select>
    
    </div>
    
    
    <div class="panel">
        ${lang.get('email_send_server')}<br>
        <input type="text" id="ns4" value="<c:out value="${app.configuration['smtp_server']}" />" />
        <br>
        <br>
        
        <label>
        <input type="radio" class="radio" value="no" name="ns5" id="ns5" ${app.configuration['smtp_crypto']!='ssl' and app.configuration['smtp_crypto']!='tls'?'checked':''} />
        ${lang.get('email_send_nocrypt')}
        </label>
        <br>
        <label>
        <input type="radio" class="radio" name="ns5" value="ssl" id="ns5" ${app.configuration['smtp_crypto']=='ssl'?'checked':''} />
        ${lang.get('email_send_ssl')}
        </label>
        <br>
        <label>
        <input type="radio" class="radio" name="ns5" value="tls" id="ns5" ${app.configuration['smtp_crypto']=='tls'?'checked':''} />
        ${lang.get('email_send_tls')}
        </label>
        
        <br>
        <br>
        
        ${lang.get('email_send_port')}<br>
        <input type="text" id="ni6" value="${app.configuration['smtp_port']}" />
        
        <br>
        <br>
        
        ${lang.get('email_send_user')}<br>
        <input type="text" id="ns7" value="${app.configuration['smtp_user']}" />
        
        <br>
        <br>
        
        ${lang.get('email_send_pass')}<br>
        <input type="password" id="ns8" value="${app.configuration['smtp_pass']}" />
    </div>
    
    <div class="panel">
        ${lang.get('max_size_att')}<br>
        <input type="text" id="ni9" value="${app.configuration['max_att_size']}" />
        <br>
        <br>
        <button type="button" onclick="save()" value="${lang.get('ok')}">${lang.get('ok')}</button>
    </div>
    
    <div class="panelend">&nbsp;</div>
</form>

<%@include file="WEB-INF/jsp/fundo.jsp" %>