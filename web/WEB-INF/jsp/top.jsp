
<%@include file="header.jsp" %>  

<div id="div_main">
<script type="text/javascript">
    function input_text_onblur(event) {
		  var frm = document.getElementById("form_search");

if (frm.s0.value=="") {
	frm.s0.value = "${lang.get('search')}";
}

		}
		function input_text_onfocus(event) {
		  var frm = document.getElementById("form_search");

if (frm.s0.value=="${lang.get('search')}") {
	frm.s0.value = "";
}

		}
		
                
function change_lang(lng) {
    if (window.confirm('${lang.get('ask_page_refresh')}')) {
        document.location.href = "${pageContext.servletContext.contextPath}/setlanguage?lang="+lng;
    } else {
        var langs = document.getElementsByName('lang');
        
        for(var i=0;i<langs.length;i++) {
              if (langs[i].value=='${lang.lang}') {
                    langs[i].checked = true;
                    break;
              }
        }
    }
}
    </script>
    
    <div class="faixacima"  >
         <img src="${pageContext.servletContext.contextPath}/images/omega.png"/>
     
           
        
         
                       
        <div class="rightbox">
            <div class="menu">${lang.get('language')}
            <ul>
                <li>&nbsp;</li>   
                        <c:forEach var="lng" items="${langbean.languages}">
                            <c:set var="l" value="${fn:split(lng, '@')}"/>
                <li><label>
                                <input type='radio' class='radio' name='lang' value="${l[0]}" ${lang.lang == l[0] ? 'checked' : ''} onclick='change_lang(this.value)' />${l[1]}
                    </label></li>
                        </c:forEach>
                </ul>
        </div>    
            
            <div class="menu"><img src="${pageContext.servletContext.contextPath}/images/${ses.idUser!=0 ? 'dialog-ok-apply.png': 'edit-delete.png'}" />
                <c:out  value="${ses.idUser!=0 ? fn:split(ses.username, ' ')[0] : lang.get('unlogged') }"/>
                
            <ul>
                <li>&nbsp;</li>
         <c:if test="${app.configuration['anonymous_can_use']=='t' or ses.idUser!=0}">
         <li><form action="${pageContext.servletContext.contextPath}/search.jsp" id="form_search" enctype="application/x-www-form-urlencoded" method="POST">
            <input type="text"  onblur="return input_text_onblur(event);" onfocus="return input_text_onfocus(event);" name="s0" value="${lang.get('search')}" />
             </form></li>
        </c:if>
            

                   
                   
                    <c:if test="${ses.superUser}">
                        <li><a href='${pageContext.servletContext.contextPath}/configuration.jsp' >${lang.get('configuration')}</a></li>
                        <li><a href='${pageContext.servletContext.contextPath}/groups.jsp' >${lang.get('groups')}</a></li>
                        <li><a href='${pageContext.servletContext.contextPath}/categories.jsp' >${lang.get('categories')}</a></li>
                    </c:if>
                    <c:if test="${ses.superUser or ses.admUsers}">
                        <li><a href='${pageContext.servletContext.contextPath}/accesses.jsp' >${lang.get('accesses')}</a></li>
                        <li><a href='${pageContext.servletContext.contextPath}/editUsers.jsp' >${lang.get('users')}</a></li>
                    </c:if>
                        
                    <c:if test="${ses.idUser!=0}">
                <li><a href="${pageContext.servletContext.contextPath}/changeUser.jsp" >${lang.get('user')}</a></li>
                <li><a href="${pageContext.servletContext.contextPath}/myDocuments.jsp" >${lang.get('my_documents')}</a></li>
                <li><a href="${pageContext.servletContext.contextPath}/syncroZip.jsp" >${lang.get('syncro')}</a></li>
                <li><a href="${pageContext.servletContext.contextPath}/logout" >${lang.get('logout')}</a></li>
                </c:if>
                
        <c:if test="${ses.idUser==0}">
            <li><a href="${pageContext.servletContext.contextPath}/login.jsp" >${lang.get('do_login')}</a></li>
            <c:if test="${app.configuration['anonymous_can_inscribe']=='t'}">
            <li><a href="${pageContext.servletContext.contextPath}/newUser.jsp" >${lang.get('create_account')}</a></li>
            </c:if>
        </c:if>
            </ul>
                        
           
        </div>
            

           
        
        
        

            
        </div>
        
    </div> 

        <div class="faixaacimagap">&nbsp;</div>
        <div class="content">
        <div id="errormsg" style="display:none"></div>
