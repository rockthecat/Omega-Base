<%@include file="WEB-INF/jsp/top.jsp" %>

<script type="text/javascript">
    function nsubmit() {
        var xmlhttp = submit_form('n', 'ws_auto_new_user');
        
        if (xmlhttp!=null) {
            document.location.href = 'index.jsp';
        }
    }
</script>
    
   

<form class="boxdialog" action="#" method="POST">
    <div class="titulo1">
        ${lang.get('new_account_disc')}
    </div>
    
    ${lang.get('new_login')}<br>
    <input type="text" name="login" id="ns0" />
    <br>
    <br>
    ${lang.get('new_user')}<br>
    <input type="text" name="user" id="ns1"/>
    <br>
    <br>
    ${lang.get('new_password')}<br>
    <input type="password" name="password" id="ns2"/>
    <br>
    <br>
    ${lang.get('new_password2')}<br>
    <input type="password" name="password2" id="ns3"/>
    <br>
    <br>
    
    <button type="submit" class="btn" value="${lang.get('ok')}" onclick="nsubmit(); return false;" >${lang.get('ok')}</button>
    
</form>


<%@include file="WEB-INF/jsp/fundo.jsp" %>