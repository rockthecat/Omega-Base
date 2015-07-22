var context = "/omegabase";

function getHeight() {
    var H = window.innerHeight;

    if (!H) {
        H = document.documentElement.clientHeight;
    }
    
    
    return H;
}

function call_sp(func, params) {
var xmlhttp;


if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  

xmlhttp.open("POST",context+"/callsp",false);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("func="+func+"&"+params);
return xmlhttp;

}


function find_input(name) {
    var inp = document.getElementById(name);
    /*
    if (inp==null) {
        inp = document.getElementsByName(name);
        if (inp!=null&&inp.length>0) {
            return inp[0];
        }
    }
    */
    return inp;
}

function get_real(cmp) {
    if (cmp.tagName == 'INPUT'&&cmp.type=='radio') {
        var cmps = document.getElementsByName(cmp.name);
        cmp = null;
        
        for(var i=0;i<cmps.length;i++) {
            if (cmps[i].checked) {
                cmp = cmps[i];
                break;
            }
        }
        
    }

    return cmp;
}

function get_all(cmp) {
    var ret;
    
    if (cmp.tagName == 'INPUT'&&cmp.type=='radio') {
        ret = document.getElementsByName(cmp.name);
    } else {
        ret = new Array();
        ret.push(cmp);
    }

    return ret;
}



function find_component(prefix, num) {
    var cmp = find_input(prefix+"s"+num);

    
    if (cmp!=null) {
        var ck_ins = !window.CKEDITOR ? null : CKEDITOR.instances[prefix+'s'+num];    
        
        if (ck_ins!=null) {
            find_input(prefix+"s"+num).value = ck_ins.getData();
        }

       return prefix+"s"+num;
   }
   
   cmp = find_input(prefix+"i"+num);
    
   if (cmp!=null) {
       return prefix+"i"+num;
   }
   
   
   cmp = find_input(prefix+"b"+num);
    
   if (cmp!=null) {
       return prefix+"b"+num;
   }
   
   cmp = find_input(prefix+"d"+num);
    
   if (cmp!=null) {
       return prefix+"d"+num;
   }
   
   cmp = find_input(prefix+"t"+num);
    
   if (cmp!=null) {
       return prefix+"t"+num;
   }
   
   cmp = find_input(prefix+"tt"+num);
    
   if (cmp!=null) {
       return prefix+"tt"+num;
   }
   
   return null;
}

function clear_components(prefix) {
    var i = 0;
    
   while ( (cmpname = find_component(prefix, i))!=null) {
       var cmps = get_all(find_input(cmpname));
       
       for (var j=0;j<cmps.length;j++) {
           var cmp = cmps[j];
            
           if (cmp.className=='error') {
                    cmp.className = "";
           } else if (cmp.className=='txterror') {
                   cmp.className = "txt";
            }
   }
       
       i++;
       
   } 
}
    
function put_sp_error(prefix, xmlhttp) {
    var error = xmlhttp.responseXML.documentElement.getElementsByTagName('error');
    
    clear_components(prefix);
    
    if (error!=null&&error.length>0) {
        var strerr = error[0].firstChild.nodeValue;
        var i = strerr.indexOf('|');
        var num = i!=-1 ? strerr.substring(0, i) : -1;
        var str = i!=-1 ? strerr.substring(i+1) : strerr;
        

        if (i!=-1) {
            var cmpname = find_component(prefix, num);
            if (cmpname!=null) {
                var cmp = get_real(find_input(cmpname));
            
                if (cmp.className!='txt') {
                    cmp.className = "error";

                } else {
                    cmp.className = "txterror";
                }
                cmp.focus();
            }
        }
        
        ws_alert(str);
        
        return true;
    } else {
        ws_alert(null);
    }
    
    return false;
}

