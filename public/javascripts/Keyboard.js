Keyboard.kbd=null;

function Keyboard() {
  this.div = document.getElementById("keyboard");
  document.getElementById("keyboard_ok").addEventListener("mousedown",this,false);
  document.getElementById("keyboard_cancel").addEventListener("mousedown",this,false);
  this.display=document.getElementById("display");
  while(this.display.firstChild!=null) {
    this.display.removeChild(this.display.firstChild);
  }
  var span=document.createElement("span");
  span.appendChild(document.createTextNode(""));
  addClass(span,"lastchar");
  this.display.appendChild(document.createTextNode(""));
  this.display.appendChild(span);
  this.numbers = document.getElementById("numbers");
  this.letters = document.getElementById("letters");
  this.addEvents(this.letters);
  this.addEvents(this.numbers);
  Keyboard.kbd=this;
}

Keyboard.prototype.open = function(text,callback) {
  this.callback=callback;
  replaceClass(this.div,"inactive","active");
  this.text=text;
  this.locked=false;
  this.shifted=false;
  this.setDisplay();
  this.setKeyboardShift();
}

Keyboard.prototype.addEvents = function(parentnode) {
  for (var node= parentnode.firstChild; node; node=node.nextSibling) {
    if (node.nodeName=="LI"){
      node.addEventListener("mousedown",this,false);
      var ol = node.getElementsByTagName("OL")[0]
      if (ol) { //add style events to simulate activate.
	ol.addEventListener("mousedown",
			    function(e) {
			      var ol = e.currentTarget;
			      ol.parentNode.style.borderStyle="inset";
			    },
			    false);
	ol.addEventListener("mouseup",
			    function(e) {
	  var ol = e.currentTarget;
	  ol.parentNode.style.borderStyle="";
	},
			    false);
	ol.addEventListener("mouseout",
			    function(e) {
	  var ol = e.currentTarget;
	  ol.parentNode.style.borderStyle="";
	},
			    false);
      }
    }
  }
}


Keyboard.prototype.close = function(makecall) {
  if (makecall) {
    this.callback(this.text);
  }
  replaceClass(this.div,"active","inactive");
}

Keyboard.prototype.lastChar = function() {
  var len = this.text.length;
  if (len>0) {
    return this.text.substr(len-1);
  } else {
    return "";
  }
}

Keyboard.prototype.removeLast = function() {
  var len = this.text.length;
  if (len>0) {
    return this.text.substr(0,len-1);
  } else {
    return "";
  }
}

Keyboard.prototype.setKeyboardShift = function() {
  for (var node= this.letters.firstChild; node; node=node.nextSibling) {
    if (node.nodeName=="LI"){
      var lis = node.getElementsByTagName("li");
      var type = (node.firstChild.nodeType==1)?
      node.firstChild.getAttribute("class"):null;
      if ("shift lock"==type) {
	if (this.locked) {
	  addClass(node,"down");
	} else {
	  removeClass(node,"down");
	}
      } else if ("shift"==type) {
	if (this.shifted ^ this.locked) {
	  addClass(node,"down");
	} else {
	  removeClass(node,"down");
	}	
      } else if ("special"==type) {
	if (this.shifted) {
	  replaceClass(lis[0],"keyactive","discrete");
	  replaceClass(lis[1],"discrete","keyactive");
	} else {
	  replaceClass(lis[1],"keyactive","discrete");
	  replaceClass(lis[0],"discrete","keyactive");
	}
      } else if (2==lis.length) {
	if (this.shifted) {
	  replaceClass(lis[0],"keyactive","keyinactive");
	  replaceClass(lis[1],"keyinactive","keyactive");
	} else {
	  replaceClass(lis[1],"keyactive","keyinactive");
	  replaceClass(lis[0],"keyinactive","keyactive");
	}
      }
    }
  }
}

Keyboard.prototype.setDisplay = function() {
  this.display.firstChild.nextSibling.style.color="";

  var len = this.text.length;
  var lastchar=this.display.firstChild.nextSibling.firstChild;
  this.display.firstChild.data=this.removeLast();
  if (this.lastChar()==" ") {
    this.display.firstChild.nextSibling.style.color="white";    
    lastchar.data="_";
  } else {
    lastchar.data=this.lastChar();
  }
}

Keyboard.prototype.addCharacter = function(character) {
  var last = this.lastChar();
  switch(last) {
  case "^":
    this.addDiacritic(character,"circ");
    break;
  case "¨":
    this.addDiacritic(character,"uml");
    break;
  case String.fromCharCode(180):
    this.addDiacritic(character,"acute");
    break;
  case String.fromCharCode(184):
    this.addDiacritic(character,"cedil");
    break;
  case String.fromCharCode(96):
    this.addDiacritic(character,"grave");
    break;
  case String.fromCharCode(126):
    this.addDiacritic(character,"tilde");
    break;
  case " ":
  case "":
    if (character==" ") { 
      break;
    }
  default:
    this.text=this.text+character;
  }
  this.setDisplay();
}

Keyboard.prototype.addDiacritic = function(character,diacritic) {
  var finalchar = character;
  switch(character) {
  case "a":
  case "e":
  case "i":
  case "o":
  case "u":
  case "y":
  case "A":
  case "E":
  case "I":
  case "O":
  case "U":
  case "Y":
  case "n":
  case "N":
  case "c":
  case "C":
  default:
    var div=document.createElement("div");
    div.innerHTML="&"+character+diacritic+";";
    finalchar=div.firstChild.data;
    break;
  }
  if (finalchar.length==1) { //add new char with diacritic
    this.text=this.removeLast()+finalchar;
  } else { //kill the diacritic and add new char
    this.text=this.removeLast();
    this.addCharacter(character);
  }
}

Keyboard.prototype.backSpace = function() {
  this.text=this.removeLast();
  this.setDisplay();
}

Keyboard.prototype.keypress = function(e) {
  var list = e.currentTarget.getElementsByTagName("ol")[0];
  var oldshifted=this.shifted;
  var oldlocked=this.locked;
  if (list) {
    var type = list.getAttribute("class");
    switch (type) {
    case "shift lock":
      if (this.locked) {
	this.locked = false;
	this.shifted = false;
      } else {
	this.locked = true;
	this.shifted = true;
      }
      break;
    case "shift":
      this.shifted = !this.shifted;
      break;
    case "backspace":
      this.backSpace();
      break;
    default:
      var character = list.getElementsByTagName("li")[(this.shifted)?1:0].firstChild.data;
      this.addCharacter(character);
      //after, kill the shift afterwards;
      this.shifted = this.locked;
    }
  } else {
    this.addCharacter(e.currentTarget.firstChild.data);
    //after, kill any shift that isn't locked
    this.shifted = this.locked;
  }

  // change the keyboard if necessary
  if (this.shifted!=oldshifted || this.locked != this.oldlocked) {
    this.setKeyboardShift();
  }
}

Keyboard.prototype.handleEvent = function(e) {
  var type = e.type;
  if ( this[type] != null ) this[type](e);
}

Keyboard.prototype.mousedown = function(e) {
  var id = e.currentTarget.getAttribute("id");
  switch(id) {
  case "keyboard_ok":
    this.close(true);
    break;
  case "keyboard_cancel":
    this.close(false);
    break;
  default:
    this.keypress(e);
  }
}

