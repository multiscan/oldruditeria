ScreenSaver.start = function() {
  if (ScreenSaver.ss==null) {
    ScreenSaver.ss==new ScreenSaver(300000);
  }
  ScreenSaver.ss.start();
}

ScreenSaver.resetTimeout = function() {
  if (ScreenSaver.ss==null) {
    ScreenSaver.ss==new ScreenSaver(300000);
  }
  ScreenSaver.ss.resetTimeout();
}

ScreenSaver.stop = function() {
  if (ScreenSaver.ss==null) {
    ScreenSaver.ss==new ScreenSaver(300000);
  }
  ScreenSaver.ss.stop();
}

ScreenSaver.init = function() {
  if (ScreenSaver.ss==null) {
    ScreenSaver.ss==new ScreenSaver(300000);
  }
  ScreenSaver.ss.init();
}

ScreenSaver.logout = function() {
  ScreenSaver.ss.logout();
}

function ScreenSaver(time,action) {
  this.time = time;
  switch (action) {
  case "logout":
    this.action=ScreenSaver.logout;
    break;
  case "blacken":
  default:
    this.action=ScreenSaver.start;
  }
}

ScreenSaver.prototype.init = function() {
  this.blackness = document.createElement("div");
  this.blackness.setAttribute("class","inactive");
  this.blackness.setAttribute("id","screensaver");
  document.getElementsByTagName("body")[0].appendChild(this.blackness);
  this.timer = null;  
  window.onmousedown = ScreenSaver.resetTimeout;
  this.resetTimeout();
}

ScreenSaver.prototype.resetTimeout = function() {
  if (this.timer) {
    window.clearTimeout(this.timer);
  }
  this.timer = window.setTimeout(this.action,this.time);
}

ScreenSaver.prototype.start = function() {
  if (this.timer) {
    window.clearTimeout(this.timer);
    this.timer = null;  
  }
  this.blackness.setAttribute("class","active");
  this.blackness.onmousedown = ScreenSaver.stop;
}

ScreenSaver.prototype.stop = function() {
  this.blackness.onmousedown = null;
  this.blackness.setAttribute("class","inactive");
}

ScreenSaver.prototype.logout = function() {
  window.location="/buy/login?screensaver=save";
}