function submit_form(prefix, func, params) {
    var i = 0;
    var str = "";
    var cmpname;
    var plen = prefix.length;
    
    while ( (cmpname = find_component(prefix, i))!=null) {
        var cmp = get_real(find_input(cmpname));
        if (str!="") {
            str +="&";
        }
        
        str += get_value(prefix, cmp);
        i++;
    }
    
    if (params) {
        str += "&"+params;
    }
 
    var xmlhttp = call_sp(func, str);
    
    return put_sp_error(prefix, xmlhttp) ? null : xmlhttp;
}

function ws_alert(msg) {
    
    if (msg!=null) {
        document.getElementById('errormsg').innerHTML = '<img class="erroricon" src="'+context+'/images/dialog-cancel.png" />'+msg;
        document.getElementById('errormsg').style.display = "";
    } else {
        document.getElementById('errormsg').style.display = "none";
    }
    
}

function get_value(prefix, cmp) {
        var str = "";
        
        if (cmp==null)
            return str;
        
        if (cmp.tagName == 'INPUT' && cmp.type == 'checkbox') {
            str = cmp.id.substring(prefix.length)+"="+(cmp.checked ? 't' : '');
        } else {
            str = cmp.id.substring(prefix.length)+"="+encodeURIComponent(cmp.value);
        } 
        
        return str;
}


function TableH(tableid, cols) {
    this.trs = new Array();
    this.header = document.createElement("tr");
    this.cols = cols;
    this.tableid = tableid;
    this.lines = 0;
    this.ths = new Array();
    this.limit = 50;
    this.offset = 0;
    this.paginators = new Array();
    
    this.clear = function() {
        for(var i=0;i<this.trs.length;i++) {
            var tr = this.trs[i];
            
            tr.parentNode.removeChild(tr);
        }
        
        this.trs = new Array();
        this.lines = 0;
    }
    
    this.getLimit = function() { return this.limit; }
    this.getOffset = function() { return this.offset; }
    this.setLimit = function(l) { this.limit = l; }
    
    this.getTH = function(col) {
        return this.ths[col];
    }
    
    this.getData = function() { return null; }
    this.prevPage = function() {
        this.go(-1);
        
        var xml = this.getData();
        
        if (xml!=null) {
            this.read(xml);
        }
    }
    
    this.nextPage = function() {
        this.go(1);
        
        var xml = this.getData();
        
        if (xml!=null) {
            this.read(xml);
        }
    }
    
    this.start = function() {
        
        var xml = this.getData();
        
        if (xml!=null) {
            this.read(xml);
        }
    }
    
    
    
    this.createPaginator = function(pagid1, callback1, callback2) {
        var pag1 = document.getElementById(pagid1);
        var btn1 = document.createElement('button');
        var btn2 = document.createElement('button');
        var spn = document.createElement('span');
        
        btn1.type = 'button';
        btn2.type = 'button';
        
        spn.innerHTML = "&nbsp;0&nbsp;";
        
        btn1.value = "&lt;&lt;";
        btn1.innerHTML = "&lt;&lt;";
        btn1.disabled = true;
        btn1.prt = this;
        btn2.value = "&gt;&gt;";
        btn2.innerHTML = "&gt;&gt;";
        btn2.disabled = true;
        btn2.prt= this;
    
        if (!callback1) {
            btn1.onclick = function(e) {
                getTarget(e).prt.prevPage();
            };
        } else {
            btn1.onclick = callback1;
        }
        
        if (!callback2) {
            btn2.onclick = function(e) {
                getTarget(e).prt.nextPage();
            };
        } else {
            btn2.onclick = callback2;
        }
        
        pag1.appendChild(btn1);
        pag1.appendChild(spn);
        pag1.appendChild(btn2);
        
        pag1.btn1 = btn1;
        pag1.spn = spn;
        pag1.btn2 = btn2;
        this.paginators.push(pag1);
    }
    
    this.updatePaginators = function() {
        for(var i=0;i<this.paginators.length;i++) {
            var pag = this.paginators[i];
            
            pag.spn.innerHTML = "&nbsp;"+this.offset+"&nbsp;";
            pag.btn1.disabled = (this.offset<=0);
            pag.btn2.disabled = this.lines<this.limit;    
        }
    }
    
    this.go = function(off) {
        if (off<0) {
            this.offset = this.offset<=0 ? 0 : this.offset-this.limit;
        } else {
            this.offset = this.lines<this.limit ? this.offset : this.offset+this.limit;
        }
        
        //this.updatePaginators();
    }
    this.resetOff = function () {
        this.offset = 0;
    }
    
    this.getLines = function() {
        return this.lines;
    }
    
    this.XMLtoObj = function(xrow) {
        var child = xrow.firstChild;
        var obj = [];
        
        while (child!=null) {
          
            obj[child.tagName] = child.firstChild ? child.firstChild.nodeValue : null;
            
            child = child.nextSibling;
        }
        
        return obj;
    }
    
    this.readRow = function(td, row, index) {
    }
    
    this.updateData = function() {
        var tbl = document.getElementById(this.tableid);
        
        for(var i=0;i<this.trs.length;i++) {
            tbl.appendChild(this.trs[i]);
        }
    }
    
    this.read = function(xmlhttp) {
        
        if (!xmlhttp) {
            return;
        }
        
        this.clear();
        
        var tr = document.createElement("tr");
        this.trs.push(tr);
        this.ths = new Array();
        
        for(var i=0;i<this.cols.length;i++) {
            var th = document.createElement("th");
        
            th.innerHTML = cols[i];
            tr.appendChild(th);
            this.ths.push(th); 
        }
    
        var xmlRows = xmlhttp.responseXML.documentElement.getElementsByTagName("row");
        for(var i=0;i<xmlRows.length;i++) {
            var xrow = xmlRows[i];
            
            tr = document.createElement("tr");
            this.trs.push(tr);
            
            for(var j=0;j<this.cols.length;j++) {
                var td = document.createElement("td");
                
                tr.appendChild(td);
                this.readRow(td, this.XMLtoObj(xrow), j);
            }
            
           //this.lines++;
           
        }
        this.lines = xmlRows.length;    
        
        this.updatePaginators();
        this.updateData();
        
    }
    
    
}

