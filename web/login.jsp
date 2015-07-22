<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/top.jsp" %>   
  
  <script type="text/javascript">
    function input_submit() {
        
 var xmlhttp = submit_form('n', 'ws_login');
    
    if (xmlhttp==null) {
        document.getElementById("div_captcha").style.display = "";
        document.getElementById('img_captcha').src = "captcha.jpg?date="+(new Date).getTime();
    } else {
<c:if test="${param.url==null}">
        document.location.href = "index.jsp";
    </c:if>
<c:if test="${param.url!=null}">
        document.location.href = "<c:out value="${param.url}"/>";
 </c:if>
    }

return false;

}
		
    </script>
    
  <form action="#" class="boxdialog" id="form_login" enctype="application/x-www-form-urlencoded" method="POST">
      <c:if test="${app.configuration['anonymous_can_inscribe']=='t'}">
      <div class="titulo1">
        <a href="newUser.jsp">${lang.get('ask_new_user')}</a>
      </div>
      </c:if>
      
      ${lang.get('username')}<br>
      <input type="text" name="username" id="ns0" />
      <br>
      <br>
      
      
      ${lang.get('password')}<br>
      <input type="password" name="password" id="ns1" />
      <br>
      <div id="div_captcha" ${ses.captcha==null ? 'style="display:none"' : ''} >
      <br>
      
      <img id="img_captcha" src="captcha.jpg" style="clear:both"/><br>
      ${lang.get('captcha_msg')}<br>
      <input type="text" name="captcha" id="ns3" />
      </div>
      <br>
      
      
      <button type="submit" onclick="input_submit(); return false;" value="${lang.get('login')}" >${lang.get('login')}</button>
      
      <input type="hidden" name="url" value="<c:out value="${param.url}"/>" />
      <input type="hidden" id="ns2" value="" />
      </form>
   

      <%@include file="WEB-INF/jsp/fundo.jsp" %>