<!DOCTYPE html>    
<html>
    <head>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8"> 
        <title>${lang.get('db')}</title>
        <meta name="viewport" content="width=device-width,height=device-height,user-scalable=no,minimum-scale=1.0,maximum-scale=1.0"> 
        <link id="link" href="${pageContext.servletContext.contextPath}/style${ses.mobile ? '_lowres' : ''}.css" media="screen" rel="stylesheet" />
        <script src="${pageContext.servletContext.contextPath}/omega.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/omegaws.js" type="text/javascript"></script>
       
    </head>
    
    <script type="text/javascript">
        detect_mobile(${ses.mobile ? 'true': 'false'});
        
    </script>
    <body>
 