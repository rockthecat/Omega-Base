<%@include file="/WEB-INF/jsp/top.jsp" %>

<c:set var="usr" value="${conn.selectOne('ws_get_my_info')}"/>

<script type="text/javascript">
    function save() {
        var xml = submit_form('n', 'ws_save_my_info');
        
        if (xml!=null) {
            alert("${lang.get('data_saved')}");
        }
    }
</script>

<form action="#" method="POST" class="panel">

${lang.get('your_name')}<br>
<input type="text" id="ns0" value="<c:out value="${usr['name']}"/>" />
<br>
<br>

${lang.get('old_password')}<br>
<input type="password" id="ns1" />
<br>
<br>

${lang.get('new_password')}<br>        
<input type="password" id="ns2" />
<br>
<br>

${lang.get('new_password2')}<br>                
<input type="password" id="ns3" />
<br>
${lang.get('password_blank')}<br>
<br>
<br>

<input type="button" onclick="save()" class="btn" value="${lang.get('ok')}" />        
    </form>
    <div class="panelend">&nbsp;</div>

<%@include file="/WEB-INF/jsp/fundo.jsp" %>      