<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 
           uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 
           uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="ses" class="org.omegabase.bean.SessionBean" scope="session" />
<jsp:useBean id="conn" class="org.omegabase.bean.ConnBean" scope="request" >
    <jsp:setProperty name="conn" property="hostAddr" value="${pageContext.request.remoteAddr}"/>
    <jsp:setProperty name="conn" property="lang" value="${cookie['L_omega_lang'].value}"/>
    <jsp:setProperty name="conn" property="session" value="${ses}" />
</jsp:useBean>

<jsp:useBean id="langbean" class="org.omegabase.bean.LanguageBean" scope="application">
    <jsp:setProperty name="langbean" property="conn" value="${conn}"/>
</jsp:useBean>

<jsp:useBean id="app" class="org.omegabase.bean.AppBean" scope="application">
    <jsp:setProperty name="app" property="conn" value="${conn}"/>
</jsp:useBean>

<jsp:useBean id="lang" class="org.omegabase.bean.Lang" scope="request">
    <jsp:setProperty name="lang" property="bean" value="${langbean}"/>
    <jsp:setProperty name="lang" property="lang" value="${cookie['L_omega_lang'].value}"/>
    <jsp:setProperty name="lang" property="app" value="${app}"/>
</jsp:useBean>
