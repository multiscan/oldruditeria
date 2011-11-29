var shot_timeout = 3;

function setup_webcam() {
  webcam.set_api_url( '/pictures/create' );
  webcam.set_quality( 90 ); // JPEG quality (1 - 100)
  webcam.set_shutter_sound(true,"/swf/shutter.mp3" ); // play shutter click sound
  webcam.set_swf_url("/swf/jpegcam.swf");
  webcam.set_hook('onComplete', 'do_preview()');
  
  jQuery("#camera").prepend(webcam.get_html(320, 240))

  jQuery("#shot_button").show();
  jQuery("#save_button").hide();
  jQuery("#reset_button").hide();
}

function start_countdown() {
  show_timeout = 3;
  jQuery("#status").show();
  jQuery("#shot_button").hide();
  jQuery("#save_button").hide();
  jQuery("#reset_button").hide();
  countdown();
}

function countdown() {
  var msg;
  switch(shot_timeout) {
    case 0:
      msg="Click";
      do_capture();
      break;
    case 1:
      msg="Cheese!";
    default:
      msg="Shooting in " + shot_timeout + " seconds...";
  }
  jQuery("#status").text(msg);
  if (shot_timeout>0) {
    shot_timeout = shot_timeout - 1;
    window.setTimeout('countdown()', 1000);    
  } else {
    do_capture();
  }
}

function do_capture() {
  window.setTimeout('jQuery("#status").hide()', 500);
  webcam.freeze();
  jQuery("#shot_button").hide();
  jQuery("#save_button").show();
  jQuery("#reset_button").show();
}

function do_save(user_id) {
  webcam.upload();
  window.location = "/buy/show_state?id="+user_id;
}

function do_preview() {
  jQuery("#save_button").show();
  jQuery("#reset_button").show();
  jQuery("#status").hide();
}

function do_reset() {
  jQuery("#shot_button").show();
  jQuery("#save_button").hide();
  jQuery("#reset_button").hide();
  jQuery("#status").hide();
  webcam.reset();
}
