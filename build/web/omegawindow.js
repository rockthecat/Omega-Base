var zformid = 1;

function ZForm(prt, className) {
    ZObject.call(this, prt);
    this.controls = new Array();
    this.div = document.createElement('div');
    this.zid = zformid+'z';
    zformid++;
    this.div.className = className ? className : 'panel';
    this.div.style.position = "absolute";
    
    this.add = function(txt, input) {
        var label = document.createElement('label');
        var span = document.createElement('span');
        
        span.innerHTML = Zhtml(txt);
        label.appendChild(span);
        label.appendChild(document.createElement('br'));
        label.appendChild(input);
        
        this.controls.push(input);
        this.div.appendChild(label);
        
    };
    
    this.createInput = function(txt, id, type) {
        var input = document.createElement('input');
        
        input.setAttribute('type', type);
        input.setAttribute('id', this.zid+id);
        
        this.add(txt, input);
        
        return input;
    };
  
    this.createTextarea = function(txt, id) {
        var input = document.createElement('textarea');
        
        input.setAttribute('id', this.zid+id);
        this.add(txt, input);
        
        return input;
    };


    this.createSelect = function(txt, id, multi) {
        var select = document.createElement('select');
        
        select.setAttribute('multiple', multi);
        select.setAttribute('id', this.zid+id);
        
        this.add(txt, select);
        
        return select;
    };
    
    this.createBr = function() {
        var br = document.createElement('br');
        
        this.controls.push(br);
        this.div.appendChild(br);
        
        return br;
    };
    
    this.paint2d = function(ctx) {
        var ax = this.getAbsX();
        var ay = this.getAbsY();
        var z = this.getTopMost().getZoom();
        
        this.setWidth(this.div.offsetWidth/z);
        this.setHeight(this.div.offsetHeight/z);
        this.div.style.left = ax+"px";
        this.div.style.top = ay+"px";
        ctx.fillStyle = this.getBackground();
        ctx.fillRect(ax, ay, this.getAbsWidth(), this.getAbsHeight());
    };
    
    this.getObj =function(id) {
        return document.getElementById(this.zid+id);
    };
}

function ZBaseWindow(prt,title) {
    ZPanel.call(this, prt);
    this.title = title;
    this.titleHeight = 16;
    this.setForeground("#000");
    
    this.setTitleHeight= function(h) { this.titleHeight = h; };
    this.getTitleHeight = function() { return this.titleHeight; };
    
    this.paintTitle = function(ctx) {
        var ax = this.getAbsX();
        var ay = this.getAbsY();
        var aw = this.getAbsWidth();
        
        ctx.fillStyle = this.getForeground();
        
    };
}

function ZWindow(prt, title) {
    ZBaseWindow.call(this, prt, title);
    
    this.client = new ZForm(this);
    this.getClient = function() { return this.client; };
    
    this.paint2d = function(ctx) {
    };
}