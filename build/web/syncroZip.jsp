<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/top.jsp" %>

<ul>
<li>${lang.get('syncro_text1')}</li>
<li>${lang.get('syncro_text2')}</li>
</ul>
<br>
<div class="boxdialog">
    <form action="syncrozip" method="post" enctype="multipart/form-data" target="_blank">
        ${lang.get('category')}<br>
        <select name="category">
            ${conn.pushb(false)}
            ${conn.pushi(2)}
            <c:forEach var="ct" items="${conn.select('get_categories')}">
                <option value="${ct['id']}"><c:out value="${ct['name']}"/></option>
            </c:forEach>
        </select>
        <br>
        <br>
        
        <label><input type="radio" name="status" value="R" class="radio" checked />${lang.get('my_documents')}</label><br>
        <label><input type="radio" name="status" value="N" class="radio" />${lang.get('dsketch')}</label><br>
        <label><input type="radio" name="status" value="P" class="radio" />${lang.get('published')}</label><br>
        
        <br>
        <input type="file" name="att" accept="application/zip"/>
        <br>
        <br>
        <button type="submit" name="ok" value="${lang.get('ok')}">${lang.get('ok')}</button>
    </form>
</div>

<%@include file="WEB-INF/jsp/fundo.jsp" %>