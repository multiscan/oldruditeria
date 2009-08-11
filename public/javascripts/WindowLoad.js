function WindowLoad() {

}

WindowLoad.registerCall = function(call) {
  var old_event = window.onload;
  if (typeof window.onload != 'function')
    window.onload = function() {call();};
  else  
    window.onload = function() {old_event(); call();};
}





