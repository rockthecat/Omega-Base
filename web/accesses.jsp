<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jsp/top.jsp" %>

<c:set var="grps" value="${conn.select('ws_get_managed_groups')}"/>

<script type="text/javascript">
    function save() {
        var xml = submit_form('n', 'ws_save_configuration');
        
        if (xml!=null) {
            alert("${lang.get('data_saved')}");
        }
    }
    
    var table = new TableH('tbl', 
    ["${lang.get('user')}", "${lang.get('date')}", "${lang.get('addr')}", "${lang.get('action')}"]);
    
    table.setLimit(50);
    table.readRow = function(td, row, col) {
        switch(col) {
            case 0:
            {
                if (!row['name'])
                    break;
                
                var a = document.createElement('a');
                
                a.onclick = function (evt) {
                    var e = getTarget(evt);
                    
                    xwindow2.openIframe(e.innerHTML, "editUser.jsp?id="+e.edid);
                }
                a.href = 'javascript:void(0)';
                a.innerHTML = row['name'];
                a.edid = row['id_user'];
                td.appendChild(a);
            }
            
                break;
            case 1:
                td.innerHTML = row['date'];
                break;
            case 2:
                td.innerHTML = row['addr'];
                break;
            case 3:
            {
                if (
                        row['can_view']=='t'&&
                        (
                        row['action']=='save_att'||
                        row['action']=='del_att'||
                        (row['action']=='save'&&row['table']=='document')||
                        (row['action']=='update'&&row['table']=='document')||
                        (row['action']=='import'&&row['table']=='document')||
                        (row['action']=='view_old'&&row['table']=='document')||
                        (row['action']=='tryedit_old'&&row['table']=='document')||
                        (row['action']=='edit'&&row['table']=='document')||
                        (row['action']=='view'&&row['table']=='document')||
                        (row['action']=='tryedit'&&row['table']=='document')
                        )
                    ) {
                    var a = document.createElement('a');
                    
                    a.onclick = function(evt) {
                        createLinkDoc("${lang.get('view')}","${lang.get('edit')}","${lang.get('comments')}","${lang.get('historic')}", evt);
                    }
                    
                    a.innerHTML = row['msg_action'];
                    a.href="javascript:void(0)";
                    a.edid = row['table_id'];
                    a.edlevel = 3;
                    a.edname = row['msg_action'];
                    td.appendChild(a);
                
                } else td.innerHTML = row['msg_action'];
            }
                break;
        }
        
    }
    
    function searchP() {
        table.go(-1);
        search();
    }
    function searchN() {
        table.go(1);
        search();
    }
    
    function search(r) {
        if (r==true) {
            table.resetOff();
        }
        document.getElementById('ni3').value = table.getOffset();
        document.getElementById('ni4').value = table.getLimit();
        var xml = submit_form('n', 'ws_get_accesses');
        
        if(xml!=null) {
            table.read(xml);
        }
    }

</script>
<form action="#" method="post">
    <div class="boxdialog">
        ${lang.get('group')}<br>
        <select id='ni0'>
            <option value='0'>${lang.get('ALL')}</option>
            <c:forEach items="${grps}" var="grp" >
                <option value='${grp['id']}' ><c:out value="${grp['name']}"/></option>
            </c:forEach>
        </select>
        <br>
        <br>
        ${lang.get('date_from')}<br>
        <input type='date' id='nd1' value="${lang.printDate(lang.currentTime)}"  />
        <br>
        <br>
        
        ${lang.get('date_to')}<br>
        <input type='date' id='nd2'  value="${lang.printDate(lang.currentTime+1000*60*60*24)}" />
        <br>
        <br>
        <input type="hidden" id="ni3" />
        <input type="hidden" id="ni4" />
        
        <button type='button' value='${lang.get('ok')}' onclick="search(true)">${lang.get('ok')}</button>
    </div>    
    
    <div class="panelend">&nbsp;</div>
</form>
    <div id="off0"></div>
        <table id='tbl' class='data'>
        </table>
    <div id="off1"></div>
    
    <script type="text/javascript">
        table.createPaginator('off0', searchP, searchN);
        table.createPaginator('off1', searchP, searchN);
    </script>
        
<%@include file="WEB-INF/jsp/fundo.jsp" %>