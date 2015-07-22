/*Global*/
var screen_w;
var screen_h;
var margin_x = 0;
var margin_w = 0;
var margin_h = 0;
var margin_y = 32;
var xinput_mode = 1;


function XArrayRmv(array, obj) {
	var a = new Array();
	
	for(var i=0;i<array.length;i++) {
		if (array[i]!=obj) {
			a.push(array[i]);
		}
	}
	
	return a;
}


/*Event Manager*/
var XEventManager = null;

function XEventMgr() {
	this.hook = function(obj) {
	}
	this.unhook = function(obj) {
	}
	
	
	this.hookMain = function() {
	}
	this.unhookMain = function() {
	}
	
	
	this.getName = function() {
		return "Generic Event Manager";
	}
	
	this.getDescription = function() {
		return "Generic Event Manager";
	}
	
}



function _w3c_onmousedown(evt) {
	
	if (evt.target.winprt)	
		evt.target.winprt.doMouseDown(evt.clientX, evt.clientY);
}

function _w3c_onmousemove(evt) {
	
	if (evt.target.winprt)	
		evt.target.winprt.doMouseMove(evt.clientX, evt.clientY);
}

function _w3c_onmouseup(evt) {
	
	if (evt.target.winprt) 
		evt.target.winprt.doMouseUp(evt.clientX, evt.clientY);
}

function _w3c_onmouseout(evt) {
	
       	if (evt.target.winprt)
		evt.target.winprt.doMouseOut(evt.clientX, evt.clientY);
}

function _w3c_main_onmousemove(evt) {

	for(var i=0;i<objects.length;i++) {
		var obj = objects[i];
		
		
		if (obj.clicked) {
			switch(obj.dragging) {
			case 1:
				obj.doMouseMove(evt.clientX, evt.clientY-3);
				break;
			case 2:
				obj.doMouseMove(evt.clientX+3, evt.clientY);
				break;
				
			case 3:
				obj.doMouseMove(evt.clientX, evt.clientY+3);
				break;
			case 4:
				obj.doMouseMove(evt.clientX-3, evt.clientY);
				break;
			}
		}
	}

}


function _w3c_main_onmouseup(event) {
	if (target==document.getElementById("div_main")) 
	{
	
		for(var i=0;i<objects.length;i++) {
			var obj = objects[i];
	
			obj.setClicked(false);
		}
	}

}


function XW3CMouseEvt() {
	XEventMgr.call(this);
	
	this.hook = function(obj) {
		obj.div.onmousedown = _w3c_onmousedown;
		obj.div.onmousemove = _w3c_onmousemove;
		obj.div.onmouseup = _w3c_onmouseup;
		obj.div.onmouseout = _w3c_onmouseout;
	}
	
	this.unhook = function() {
		obj.div.onmousedown = null;
		obj.div.onmousemove = null;
		obj.div.onmouseup = null;
		obj.div.onmouseout = null;	
	}
	
	this.hookMain = function() {
		var m = document.getElementById("div_main");
		
		m.onmouseup = _w3c_main_onmouseup;
		m.onmousemove = _w3c_main_onmousemove;
	}
	
	this.unhookMain = function() {
		var m = document.getElementById("div_main");
		
		m.onmouseup = null;
		m.onmousemove = null;
	}
}


