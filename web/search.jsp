<%@include file="/WEB-INF/jsp/top.jsp" %>

<script type='text/javascript'>
    var table = new TableH('dados', 
    ["${lang.get('delete')}", "${lang.get('name')}", "${lang.get('category')}", "${lang.get('attachments')}"]);
    
    
    table.readRow = function(td, row, col) {
        switch(col) {
           
            case 0:
               td.className = 'chk';
            if (parseInt(row['level_priviledge'])>=2)
            {
                var chk = document.createElement('input');
                
                chk.setAttribute('type', 'checkbox');
                chk.setAttribute('name', 'odel');
                chk.setAttribute('value', row['id']);
                chk.className = 'radio';
                td.appendChild(chk);
                
             }
             break;
             case 1:
             {
                var found;
                var sk = row['status']=='P' ? '' : '${lang.get('sketch')}';
                
                if (row['foundtxt']=='t') {
                    found = '<img src="images/dialog-ok-apply.png" class="small"/>';
                } else {
                    found = "";
                }
                
                    var id = row['id'];
                    var a = document.createElement('a');
                    
                    a.onclick = function (evt) {
                        var a = getTarget(evt);
                        var html = "<div class='total'>"+
                                "<div id='tabid' class='rotulobig'></div>"+
                               // "<div class='rotuloclear'>&nbsp;</div>"+
                                "<div id='clientid' ></div>"+
                        "</div>";
                        var tabs = new Array();
                        var urls = new Array();
                        
                        tabs.push("${lang.get('view')}");
                        urls.push('view.jsp?id='+a.edid);
                        
                        if (parseInt(a.edlevel)>=2) {
                            tabs.push('${lang.get('edit')}');
                            urls.push('editDocument.jsp?id='+a.edid);
                            
                            if (parseInt(a.edlevel)>=3) {
                                tabs.push('${lang.get('historic')}');
                                urls.push('viewHistoric.jsp?id='+a.edid);                            
                            }
                        }
                        
                        if (a.canComment==true) {
                            tabs.push('${lang.get('comments')}');
                            urls.push('fr_comments.jsp?id='+a.edid);
                        }
                        
                       xwindow2.open(a.edname, html);
                        var tabs = new TabsH('clientid', 'tabid',
                        tabs,
                        urls,
                        getHeight()-90);
                    }
                    a.edname = row['name'];
                    a.edid = id;
                    a.edlevel = row['level_priviledge'];
                    a.canComment = row['can_comment']=='t';
                    a.href = "javascript:void(0)";
                    a.innerHTML = row['name']+sk+found;
                    td.appendChild(a);
                
            }
                break;
                
            case 2:
                td.className = "highres";
                this.getTH(2).className = "highres";
                td.innerHTML = row['name_category'];
                break;
                
            case 3:
            {
                var atts = row['attachs'];
                
                if (atts==null||row['status']=='N')
                    return;
                
                var vatts = atts.split('|');
                
                for(var i=0;i<vatts.length;i++) {
                    var att = vatts[i].split(';');
                    var div = document.createElement('div');
                    var a = document.createElement('a');
                    var img = document.createElement('img');
                    var span = document.createElement('span');
                    
                    a.appendChild(img);
                    a.appendChild(document.createElement('br'));
                    a.appendChild(span);
                    a.href = "userfiles/"+row['id']+"/file/"+encodeURIComponent(att[3]);
                    
                    img.src = "images/files/"+att[1];
                    img.className = "icon";
                   
                    if (att[2]=='true') {
                        var img2 = document.createElement('img');
                        
                        img2.className = "small";
                        img2.src = "images/dialog-ok-apply.png";
                        div.appendChild(img2);
                    } 
                    span.innerHTML = att[3];
                    
                    div.className = "rotulo";
                    div.appendChild(a);
                    div.title = att[3];
                    
                    
                    a.target = "_blank";
                    
                    td.appendChild(div);
                }    
            }
            break;
            
        }
    };
    
    
    function search(reset) {
        if (reset) {
            table.resetOff();
            document.getElementById('ni3').value = table.getOffset();
        }
        
        
        table.clear();
        document.getElementById('ni4').value = table.getLimit();
        var xmlhttp = submit_form('n', 'ws_search');
        
        document.getElementById('msggoo').innerHTML =  document.getElementById('ns0').value!='' ? "${lang.get('msggoo')} <strong>&quot;"+
                document.getElementById('ns0').value+"&quot;</strong>" : "";
        
        table.read(xmlhttp);
        
       
        }
        
        function view(title, id) {
          
            xwindow2.open(title, 'frview');
        }
    
    function searchN() {
        table.go(1);
        document.getElementById('ni3').value = table.getOffset();
        search();
    }
    
    function searchP() {
        table.go(-1);
        document.getElementById('ni3').value = table.getOffset();
        search();
    }
    
    function delSelected() {
        if (window.confirm("${lang.get('ask_delete_docs')}")) {
            var docs = document.getElementsByName('odel');
            
            var str = '';
            
            for(var i = 0;i<docs.length;i++) {
                if (!docs[i].checked)
                    continue;
                
                if (str=='') {
                    str = docs[i].value;
                } else {
                    str += '|'+docs[i].value;
                }
            }    
            
            call_sp('ws_del_many_documents', 's0='+str);
            document.location.href = document.location.href;
        }
    }
</script>


<form method="post" action="#">
    <div class="panel">
    ${lang.get('search')}<br>
    <input type="text" id="ns0" value="<c:out value="${param.s0}" />" />
    </div>


    <div class='panel'>
        ${lang.get('status')}<br>
                <label>
                    <input type='radio' name='ns2' id='ns2' value='P' class='radio' checked />
                ${lang.get('published')}
                </label><br>
                
                <label>
                <input type='radio' name='ns2' id='ns2' value='N' class='radio' />
                ${lang.get('dsketch')}
                </label><br>
                
                
                <label>
                <input type='radio' name='ns2' id='ns2' value='' class='radio'/>
                ${lang.get('ALL')}
                </label><br>
                
    </div>

    
    <div class="panel">
        ${lang.get('category')}<br>
        <select id='ni1'>
            <option value='0' >${lang.get('ALL')}</option>
            ${conn.pushb(false)}
            ${conn.pushi(1)}
            <c:forEach var="row" items="${conn.select('get_categories')}">
                <option value='${row['id']}'><c:out value="${row['name']}"/></option>
            </c:forEach>
        </select>
            
            <input type='hidden' id='ni3' value='0' />
            <input type='hidden' id='ni4' value='0' />
    </div>
            
    
    <div class="panel">
        <br>
        <button type="submit" value="${lang.get('ok')}" onclick='search(true); return false' >${lang.get('ok')}</button>
    </div>
    
    
        <div class='panelend'>&nbsp;</div>
        
     
        <button type='button' onclick="xwindow2.open('${lang.get('new_document')}', '<iframe class=\'total\' src=\'editDocument.jsp\'></iframe>')" >${lang.get('new_document')}</button>
        <button type='button' onclick='delSelected()' >${lang.get('del_selected')}</button>
        <div class='rotuloclear'>&nbsp;</div>
</form>

<br>
<div id="off0" ></div>
<br>
        <div id="msggoo" ></div>

    <table class="data"  id='dados'>
        
    </table>
<br>       
<div id="off1"></div>
        <script type="text/javascript">
                     
                    table.createPaginator('off0', searchP, searchN);
                    table.createPaginator('off1', searchP, searchN);
    <c:if test="${param.s0!=null}">
                        search();
    </c:if>
        </script>
<%@include file="WEB-INF/jsp/fundo.jsp" %>