module KeyboardHelper
  
  def load_keyboard
    body =""
    body << render(:partial => 'keyboard/keyboard')
    @content_for_body = (@content_for_header || '') + body
    head=""
    head << javascript_include_tag('Keyboard')
    head << javascript_include_tag('classdealer')
    head << stylesheet_link_tag('keyboard.css')
    head << '
    <script type="text/javascript">
	WindowLoad.registerCall(function() {
		new Keyboard();
	})
    </script>'
    @content_for_header = (@content_for_header || '') + head 
 end

  def text_field_with_keyboard(object, method, options = {})
    options['id']=object+"_"+method+"_id"
    scr ='
<script type="text/javascript">
WindowLoad.registerCall(function(){
document.getElementById("'+options['id']+'").addEventListener("focus",function(e) {
e.target.blur();
Keyboard.kbd.open(e.target.value,function(str){e.target.value=str;});
   },false);
});
</script>'
     @content_for_header = (@content_for_header || '') + scr 
     text_field(object,method,options)
  end


end
