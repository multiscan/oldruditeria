function removeClass(element, classname) {
  var classes = getClassList(element);
  var index = indexOf(classname,classes);
  if (index >= 0) {
    classes.splice(index,1);
    setClassList(element,classes);
  }
}

function addClass(element, classname) {
  var classes = getClassList(element);
  if (indexOf(classname, classes)<0) {
    classes[classes.length]=classname;
    setClassList(element,classes);
  }
}

function replaceClass(element, oldclass, newclass) {
  removeClass(element,oldclass);
  addClass(element,newclass);
}

function getClassList(element) {
  if (element.className && element.className!="") {
    return element.className.split(' ');
  }
  return [];
}

function hasClass(element, classname) {
  var classes = getClassList(element);
  return (indexOf(classname, classes)>=0);
}

function setClassList(element, classlist) {
  element.className=classlist.join(' ');
}

function indexOf(element,array) {
  for (var i=0; i<array.length; i++) {
    if (array[i]==element) {
      return i;
    }
  }
  return -1;
}

