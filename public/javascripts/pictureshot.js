// TODO: the API is nicer than what I use here. In fact it is possible to "freeze"
// the display of the camera and then save it. Instead of uploading each time the temp shot.

var spinner = null;
var shot_timeout = 3;

function setup_webcam() {
  
  webcam.set_api_url( '/pictures/shot' );
  webcam.set_quality( 90 ); // JPEG quality (1 - 100)
  webcam.set_shutter_sound(true,"/swf/shutter.mp3" ); // play shutter click sound
  webcam.set_swf_url("/swf/jpegcam.swf");
  webcam.set_hook('onComplete', 'do_preview');
  
  jQuery("#camera").prepend(webcam.get_html(320, 240))
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
  
}

function do_capture() {
  switch(shot_timeout) {
    case 0:
      shot_timeout = 3;
      jQuery("#spinner").show();
      webcam.snap();
      return;
    case 1:
      jQuery("#status").text("Cheese!");
      break;
    default:
      webcam.reset();
      jQuery("#preview").hide();
      jQuery("#status").text("Shooting in " + shot_timeout + " seconds...");
      jQuery("#status").show();
      break;
  }
  shot_timeout = shot_timeout - 1;
  window.setTimeout('do_capture()', 1000);
  return;
}

function do_preview() {
  jQuery("#status").hide();
  jQuery("#spinner").hide();
  jQuery("#preview img").replaceWith("<img src='/pictures/preview?'+Date.getTime() />");
  jQuery("#preview").show();
}