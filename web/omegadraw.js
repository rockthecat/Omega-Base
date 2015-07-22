function ZArrayRmv(array, obj) {
	var a = new Array();
	
	for(var i=0;i<array.length;i++) {
		if (array[i]!=obj) {
			a.push(array[i]);
		}
	}
	
	return a;
}

function Zhtml(txt){
    txt = txt.replace(/&/g, '&amp;');
    txt = txt.replace(/</g, '&lt;');
    txt = txt.replace(/>/g, '&gt;');
    txt = txt.replace(/"/g, '&quot;');
    txt = txt.replace(/'/g, '&squot;');
    
    return txt;
}


function ZObject(prt) {
    this.x = 0;
    this.y = 0;
    this.width = 200;
    this.height = 40;
    this.selected = false;
    this.visible = true;
    this.classname = "ZObject";
    this.background = "#FFF";
    this.foreground = "#000";
    this.children = new Array();
    this.parent = prt;
    

    
    this.getClassName = function() { return this.classname; };
    
    this.getTopMost = function() {
        var prt = this;
        
        while (prt.getParent()) {
            prt = prt.getParent();
        }
        
        return prt;
    };
    
    this.getParent = function() { return this.parent; };
    this.setParent = function(prt) {
        if (this.parent) {
            this.parent.children = ZArrayRmv(this.parent.children, this);
        }
        
        this.parent = prt;
        
        if (prt) {
            prt.children.push(this);
        }
    };
    
    this.setVisible = function(b) { this.visible = b; };
    this.isVisible = function() { return this.visible; };
    
    this.getX = function() { return this.x; };
    this.getY = function() { return this.y; };
    this.setX = function(x) { this.x = x; };
    this.setY = function(y) { this.y = y; };
    this.getScrollX = function() { return 0; };
    this.getScrollY = function() { return 0; };
    
    this.getWidth = function() { return this.width; };
    this.getHeight = function() { return this.height; };
    this.setWidth = function (w) { this.width = w; };
    this.setHeight = function(h) { this.height = h; };
    
    this.getVirtualWidth = function() { return this.getWidth(); };
    this.getVirtualHeight = function() { return this.getHeight(); };
    
    this.getBackground = function() { return this.background; };
    this.setBackground = function(c) { this.background = c; };
    
    this.getForeground = function() { return this.foreground; };
    this.setForeground = function(c) { this.foreground = c; };

    if (prt) {
        prt.children.push(this);
    }
    
    this.getChildren = function() { return this.children; };
    this.isSelected = function() { return this.selected; };
    this.setSelected = function(b) { this.selected = b; };
    
    this.getAbsX = function() {
        var x = 0;
        var prt = this;
        
        while (prt) {
            x += prt.getX()-prt.getScrollX();
            prt = prt.getParent();
        }
        
        return Math.round(x*this.getTopMost().getZoom());
    };

    this.getAbsY = function() {
        var x = 0;
        var prt = this;
        
        while (prt) {
            x += prt.getY()-prt.getScrollY();
            prt = prt.getParent();
        }
        
        return Math.round(x*this.getTopMost().getZoom());
    };
    
    this.getAbsWidth = function() {
       return Math.round(this.getWidth()*this.getTopMost().getZoom());
    };
    
    this.getAbsHeight = function() {
        return Math.round(this.getHeight()*this.getTopMost().getZoom());
    };
    
    this.paint2d = function(ctx) {
        var children = this.getChildren();
        
        for(var i=0;i<children.length;i++) {
            if (children[i].isVisible()) {
                children[i].paint2d(ctx);
            }
        }
    };
    
    this.paintSelected = function(ctx) {
        if (this.isSelected()) {
            var x = this.getAbsX();
            var y = this.getAbsY();
            var w = this.getAbsWidth();
            var h = this.getAbsHeight();
            
            ctx.fillStyle = "#000";
            ctx.fillRect(x-5, y-5, 5, 5);
            ctx.fillRect(x+w/2, y-5, 5, 5);
            ctx.fillRect(x+w, y-5, 5, 5);
            ctx.fillRect(x+w, y+h/2, 5, 5);
            ctx.fillRect(x+w, y+h, 5, 5);
            ctx.fillRect(x+w/2, y+h, 5, 5);
            ctx.fillRect(x-5, y+h, 5, 5);
            ctx.fillRect(x-5, y+h/2, 5, 5);
            
            
        }
    };
    
    this.intersects = function(x, y) {
        if(
                this.getX()<=x&&
                this.getX()+this.getWidth()>=x&&
                this.getY()<=y&&
                this.getY()+this.getHeight()>=y 
         ) {
            return true;
         } else {
             return false;
         }
    };
    
    this.getZObjectAt = function(x, y) {
        var cmp = null;
        
        if (this.isVisible()&&this.intersects(x, y)) {
           var rx = x-this.getX()+this.getScrollX();
           var ry = y-this.getY()+this.getScrollY();
           var children = this.getChildren();
           
           cmp = this;
           
           for(var i = 0;i<children.length;i++) {
               var z = children[i].getZObjectAt(rx, ry);
               
               if (z!=null) {
                   cmp = z;                   
                   break;
               }
           }
           }
           
           return cmp;
    };
    
    this.onmousedown = function(x, y) {
        this.setSelected(true);
    };
    this.onmousedrag = function(x1, y1, x2, y2) {
        
        if (this.isSelected()) {
            var xdrag = x2-x1;
            var ydrag = y2-y1;
            
            this.setX(this.getX()+xdrag);
            this.setY(this.getY()+ydrag);
            this.getTopMost().repaint();
        }
        
    };
    this.onmouseup = function(x, y) {
        this.setSelected(false);
    };
    
    this.propagateMouseup = function(child, x, y) {
        
        if (child.isVisible()&&child.intersects(x, y)) {
            var rx = x-child.getX();
            var ry = y-child.getY();
            
            child.onmouseup(rx, ry);
            return true;
        }
        
        return false;
    };
    this.propagateMousedown = function(child, x, y) {
        
        
        if (child.isVisible()&&child.intersects(x, y)) {
            var rx = x-child.getX();
            var ry = y-child.getY();
            child.onmousedown(rx, ry);
            return true;
        }
        
        return false;
    };
    this.propagateMousedrag = function(child, x1, y1, x2,y2) {
        
        if (child.isVisible()&&child.intersects(x1, y1)) {
            var rx1 = x1-child.getX();
            var ry1 = y1-child.getY();
        
            var rx2 = x2-child.getX();
            var ry2 = y2-child.getY();
            
            child.onmousedrag(rx1, ry1, rx2, ry2);
            return true;
        }
        
        return false;
    };
    
}


function ZAccessory(prt, o) {
    ZObject.call(this, prt);
    
    this.classname = "ZAccessory";
    this.orientation = o;
    this.gap = 5;
    
    this.getGap = function() { return this.gap; };
    this.setGap = function(x){ this.gap = x; };
    
    
    this.getRelativeX = function(x) {
        var nx = x-this.getParent().getX();
        
        switch(this.orientation) {
            case 1: nx -= this.getGap();
                break;
            case 3: nx += this.getGap();
                break;
        }
  
        return nx;
    };
    
  this.getRelativeY = function(y) {
        var ny = y-this.getParent().getY();
        
        switch(this.orientation) {
            case 0: ny += this.getGap();
                break;
            case 2: ny -= this.getGap();
                break;
        }
  
        return ny;
    };
    
    this.tryMousedown = function(x, y) {
        var nx = this.getRelativeX(x);
        var ny = this.getRelativeY(y);
        
        if (this.intersects(nx, ny)) {
            this.onmousedown(nx, ny);
            return true;
        }
        return false;
    };
    
    this.tryMouseup = function(x, y) {
        var nx = this.getRelativeX(x);
        var ny = this.getRelativeY(y);
        
        if (this.intersects(nx, ny)) {
            this.onmouseup(nx, ny);
            return true;
        }
        return false;
    };
    
    this.tryMousedrag = function(x1, y1, x2, y2) {
        var nx1 = this.getRelativeX(x1);
        var ny1 = this.getRelativeY(y1);
        var nx2 = this.getRelativeX(x2);
        var ny2 = this.getRelativeY(y2);
        
        if (this.intersects(nx1, ny1)) {
            this.onmousedrag(nx1, ny1, nx2, ny2);
            return true;
        }
        return false;
    };
    
      
    this.relIntercects = function(x, y) {
         return this.intersects(this.getRelativeX(x), this.getRelativeY(y));
    };


    this.getX = function() {
        switch(this.orientation) {
            case 0:            
            case 2:
            case 3:
                return 0;
            case 1:
                return this.getParent().getWidth()+this.getGap();
        }
        
        return 0;
    };
    
    this.getY = function() {
        switch(this.orientation) {
            case 0:            
            case 1:
            case 3:
                return 0;
            case 2:
                return this.getParent().getHeight()+this.getGap();
        }
        
        return 0;
    };
    
    this.getWidth = function() {
        switch(this.orientation) {
            case 0:            
            case 2:
                return this.getParent().getWidth();
            case 1:
            case 3:
                return this.width;
        }
        
        return 0;
    };
    
    this.getHeight = function() {
        switch(this.orientation) {
            case 0:            
            case 2:
                return this.height;
            case 1:
            case 3:
                return this.getParent().getHeight();
        }
        
        return 0;
    };
    
}

function ZScrollBar(prt, o) {
    ZAccessory.call(this, prt, o);
    
    this.classname = "ZScrollBar";
    this.maximum = 20;
    this.value = 0;
    
    this.setWidth(16);
    this.setHeight(16);
    
    this.setBackground("#555");
    this.setForeground("#aaa");
    
    this.getMaximum = function() { return this.maximum; };
    this.setMaximum = function(m) { this.maximum = m>0?m:1; };
    
    this.getValue = function() { return this.value; };
    this.setValue = function(v) { 
        var s = this.orientation==0||this.orientation==2?this.getWidth():this.getHeight();
        if (v<0)
            v = 0;
        
        if (v+s>this.getMaximum()) {
            v = this.getMaximum()-s;
        }
        
        this.value = v; 
        //document.getElementById('debug').innerHTML = v;
    };


    this.paint2d = function(ctx) {
        var s = (this.orientation==0||this.orientation==2 ? this.getWidth():this.getHeight());
        if (this.getMaximum()<=s) {
            return;
        }
        
        var x = this.getAbsX();
        var y = this.getAbsY();
        var z = this.getTopMost().getZoom();
        var desloc = Math.round(this.getValue()*(s)/this.getMaximum()*z);
        var size = Math.round((s/this.getMaximum())*s*z);
        
        ctx.fillStyle = this.getBackground();
        ctx.strokeStyle = this.getForeground();
        
        switch(this.orientation) {
            case 0:
            case 2:
                ctx.fillRect(x+Math.round(desloc), y, size, this.getAbsHeight());
                break;
            case 1:
            case 3:
                ctx.fillRect(x, y+Math.round(desloc), this.getAbsWidth(), size);
                break;
        }
    };
    
    this.onmousedrag = function(x1, y1, x2, y2) {
         
        if (this.orientation==0||this.orientation==2) {
            var factor = this.getMaximum()/this.getAbsWidth();
            this.setValue(this.getValue()+Math.round((x2-x1)*factor));
        } else {
            var factor = this.getMaximum()/this.getAbsHeight();
            this.setValue(this.getValue()+Math.round((y2-y1)*factor));
        }
        this.getTopMost().repaint();
    };
}

function ZPanel(prt) {
    ZObject.call(this, prt);
    
    this.classname = "ZPanel";
    this.activePanel = false;
    this.oldParent = null;
    
    this.right = new ZScrollBar(this, 1);
    this.bottom = new ZScrollBar(this, 2);
    this.right.setMaximum(0);
    this.bottom.setMaximum(0);
    
    this.setVirtualWidth = function(x) { this.bottom.setMaximum(x); };
    this.getVirtualWidth = function () { return this.bottom.getMaximum(); };
    this.setVirtualHeight = function(x) { this.right.setMaximum(x); };
    this.getVirtualHeight = function () { return this.right.getMaximum(); };
    this.isShowScrollBarX = function() { return this.getVirtualWidth()>this.getWidth();};
    this.isShowScrollBarY = function() { return this.getVirtualHeight()>this.getHeight(); };
    
    this.paintScrollBars = function(ctx) {
        if (this.isSelected()&&this.isShowScrollBarY()) {
            this.right.paint2d(ctx);
        }
        if (this.isSelected()&&this.isShowScrollBarX()) {
            this.bottom.paint2d(ctx);
        }
        
    };
    this.setActivePanel = function(b) { 
        this.activePanel = b; 
        if (b) {
            this.oldParent = this.getParent(); 
            this.setParent(null);
        } else {
            this.setParent(this.oldParent);
            this.oldParent = null;
        }
    };
    
    this.onmousedownOld = this.onmousedown;
    this.onmousedown = function(x, y) {
        
        if (this.isActivePanel()) {
            var children = this.getChildren();
        
            for(var i=0;i<children.length;i++) {
                var child = children[i];
        
                if (child.isVisible()&&child.intersects(x, y)) {
                    child.onmousedown(x-child.getX(), y-child.getY());
                    break;
                }
            }
        } else {
            this.propagateMousedown(this.bottom, x, y);
            this.propagateMousedown(this.right, x, y);
            this.onmousedownOld(x, y);
            
        }
    };
    this.onmousedragOld = this.onmousedrag;
    this.onmousedrag = function(x1, y1, x2, y2) {
        if(this.isActivePanel()) {
            var children = this.getChildren();
        
            for(var i=0;i<children.length;i++) {
                var child = children[i];
        
                if (child.isVisible()&&child.intersects(x1, y1)) {
                    child.onmousedrag(x1-child.getX(), y1-child.getY(), x2-child.getX(), y2-child.getY());
                    break;
                }
            }
            
        } else {
            var b = this.propagateMousedrag(this.bottom, x1, y1, x2, y2);
            var r = this.propagateMousedrag(this.right, x1, y1, x2, y2);
            
            if (!b&&!r) {
                this.onmousedragOld(x1, y1, x2, y2);
            } else {
                this.getTopMost().repaint();
            }
            
        }
    };
    
    this.onmouseupOld = this.onmouseup;
    this.onmouseup = function(x,y) {
        
        if (this.isActivePanel()) {
            var children = this.getChildren();
        
            for(var i=0;i<children.length;i++) {
                var child = children[i];
        
                if (child.isVisible()&&child.intersects(x, y)) {
                    child.onmouseup(x-child.getX(), y-child.getY());
                    break;
                }
            }
        } else {
            
            this.propagateMouseup(this.bottom, x, y);
            this.propagateMouseup(this.right, x, y);
            this.onmouseupOld(x, y);
            
        }
    };
    
    this.isActivePanel = function() { return this.activePanel; };
    
    
};


function ZRootPanel(canvasid) {
    ZPanel.call(this, null);
    
    this.activePanel = true;
    
    this.canvas = document.getElementById(canvasid);
    this.canvas.rootprt = this;
    
    this.setWidthOld = this.setWidth;
    this.setWidth = function(w) {
        this.setWidthOld(w);
        this.canvas.width = w;
    };
    
    this.setHeightOld = this.setHeight;
    this.setHeight = function(w) {
        this.setHeightOld(w);
        this.canvas.height = w;
    };


    
    if ("ontouchstart" in document.documentElement) {
        this.canvas.addEventListener('touchstart', function(e) {
            var t = e.changedTouches[0]; 
            var r = getTarget(e).rootprt;
            
            r.onmousedown(t.clientX, t.clientY);
            r.lastX = t.clientX;
            r.lastY = t.clientY;
            e.preventDefault();
    }, false);
    
        this.canvas.addEventListener('touchmove', function(e) {
            var t = e.changedTouches[0]; 
            var r = getTarget(e).rootprt;
            
            r.onmousedrag(r.lastX, r.lastY, t.clientX, t.clientY);
            r.lastX = t.clientX;
            r.lastY = t.clientY;
            e.preventDefault();
    }, false);
    
        this.canvas.addEventListener('touchend', function(e) {
            var t = e.changedTouches[0]; 
            var r = getTarget(e).rootprt;
            
            r.onmouseup(t.clientX, t.clientY);
            r.lastX = t.clientX;
            r.lastY = t.clientY;
            e.preventDefault();
    }, false);
    
    
    } else {
    
    this.canvas.onmousedown = function(evt) {
        var e = getEvent(evt);
        var z = getTarget(e).rootprt.getTopMost().getZoom();
        
        getTarget(e).rootprt.setSelected(true);
        getTarget(e).rootprt.onmousedown(Math.round(e.clientX/z), Math.round(e.clientY/z));
        getTarget(e).rootprt.lastX = e.clientX;
        getTarget(e).rootprt.lastY = e.clientY;
        
    };
    
    this.canvas.onmousemove = function(evt) {
        var e = getEvent(evt);
        var r = getTarget(e).rootprt;
        
        if (r.isSelected()) {
            var z = r.getTopMost().getZoom();
            r.onmousedrag(Math.round(r.lastX/z), Math.round(r.lastY/z), Math.round(e.clientX/z), Math.round(e.clientY/z));
            r.lastX = e.clientX;
            r.lastY = e.clientY;
        }
    };
    
    this.canvas.onmouseup =  function(evt) {
        var e = getEvent(evt);
        var z = getTarget(e).rootprt.getTopMost().getZoom();
        
        getTarget(e).rootprt.onmouseup(Math.round(e.clientX/z), Math.round(e.clientY/z));
        getTarget(e).rootprt.setSelected(false);
    };
    
    this.canvas.onmouseout = function(evt) {
        var e = getEvent(evt);
        
        getTarget(e).rootprt.setSelected(false);
    };
    }
    
    this.repaint = function() {
        var ctx = this.canvas.getContext("2d");
        
        ctx.fillStyle = this.getBackground();
        ctx.strokeStyle = this.getForeground();
        ctx.fillRect(0, 0, this.getWidth(), this.getHeight());
        
        this.paint2d(ctx);
    };
    
    this.getZoom = function() {
        return 1;
    };
    
}



