<%@include file="/WEB-INF/jsp/top.jsp" %>

<button type="button" onclick="xwindow2.openIframe('${lang.get('new_group')}', 'editGroup.jsp')" value="${lang.get('new_group')}">${lang.get('new_group')}</button>
<br>
<br>
<div id="pag1"></div>
<br>
<table class="data" id="dados">
    
</table>
<br>
<div id="pag2"></div>

<script type='text/javascript'>
    function del_group(id) {
        if (confirm("${lang.get('ask_delete_group')}")) {

            var xml = submit_form('del', 'ws_delete_group', 'i0='+id);
            if (xml!=null) {
                document.location.href = document.location.href;
            }
        }
    }
    
    var table = new TableH('dados', 
    ["${lang.get('name')}", "${lang.get('superuser')}", "${lang.get('administrator')}", "${lang.get('num_users')}", "${lang.get('delete')}"]);
    
    
    table.readRow = function(td, row, col) {
        switch(col) {
            case 0:
            {
                var a = document.createElement('a');
                a.href = "javascript:void(0)";
                a.grid = row['id'];
                a.grname = row['name'];
                a.onclick = function (e) {
                    xwindow2.openIframe(getTarget(e).grname, 'editGroup.jsp?id='+getTarget(e).grid);
                };
                a.innerHTML = row['name'];
                td.appendChild(a);
            }
                break;
            case 1:
                if (row['superuser']=='t') {
                    td.innerHTML = "X";
                }
                break;
            case 2:
                if (row['administrator']=='t') {
                    td.innerHTML = "X";
                }
                break;
            case 3:
                    td.innerHTML = row['num_users'];
            break;
            case 4:
            {
                var a = document.createElement('a');
                
                a.innerHTML = "<img src='images/edit-delete.png'/>";
                a.href = "javascript:void(0)";
                a.grid = row['id'];
                
                a.onclick = function(f) {
                    del_group(getTarget(f).parentNode.grid);  
                };
                
                
                td.appendChild(a);
            }
                break;
            
        }
    }
    table.getData = function() {
        return submit_form('n', 'ws_get_groups2', 'i0='+this.getOffset()+'&i1='+this.getLimit());
    }
    table.createPaginator('pag1');
    table.createPaginator('pag2');
    table.start();
    
    
</script>


<%@include file="/WEB-INF/jsp/fundo.jsp" %>
