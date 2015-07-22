<%@include file="/WEB-INF/jsp/header.jsp" %>
<div id="errormsg" style="display: none" ></div>
${conn.pushi(param.id)}
<c:set var="slaves" value="${conn.select('ws_get_group_slaves')}" />

${conn.pushi(param.id)}
<c:set var="cats" value="${conn.select('ws_get_group_categories')}" />

<c:if test="${param.id!=null}">
${conn.pushi(param.id)}
<c:set var="grp" value="${conn.selectOne('ws_get_group_info')}" />
</c:if>

<Script type="text/javascript">
    function check_visible() {
        var grps = document.getElementById('nb2').checked;
        var users = document.getElementById('nb3').checked;
        
        document.getElementById('slaves').style.display = (!grps && users) ? 'block' : 'none';
        document.getElementById('categories').style.display = (!grps) ? 'block' : 'none';
    }
    
    function save() {
        var arr_cats = [
    <c:forEach var="cat" items="${cats}">
                ${cat['id']},
    </c:forEach>
            -1];
            
        
        var params = 's4=';
        var slaves = document.getElementsByName('slave');
        
        for(var i=0;i<slaves.length;i++) {
            if (slaves[i].checked) {
                params += slaves[i].value+'|';
            }
        }
        
        if (params.length>3)
            params = params.substr(0, params.length-1);
      
        params += '&s5=';
        
        for(var i=0;i<arr_cats.length-1;i++) {
            var rds = document.getElementsByName('c'+arr_cats[i]);
            
            if (i!=0) {
                params += '|';
            }
            for(var j=0;j<rds.length;j++) {
                if (rds[j].checked) {
                    params += rds[j].value;
                }
            }
            
            params += (document.getElementById('s'+arr_cats[i]).checked) ? ';t' : ';f';
        }
        
        var xml = submit_form('n', 'ws_save_group', params);
        
        if (xml!=null) {
            window.parent.xwindow2.close();
        }
    }
    </script>
    

<input type="hidden" id="ni0" value="<c:out value="${param.id}"/>" />

${lang.get('name')}<br>
<input type="text" value="<c:out value="${grp['name']}"/>" id="ns1" />

<br>
<br>
<label>
<input type="checkbox" id="nb2" class="chk" ${grp['adm_groups']=='t' ? 'checked' : ''} onclick="check_visible()" />
${lang.get('can_administrate_groups')}
</label>

<br>
<label>
    <input type="checkbox" id="nb3" class="chk" ${grp['adm_users']=='t' ? 'checked' : ''} onclick="check_visible()" />
    ${lang.get('can_administrate_users')}
</label>
<br>
<br>

<div id="slaves" class="panel">
    ${lang.get('slave_groups')}<br>
    <table class="data" >
        <tr>
            <th>${lang.get('name')}</th>
            <th>${lang.get('can_administrate_groups')}</th>
            <th>${lang.get('can_administrate_users')}</th>
        </tr>
    
    <c:forEach var="slave" items="${slaves}">
        <tr>
            <td><label>
            <input type="checkbox" class="chk" name="slave" value="${slave['id_slave']}" ${slave['adm']=='t' ? 'checked' : ''} />
            <c:out value="${slave['name']}"/>
                </label></td>
        <td>${slave['adm_groups']=='t'?'X':''}</td>
        <td>${slave['adm_users']=='t'?'X':''}</td>
        </tr>
    </c:forEach>        
    </table>
</div>

<div id="categories" class="panel">
    
${lang.get('categories')}<br>
<table class="data" id="categories" >
        <tr>
            <th>${lang.get('name')}</th>
            <th>${lang.get('priviledge')}</th>
            <th>${lang.get('can_comment')}</th>
        </tr>
    ${conn.pushi(param.id)}
    <c:forEach var="cat" items="${cats}">
        <tr>
            <td><c:out value="${cat['name']}"/></td>
            <td>
                <label>
                <input type="radio" name="c${cat['id']}" value="${cat['id']};0" class="chk" ${cat['level']=='0' ? 'checked': ''} />
                ${lang.get('priv_none')}
                </label>
                &nbsp;
                <label>
                <input type="radio" name="c${cat['id']}" value="${cat['id']};1" class="chk" ${cat['level']=='1' ? 'checked': ''} />
                ${lang.get('priv_read')}
                </label>
                &nbsp;
                <label>
                <input type="radio" name="c${cat['id']}" value="${cat['id']};2" class="chk" ${cat['level']=='2' ? 'checked': ''} />
                ${lang.get('priv_readwrite')}
                </label>
                &nbsp;
                <label>
                <input type="radio" name="c${cat['id']}" value="${cat['id']};3" class="chk" ${cat['level']=='3' ? 'checked': ''} />
                ${lang.get('priv_all')}
                </label>
                
            </td>
            <td><label>
                    <input type="checkbox" class="chk" id="s${cat['id']}" ${cat['can_comment']=='t' ? 'checked' : ''} />
            </label></td>
        </tr>
    </c:forEach>        
    </table>
</div>

    <div class="panelend">&nbsp;</div>
    
<button type="button" onclick="save()" value="${lang.get('ok')}">${lang.get('ok')}</button>

    
    <SCRIPT type="text/javascript">
        check_visible();
    </script>
    
    <%@include file="WEB-INF/jsp/fundoheader.jsp" %>