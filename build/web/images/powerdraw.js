var OBJECT = 1;
var LINE = 2;

function PowerCanvas(w, h, color) {
	this.children = new Array();
	this.width = w;
	this.height = h;
	this.color = color;
	
	this.icons = new Array();
	
	
	
	this.add = function(obj) {
		this.children.push(obj);
	}
	
	this.rmv = function(obj) {
		obj.setDead(true);
	}
	
	
	
	
	
	
	
	this.addIcon = function(icon) {
		this.icons.push(icon);
		
	}
	
	this.rmvIcon = function(icon) {
		icon.setDead(true);
		
		
	}
	
	this.arrangeIcons = function(w, h) {
		var cx = 0;
		var cy = 0;
	
		for(var i=0;i<this.icons.length;i++) {
			var d = this.icons[i];
			
			if (!d.getDead()) {
				d.x = cx;
				d.y = cy;
				
				if (cx+46 < w) {
					cx+=46;
				} else {
					cy+=46;
					cx = 0;
				}

			}
		}
	}
	
	
	
	
	
	this.drawIcons = function(canvas, w, h) {
		var c = canvas.getContext("2d");
		var fs = c.fillStyle;
		
		c.fillStyle = "#FFF";
		c.fillRect(0, 0, w, h);
		
		for(var i=0;i<this.icons.length;i++) {
			var d = this.icons[i];
			
			if (!d.getDead()) {
				d.draw(c);
			}
		}
	}
	
	
	this.onclickIcons = function(canvas, x, y) {
		for(var i=0;i<this.icons.length;i++) {
			var d = this.icons[i];
			
			if (!d.getDead()) {
				d.selected = false;
				
				if (x>=d.x&&y>=d.y&&
				x<=d.x+d.width&&y<=d.y+d.height) {
					d.selected = true;
				}
			}
		}
	
	}
}

function get100(max, b) {
	return (parseInt(b)*parseInt(max)) / 100;
}



function PowerObject(name, w, h, color, txt, inn) {
	this.width = w;
	this.height = h;
	this.x = 0;
	this.y = 0;
	this.can_explode = false;
	this.image = "";
	this.type = OBJECT;
	this.dead = false;
	this.children = new Array();
	this.text = txt;
	this.inn = inn;
	
	
	this.lastdrag_x = -1;
	this.lastdrag_y = -1;
	
	this.color = color;
	
	
	this.setColor = function(col) {
		this.color = col;
	}
	
	this.setDead = function(dead) {
		this.dead = dead;
	}
	
	
	this.draw = function(canvas, selected) {
	/*
	        var bodys = this.body.getElementsByTagName("body")[0];
		var bod = bodys.firstChild;
		
		canvas.fillStyle = this.color;
		
		while ( bod!=null ) {
		
			if (bod.nodeName=="moveto") {
				canvas.moveTo(get100(this.width, bod.getAttribute("x"))+this.x, get100(this.height, bod.getAttribute("y"))+this.y);
			} else if (bod.nodeName == "lineto") {
				canvas.lineTo(get100(this.width, bod.getAttribute("x"))+this.x, get100(this.height, bod.getAttribute("y"))+this.y);
			} else if (bod.nodeName == "arc") {
				canvas.arc(get100(this.width, bod.getAttribute("x"))+this.x, get100(this.height, bod.getAttribute("y"))+this.y, bod.getAttribute("z"), bod.getAttribute("angle1"), bod.getAttribute("angle2"));
			} else if (bod.nodeName == "text") {
				canvas.font = get100(this.width, bod.getAttribute("width"))+"px Arial font-size: 13px";
				canvas.fillText(this.text, get100(this.width, bod.getAttribute("x")), get100(this.height, bod.getAttribute("y")));
			}
			
			bod = bod.nextSibling;
		}
		
	*/
	
	
		
	}
	
	
	
	this.touches = function(x, y) {
		var r = false;
		
		switch(this.type) {
			case OBJECT:
			r = (x>=this.x&&x<=(this.x+this.width))&&
				(y>=this.y&&y<=(this.y+this.height));
			break;
			
			case LINE:
			r = (Math.abs(x-this.x)<=5)||(Math.abs(y-this.y-this.height)<=5);
			break;
		}
		return r;
	}
	
	
	this.doDrag = function(x, y) {
	if (this.lastdrag_x==-1&&this.lastdrag_y==-1) {
		this.lastdrag_x = x;
		this.lastdrag_y = y;
	} else {
		var x2 = x-this.lastdrag_x;
		var y2 = y-this.lastdrag_y;
		
		this.lastdrag_x = x;
		this.lastdrag_y = y;
		
		switch(this.type) {
		case OBJECT:
		break;
		
		case LINE:
		break;
		}	
	} 
	}
}




function PowerIcon(icon, id, name) {
	
	this.x = 0;
	this.y = 0;
	this.prt = null;
	this.icon = document.createElement("img");
	this.icon.src = icon; 
	this.dead = false;
	this.id = id;
	this.name = name;
	
	
	this.width = 46;
	this.height = 46;
	this.selected = false;
	
	this.getId = function() {
	return this.id;
	}
	
	this.draw = function(canvas) {
		if (this.selected) {
			canvas.fillStyle = "#88F";
			canvas.fillRect
			(this.x, this.y, 46, 46);
		} 
	
		canvas.drawImage(this.icon, this.x+8, this.y);
		
		canvas.font="10px Arial";
		canvas.fillStyle = "#000";
		canvas.fillText(this.name, this.x +(46 -canvas.measureText(this.name).width)/2, this.y+40, 46);
		
	}
	
	
	
	
	
	
	this.setDead = function(d) {
		this.dead = d;
	}
	
	this.getDead = function() {
		return this.dead;
	}
}





