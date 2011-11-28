var pos = 0;
var ctx = null;
var cam = null;
var image = null;

var filter_on = false;
var filter_id = 0;
var spinner = null;


function setup_webcam() {
  jQuery("body").append("<div id=\"flash\"></div>");
  jQuery("#preview").hide();
  jQuery("#spinner").hide();
  // var canvas = document.getElementById("canvas");  
  // if (canvas.getContext) {
  //  ctx = document.getElementById("canvas").getContext("2d");
  //  ctx.clearRect(0, 0, 320, 240);
  // 
  //  var img = new Image();
  //  img.src = "/images/jquery_webcam_logo.gif";
  //  img.onload = function() {
  //    ctx.drawImage(img, 129, 89);
  //  }
  //  image = ctx.getImageData(0, 0, 320, 240);
  // }
  
  $("#camera").webcam({
    width: 320,
    height: 240,
    mode: "save",
    swffile: "/swf/jscam.swf",
    onTick: function(remain) {
      console.debug("onTick");
      if (0 == remain) {
          jQuery("#status").text("Cheese!");
          jQuery("#spinner").show();          
      } else {
          jQuery("#status").text("Shooting in " + (remain+1) + " seconds...");
      }
    },
    // this is called for every line of the picture
  	onSave: function(data) {
      console.debug("onSave");
      //      var col = data.split(";");
      //      var img = image;
      // for(var i = 0; i < 320; i++) {
      //  var tmp = parseInt(col[i]);
      //  img.data[pos + 0] = (tmp >> 16) & 0xff;
      //  img.data[pos + 1] = (tmp >> 8) & 0xff;
      //  img.data[pos + 2] = tmp & 0xff;
      //  img.data[pos + 3] = 0xff;
      //  pos+= 4;
      // }
      //      if (pos >= 0x4B000) {
      //        ctx.putImageData(img, 0, 0);
      //        pos = 0;
      //      }
      jQuery("#status").text(" ");
      jQuery("#status").hide();
      jQuery("#trigger").show();
      jQuery("#spinner").hide();
      jQuery("#preview img").replaceWith("<img src='pictures/preview?'+d.getTime() />");
      jQuery("#preview").show();
  	},
    onCapture: function () {
      console.debug("onCapture in");
      webcam.save('http://localhost:3000/pictures/shot');
      console.debug("onCapture out");
      // webcam.save('http://localhost/~cangiani/ruditeria/shot.php');
    },
    // debug: function (type, string) {
    //   $("#debugstatus").html(type + ": " + string);
    // },    
    onLoad: function() {
      console.debug("onLoad");
      // if (jQuery("#debug").length > 0) {
      //   jQuery("#debug").append("<ul>");
      //   var cams = webcam.getCameraList();
      //   for(var i in cams) {
      //       jQuery("#debug").append("<li><a href='javascript:set_cam("+i+");'>" + cams[i] + "</a></li>");
      //   }
      //   jQuery("#debug").append("</ul>");        
      // }
    },
  });
}

function do_capture() {
  console.debug("do_capture");
  jQuery("#trigger").hide();
  jQuery("#preview").hide();
  jQuery("#status").show();
  webcam.capture(3);
  // changeFilter();
  void(0);
}

function set_cam(i) {
  webcam.setCamera(i);
}