function XIE7MouseEvt() {
	XEventMgr.call(this);
	
	this.hook = function(obj) {
		obj.div.onmousedown = function(event) {
	var evt = event ? event : window.event;
	var target = evt.target ? evt.target : evt.srcElement;
	
	if (target.winprt)	
		target.winprt.doMouseDown(evt.clientX, evt.clientY);
		
		}
		
		
		obj.div.onmousemove = function(event) {
	var  evt = event ? event : window.event;
	var target = evt.target ? evt.target : evt.srcElement;
	
	if (target.winprt)	
		target.winprt.doMouseMove(evt.clientX, evt.clientY);
		
		}
		
		
		
		obj.div.onmouseup = function(event) {
	var  evt = event ? event : window.event;
	var target = evt.target ? evt.target : evt.srcElement;
	
	if (target.winprt) 
		target.winprt.doMouseUp(evt.clientX, evt.clientY);
		}
		
		
		obj.div.onmouseout = function(event) {
	var  evt = event ? event : window.event;
	var target = evt.target ? evt.target : evt.srcElement;
	
       	if (target.winprt)
		target.winprt.doMouseOut(evt.clientX, evt.clientY);
		
		}
	}
	
	this.unhook = function() {
		obj.div.onmousedown = null;
		obj.div.onmousemove = null;
		obj.div.onmouseup = null;
		obj.div.onmouseout = null;	
	}
	
	this.hookMain = function() {
		var m = document.getElementById("div_main");
		
		m.onmouseup = function(event) {
	var  evt = event ? event : window.event;
	var target = evt.target ? evt.target : evt.srcElement;

	if (target==document.getElementById("div_main")) 
	{
	
		for(var i=0;i<objects.length;i++) {
			var obj = objects[i];
	
			if (xinput_mode==2&&obj.clicked&&(obj.movable||obj.dimensionable) ) {
				obj.doMouseMove(evt.clientX, evt.clientY);
				obj.doMouseUp(evt.clientX, evt.clientY);
			}
			
			obj.setClicked(false);
		}
	}

			
		}
		
		
		m.onmousemove = function(event) {
	var  evt = event ? event : window.event;
	

	for(var i=0;i<objects.length;i++) {
		var obj = objects[i];
		
		
		if (obj.clicked) {
			switch(obj.dragging) {
			case 1:
				obj.doMouseMove(evt.clientX, evt.clientY-3);
				break;
			case 2:
				obj.doMouseMove(evt.clientX+3, evt.clientY);
				break;
				
			case 3:
				obj.doMouseMove(evt.clientX, evt.clientY+3);
				break;
			case 4:
				obj.doMouseMove(evt.clientX-3, evt.clientY);
				break;
			}
		}
	}

		
		}
	}
	
	this.unhookMain = function() {
		var m = document.getElementById("div_main");
		
		m.onmouseup = null;
		m.onmousemove = null;
	}
}



function XW3CTouchEvt() {
	XEventMgr.call(this);
	
	this.hook = function(obj) {
		obj.div.ontouchstart = function(event) {
	
	if (event.target.winprt)	
		event.target.winprt.doMouseDown(event.touches[0].clientX, event.touches[0].clientY);
		}
		
		
		obj.div.ontouchmove = function(event) {
	
	if (event.target.winprt) {
			event.target.winprt.doMouseMove(event.touches[0].clientX, event.touches[0].clientY);
			event.preventDefault();
		}
		}
		
		
		
		obj.div.ontouchend = function(event) {
	
		if (event.target.winprt) 
			event.target.winprt.doMouseUp(event.touches[0].clientX, event.touches[0].clientY);
		}
		
		obj.div.ontouchcancel = obj.div.ontouchend;
		
	}
	
	this.unhook = function() {
		obj.div.ontouchstart = null;
		obj.div.ontouchmove = null;
		obj.div.ontouchend = null;
		obj.div.ontouchcancel = null;	
	}
	
	this.hookMain = function(event) {
		var m = document.getElementById("div_main");
		
		m.ontouchend = function(event) {

	if (event.target==document.getElementById("div_main")) 
	{
	
		for(var i=0;i<objects.length;i++) {
		
			var obj = objects[i];
	
			if (xinput_mode==2&&obj.clicked&&(obj.movable||obj.dimensionable) ) {
				obj.doMouseMove(event.touches[0].clientX, event.touches[0].clientY);
				obj.doMouseUp(event.touches[0].clientX, event.touches[0].clientY);
			}
			
			obj.setClicked(false);
		}
	}

			
		}
		
		
		m.ontouchmove = function(evt) {
	

	for(var i=0;i<objects.length;i++) {
		var obj = objects[i];
		
		
		if (obj.clicked) {
			switch(obj.dragging) {
			case 1:
				obj.doMouseMove(evt.touches[0].clientX, evt.touches[0].clientY-3);
				break;
			case 2:
				obj.doMouseMove(evt.touches[0].clientX+3, evt.touches[0].clientY);
				break;
				
			case 3:
				obj.doMouseMove(evt.touches[0].clientX, evt.touches[0].clientY+3);
				break;
			case 4:
				obj.doMouseMove(evt.touches[0].clientX-3, evt.touches[0].clientY);
				break;
			}
		}
	}

		
		evt.preventDefault();
		}
	}
	
	this.unhookMain = function() {
		var m = document.getElementById("div_main");
		
		m.ontouchcancel = null;
		m.ontouchmove = null;
	}
}





