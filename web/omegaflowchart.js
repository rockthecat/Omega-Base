

function ZProcess(prt) {
    ZPanel.call(this, prt);
    
    this.intercectszpanel = this.intersects;
    this.intersects = function(x, y) {
        //alert(x+'x'+ y);
        
        
        return this.intercectszpanel(x, y)||
                this.right.relIntercects(x, y)||
                this.bottom.relIntercects(x, y);
    };
    
    this.onmousedownzpanel = this.onmousedown;
    this.onmousedown = function(x, y) {
        if (!this.right.tryMousedown(x, y)&&!this.bottom.tryMousedown(x, y)) {
            this.onmousedownzpanel(x, y);
        }
    };
    
    this.onmouseupzpanel = this.onmouseup;
    this.onmouseup = function(x, y) {
        if (!this.right.tryMouseup(x, y)&&!this.bottom.tryMouseup(x, y)) {
            this.onmouseupzpanel(x, y);
        }
    };
    
    this.onmousedragzpanel = this.onmousedrag;
    this.onmousedrag = function(x1, y1, x2, y2) {
        if (!this.right.tryMousedrag(x1, y1, x2, y2)&&!this.bottom.tryMousedrag(x1, y1, x2, y2)) {
            this.onmousedragzpanel(x1, y1, x2, y2);
        }
    };
    
    
    this.paint2d = function(ctx) {
        var x = this.getAbsX();
        var y = this.getAbsY();
        var w = this.getAbsWidth();
        var h = this.getAbsHeight();
        ctx.fillStyle = this.getBackground();
        ctx.strokeStyle = this.getForeground();
        
        ctx.fillRect(x, y, w, h);
        ctx.strokeRect(x, y, w, h);
        
        this.paintScrollBars(ctx);
        this.paintSelected(ctx);
    };
}