function _window_close(evt) {
    var e = evt ? evt : window.event;
    var btn = e.target ? e.target : e.srcElement;
    
    if (!btn.prt)
        return;
    document.getElementById('div_main').removeChild(btn.prt);
}

/*
function XWindow() {
    this.div = document.createElement('div');
    this.iframe = document.createElement('iframe');
    this.dtitle = document.createElement('div');
    this.img = document.createElement('img');
    this.span = document.createElement('span');
    
    this.div.className = 'box';
    this.iframe.className = 'boxframe';
    this.dtitle.className = 'boxtitle';
    this.img.src = context+"/images/edit-delete.png";
    this.img.className = 'rightbox';
    this.img.onclick = _window_close;
    this.img.prt = this.div;
    
    this.div.appendChild(this.dtitle);
    this.div.appendChild(this.iframe);
    this.dtitle.appendChild(this.span);
    this.dtitle.appendChild(this.img);
    
    this.open = function(title, src) {
        this.iframe.src = src;
        this.span.innerHTML = title;
        
        document.getElementById('div_main').appendChild(this.div);
    }
    
    this.close = function() {
        document.getElementById('div_main').removeChild(this.div);
    }
}

var xwindow = new XWindow();
*/

function XWindow2() {
    this.div = document.createElement('div');
    this.client = document.createElement('div');
    this.dtitle = document.createElement('div');
    this.img = document.createElement('img');
    this.span = document.createElement('span');
    
    this.div.className = 'box';
    this.client.className = 'boxframe';
    this.dtitle.className = 'boxtitle';
    this.img.src = context+"/images/edit-delete.png";
    this.img.className = 'rightbox';
    this.img.onclick = _window_close;
    this.img.prt = this.div;
    
    //this.client.style.width = W+"px";
    //this.client.style.height = H+"px";
    
    this.div.appendChild(this.dtitle);
    this.div.appendChild(this.client);
    this.dtitle.appendChild(this.span);
    this.dtitle.appendChild(this.img);
    
    this.open = function(title, html) {
        var h = getHeight();
        
        this.div.style.height = (h-16)+"px";
        this.dtitle.style.height = (16)+"px";
        this.client.style.height = (h-16)+"px";
        
        
        this.client.innerHTML = html;
        this.span.innerHTML = title;
        
        document.getElementById('div_main').appendChild(this.div);
    }
    
    this.openIframe = function(title,url) {
        this.open(title, "<iframe src='"+url+"' ></iframe>")
    }
    
    this.close = function() {
        document.getElementById('div_main').removeChild(this.div);
    }
}