/*Objects*/
var objects = new Array();

function XObject(prt) {
	this.div = document.createElement("div");
	this.div.style.position = "absolute";
	this.div.winprt = this;
	this.div.style.zIndex = 1;
	this.isXObject = true;
	this.dimensionable = false;
	this.clicked = false;
	this.movable = false;
	this.dragging = 0;
	objects.push(this);
	this.children = new Array();
	this.width = 150;
	this.height = 32;
	this.div.style.width = "150px";
	this.div.style.height = "32px";
	this.visible = false;
	this.parent = prt;
	this.posX = 0;
	this.posY = 0;
	/*
	this.div.onmousedown = _xobject_onmousedown;
	this.div.onmousemove = _xobject_onmousemove;
	this.div.onmouseup = _xobject_onmouseup;
	this.div.onmouseout = _xobject_onmouseout;
	*/
	XEventManager.hook(this);
	
	
	if (prt) {
		this.parent.children.push(this);
	}
	
	this.setDimensionable = function(d) {
		this.dimensionable = d;
	}
	this.isDimensionable = function() {
		return this.dimensionable;
	}

	this.getLayer = function() {
		return this.div.style.zIndex;
	}
	
	this.setLayer = function(i) {
		this.div.style.zIndex = i;
	}
	
	this.setClicked = function(c) {
		if (c) 
		for(var i=0;i<objects.length-1;i++) {
			objects[i].clicked = false;
		}
		
		this.clicked = c;
	}
	
	this.isClicked = function() {
		return this.clicked;
	}
	
	this.setPos = function(x, y) {
		this.posX = x;
		this.posY = y;
		
		this.div.style.left = this.posX+"px";
		this.div.style.top = this.posY+"px";
	}

	this.doMouseDown = function(x, y) {
	
		if (this.movable||this.dimensionable) {
			this.setClicked(true);
		}
		
		this.sX = x;
		this.sY = y;
		this.setSelected(true);
		
		if (this.dimensionable) {

			if (Math.abs(y-this.posY)<5) {
				this.dragging = 1;
			} else if (Math.abs(x-this.posX)<5) {
				this.dragging = 4;
			} else if (Math.abs(y-this.posY-this.height)<5) {
				this.dragging = 3;
			} else if (Math.abs(x-this.posX-this.width)<5) {
				this.dragging = 2;
			} else {
				this.dragging = 0;
			}
		}
		
		
		
	}
	
	this.doMouseMove = function(x, y) {
		if (this.clicked&&this.movable&&!this.dimensionable) {
			this.posX +=x-this.sX;
			this.posY +=y-this.sY;
			
			this.div.style.left = this.posX+"px";
			this.div.style.top = this.posY+"px";
			
			this.sX = x;
			this.sY = y;
			
		} else if (this.clicked&&this.dimensionable) {
			var i;
			
			switch(this.dragging) {
			case 0:
				this.posX +=x-this.sX;
				this.posY +=y-this.sY;
			
				this.div.style.left = this.posX+"px";
				this.div.style.top = this.posY+"px";
			
				this.sX = x;
				this.sY = y;
				break;
			
			case 1:
				this.height -= y-this.posY;
				this.posY = y;
				
				
			
				this.div.style.top = this.posY+"px";
				this.div.style.height = this.height+"px";
				break;
				
			case 2:
				this.width = x-this.posX;
				
				this.div.style.width = this.width+"px";
				break;
				
			case 3:
				this.height = y-this.posY;
				
				this.div.style.height = this.height+"px";
				break;
				
			case 4:
				this.width -= x-this.posX;
				this.posX = x;
				
				this.div.style.left = this.posX+"px";
				this.div.style.width = this.width+"px";
				break;
			
			} 						
		}
		
	
		if (this.dimensionable) {
			if (Math.abs(y-this.posY)<5) {
				this.div.style.cursor = "ns-resize";				
			} else if (Math.abs(x-this.posX)<5) {
				this.div.style.cursor = "ew-resize";				
			} else if (Math.abs(y-this.posY-this.height)<5) {
				this.div.style.cursor = "ns-resize";				
			} else if (Math.abs(x-this.posX-this.width)<5) {
				this.div.style.cursor = "ew-resize";				
				
			} else {
				this.div.style.cursor = "";
			}
		}	
	}
	
	this.doMouseUp = function(x, y) {
		for(var i=0;i<objects.length;i++) {
			objects[i].setClicked(false);
		}
	}
	
	this.doMouseOut = function(x, y) {
		//this.clicked = false;
	}
	
	this.setSelected = function(s) {
	}
	
	this.isSelected = function() {
		return false;
	}
	
	
	
	this.destroy = function() {
		for(var i=0;i<this.children.length;i++) {
			this.children[i].destroy();
		}
		
		objects = XArrayRmv(objects, this);
		
		if (this.visible) {
			this.div.parentNode.removeChild(this.div);
		}
		
		if (this.parent) {
			this.parent.children = XArrayRmv(this.parent.children, this);
		}
	}
	
	this.repaint = function() {
		
	}
	
	this.setVisible = function(vis) {
		if (vis) {
			if (!this.visible) {
				if (this.parent) {
					this.parent.div.appendChild(this.div);
				} else {
					document.getElementById("div_main").appendChild(this.div);
				}
			}
		} else {
			if (this.visible) {
				this.div.parentNode.removeChild(this.div);
			}
		}
		
		this.visible = vis;
	}
	
	this.isVisible = function() {
		return this.visible;
	}
	
	
	this.toFront = function() {
		if (this.visible) {
			var prt = this.div.parentNode;

			prt.removeChild(this.div);
			prt.appendChild(this.div);
			
			this.div.focus();
		}
	}
	
	return this;
}

