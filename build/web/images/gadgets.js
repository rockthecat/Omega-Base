
/*Menus*/
function XHideMenus() {
	for(var i=0;i<objects.length;i++) {
		if (objects[i].isXMenu) {
			objects[i].close();
		}
	}
}

function XMenu(prt, x, y) {
	XObject.call(this, prt);

	this.div.style.display = "none";
	this.div.style.left = x;
	this.div.style.top = y;
	this.isXMenu = true;
	this.movable = false;
	
	
	
	if (prt) {
		prt.appendChild(this.div);
	} else {
		document.getElementById("div_main").appendChild(this.div);
	}
	
	
	this.setBody = function(inn) {
		this.div.innerHTML = inn;
	}
	
	this.getBody = function() {
		return this.div.innerHTML;
	}
	
	this.show = function() {
		this.div.style.display = "block";
	}
	
	this.close = function() {
		this.div.style.display = "none";
	}
	
	this.repaint = function() {
		if (xinput_mode==1) {
			this.div.className = "xmenu";
		} else {
			this.div.className = "xtouchpad_menu";
		}
	}
	
	this.setLayer(4);
	this.repaint();
}



function XToolBar() {
	XObject.call(this, null);
	this.isXToolBar = true;
	this.div.className = "xtoolbar";
	
	
	
	this.dimensionable = false;
	this.movable = true;
	
	this.repaint = function() {
		
	}
	
	document.getElementById("div_main").appendChild(this.div);
}