var xwindow2 = new XWindow2();

function detect_mobile(ismob) {
    if (screen.width&&screen.width<=699&&ismob==false) {
        document.location.href = context+"/setmobile?m=t";
    } else if (screen.width&&screen.width>699&&ismob==true) {
        document.location.href = context+"/setmobile?m=f";
    }
}

function getTarget(evt) {
    var e = evt?evt:window.event;
    var t = e.target ? e.target : e.srcElement;
    
    return t;
}

function getEvent(evt) {
    return evt?evt:window.event;
}


function TabsH(divid, tabsid, titles, urls, height) {
    this.divid = divid;
    this.tabsid = tabsid;
    this.tabs = new Array();
    this.idx = urls[0];
    this.urls = urls;
    
    var div = document.getElementById(this.divid);
    var tab = document.getElementById(this.tabsid);
    
    for(var i=0;i<titles.length;i++) {
        var obj = new Object();
        
        obj.title = titles[i];
        obj.url = urls[i];
        obj.iframe = document.createElement('iframe');
        obj.iframe.style.display = "none";
        obj.iframe.style.height = height+"px";
        //alert();
        
        obj.a = document.createElement('a');
        //obj.a.className = 'rotulobig';
        obj.a.innerHTML = html(titles[i]);
        obj.a.style.display = "none";
        obj.a.href = "javascript:void(0)";
        obj.a.prt = this;
        obj.a.index = urls[i];
        obj.a.onclick = function(evt) {
            var e = evt ? evt : window.event;
            var a = e.target ? e.target : e.srcElement;
            
            a.prt.setIndex(a.index);
        }
        tab.appendChild(obj.a);
        obj.span = document.createElement('div');
        //obj.span.className = 'rotulobig';
        obj.span.innerHTML = html(titles[i]);
        tab.appendChild(obj.span);
        
        this.tabs[urls[i]] = obj;
    
    
    
    }
    
    this.clear = function() {
        var client = document.getElementById(this.divid);
        
        while(client.hasChildNodes()) {
            client.removeChild(client.childNodes[0]);
        }
        
        for(var i=0;i<this.urls.length;i++) {
            var o = this.tabs[this.urls[i]];
            
         
            
            if (o.a.index==this.idx) {
                o.a.style.display = "none";
                o.span.style.display = "";
                //alert(o);
                
                if (!o.iframe.src||o.iframe.src=='') {
                    o.iframe.src = o.url;
                    
                }
                o.iframe.style.display = "";
                o.iframe.style.height = height;
                client.appendChild(o.iframe);
                //alert(client.innerHTML);
            } else {
                o.a.style.display = "";
                o.span.style.display = "none";
                //alert(o.span);
                
            }
        }
    }
    
    this.getIndex = function() { return this.idx; }
    this.setIndex = function(idx) {
        if (idx!=this.idx) {
            document.getElementById(this.divid).removeChild(this.tabs[this.idx].iframe);
        }
        this.idx = idx;
        
        this.clear();
    }
    
    this.setIndex(urls[0]);
}


function html(str) {
    return str
            .replace(/&/g, '&amp;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
}