function XRepaintAll() {
	for(var i=0;i<objects.length;i++) {
		objects[i].repaint();
	}
}






function _xwindow_close(event) {
	var evt = event ? event : window.event;
	var  target = evt.target ? evt.target : evt.srcElement;
	
	if (target.winprt)
		target.winprt.doClose();
}

function _xwindow_maximize(event) {
	var evt = event ? event : window.event;
	var  target = evt.target ? evt.target : evt.srcElement;

	if (target.winprt)
		target.winprt.doMaximize();
}

function _xwindow_minimize(event) {
	var evt = event ? event : window.event;
	var  target = evt.target ? evt.target : evt.srcElement;
	
	if (target.winprt)
		target.winprt.doMinimize();
}

function _xwindow_dimensione(event) {
	var evt = event ? event : window.event;
	var  target = evt.target ? evt.target : evt.srcElement;
	
	if (target.winprt)
		target.winprt.doDimensione();
}



function XWindow(prt, w, h) {
	XObject.call(this, prt);
	
	this.div.style.left = "100px";
	this.div.style.top = "50px";
	this.div.style.width = w+"px";
	this.div.style.height = h+"px";
	this.isXWindow = true;
	this.selected = false;
	this.titlebar = false;
	this.maximizable = false;
	this.minimizable = false;
	this.closable = false;
	this.movable = true;
	this.dimensionable = true;
	this.status = 1;
	this.sX = 0;
	this.sY = 0;
	this.posX = 100;
	this.posY = 50;
	this.state = 2;
	this.div.className = "xwindow";
	this.width = w;
	this.height = h;
	

	this.div_titlebar = document.createElement("div");
	this.div_titlebar.className = "xtitlebar";
	this.div.appendChild(this.div_titlebar);
	
	this.span_close = document.createElement("button");
	//this.span_close.type = "button";
	this.span_close.className = "xclose";
	this.span_close.winprt = this;
	this.span_close.onmouseup = _xwindow_close;
	this.div_titlebar.appendChild(this.span_close);

	this.span_maximize = document.createElement("button");
	//this.span_maximize.type = "button";
	this.span_maximize.className = "xmaximize";
	this.span_maximize.winprt = this;
	this.span_maximize.onmouseup = _xwindow_maximize;
	this.div_titlebar.appendChild(this.span_maximize);
	
	this.span_dimensione = document.createElement("button");
	//this.span_dimensione.type = "button";
	this.span_dimensione.className = "xdimensione";
	this.span_dimensione.style.display = "none";
	this.span_dimensione.winprt = this;
	this.span_dimensione.onmouseup = _xwindow_dimensione;
	this.div_titlebar.appendChild(this.span_dimensione);
	

	this.span_minimize = document.createElement("button");
	//this.span_minimize.type = "button";
	this.span_minimize.winprt = this;
	this.span_minimize.onmouseup = _xwindow_minimize;
	this.span_minimize.className = "xminimize";
	this.div_titlebar.appendChild(this.span_minimize);

	this.span_icon = document.createElement("span");
	this.span_icon.className = "xwinicon";
	this.span_icon.winprt = this;
	this.div_titlebar.appendChild(this.span_icon);


	this.span_title = document.createElement("span");
	this.span_title.className = "xwintitle";
	this.div_titlebar.appendChild(this.span_title);
	this.div_titlebar.winprt = this;
//	this.div_titlebar.onmousemove = _xobject_onmousemove;
	
	this.setTitle = function(title) {
		this.span_title.innerHTML = title;
	}
	
	this.getTitle = function() {
		return this.span_title.innerHTML;
	}
	
	
	this.setMaximizable = function(max) {
		this.maximizable = max;
		this.repaint();
	}
	
	this.isMaximizable = function() {
		return this.maximizable;
	}
	
	this.setMinimizable = function(min) {
		this.minimizable = min;
		this.repaint();
	}
	
	this.isMinimizable = function() {
		return this.minimizable;
	}
	
	this.getState = function() {
		return this.state;
	}
	
	this.setState = function(st) {
		switch(st) {
		case 1:
			if (this.state!=1) {
				this.saveX = this.posX;
				this.saveY = this.posY;
				this.saveW = this.div.style.width;
				this.saveH = this.div.style.height;
				this.div.style.display = "none";
				this.state = 1;
			}
			break;
		case 2:
			if (this.state!=2) {
				this.div.style.display = "";
				this.div.style.left = this.saveX+"px";
				this.div.style.top = this.saveY+"px";
				this.div.style.width = this.saveW;
				this.div.style.height = this.saveH;
				this.span_maximize.style.display = "";
				this.span_dimensione.style.display = "none";				
				this.state = 2;
				this.dimensionable = true;
			}
			break;
		case 3:
			if (this.state!=3) {
				this.div.style.display = "";
				this.saveX = this.posX;
				this.saveY = this.posY;
				this.saveW = this.div.style.width;
				this.saveH = this.div.style.height;
				this.div.style.left = (margin_x)+"px";
				this.div.style.top = (margin_y)+"px";
				this.div.style.width = (screen_w-margin_x-margin_w)+"px";
				this.div.style.height = (screen_h-margin_y-margin_h)+"px";
				this.span_maximize.style.display = "none";
				this.span_dimensione.style.display = "";				
				this.state = 3;
				this.dimensionable = false;
			}
			break;
			
		}
	}
	
	this.isSelected = function() {
		return this.selected;
	}
	
	
	this.setSelected = function(sel) {
		if (!this.div.parentNode) return;
		
		if (sel==true) {
			for(var i=0;i<objects.length;i++) {
				if (objects[i]!=this&&objects[i].isXWindow) {
					objects[i].setSelected(false);
				}
			}
			
			this.toFront();
		}
		
		this.selected = sel;
		
		if (sel&&xinput_mode==1) {
			this.div.className = "xwindow";
			this.span_close.className = "xclose";
			this.span_minimize.className = "xminimize";
			this.span_maximize.className = "xmaximize";
			this.span_dimensione.className = "xdimensione";
			this.div_titlebar.className = "xtitlebar";
		} else if (xinput_mode==1) {
			this.div.className = "xinactive_window";
			this.span_close.className = "xinactive_close";
			this.span_minimize.className = "xinactive_minimize";
			this.span_maximize.className = "xinactive_maximize";
			this.span_dimensione.className = "xinactive_dimensione";
			this.div_titlebar.className = "xinactive_titlebar";
		} else {
			this.span_close.className = "xtouchpad_close";
			this.span_minimize.className = "xtouchpad_minimize";
		}
	}
	
	this.repaint = function() {
		if (xinput_mode==2) {
			if (this.getState()==2) {
				this.setState(3);
			}
			
			this.span_dimensione.style.display = "none";
			this.span_maximize.style.display = "none";
			this.span_close.className = "xtouchpad_close";
			this.span_minimize.className = "xtouchpad_minimize";
			
		} else {
		        switch(this.getState()) {
			case 3:
				this.span_dimensione.style.display = "";
				break;
			case 2:
				this.span_maximize.style.display = "";
				break;
			}
		}
	}
	
	this.doClose = function() {
		this.destroy();
	}

	this.doMaximize = function() {
		this.setState(3);
	}
	this.doMinimize = function() {
		this.setState(1);
	}
	this.doDimensione = function() {
		this.setState(2);
	}

	
	this.XObjectdoMouseMove = this.doMouseMove;
	this.doMouseMove = function(x, y) {
		if (this.state==2) {
			this.XObjectdoMouseMove(x, y);
		}
	}
	
	this.repaint();
	
}





/*Common*/
function XInit() {
	var agent = navigator.userAgent;
	if (agent.match(/Android/i)||agent.match(/BlackBerry/i)||agent.match(/iPhone|iPad|iPod/i)||agent.match(/Opera Mini/i)||agent.match(/IEPhone/i)) {
		xinput_mode = 2;
	}
	
	
	if (agent.indexOf("Trident/")==-1&&xinput_mode==1) {
		XEventManager = new XW3CMouseEvt();
	} else if (xinput_mode==1) {
		XEventManager = new XIE7MouseEvt();
	} else {
		XEventManager = new XW3CTouchEvt();
	}


        XEventManager.hookMain();
	if (window.innerHeight) {
		screen_h = window.innerHeight;
		screen_w = window.innerWidth;
	} else {
		screen_h = document.documentElement.clientHeight;
		screen_w = document.documentElement.clientWidth;
	}
	

	document.getElementById("div_main").style.width = screen_w+"px";
	document.getElementById("div_main").style.height = screen_h+"px";
	//document.getElementById("div_main").onmouseover = _xdiv_main_onmousemove;
	//document.getElementById("div_main").onmouseup = _xdiv_main_onmouseup;
	
	
}

function XOnClick() {
	XHideMenus();
	
	return true;
}
