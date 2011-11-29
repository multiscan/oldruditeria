require 'fileutils'
class PicturesController < ApplicationController
  layout "pictures"

  def new
    @user = User.find(params[:id] || session[:user_id])
    session[:user_id]=@user.id
  end
  
  def create
    @user = User.find(params[:id] || session[:user_id])
    uid_string=sprintf "%04d", @user.id
    basename = "people/#{uid_string}.jpg" 
    path="#{IMAGES_PATH}/#{basename}"
    purl="/images/#{basename}?v=#{Time.now.strftime("%s")}"
    File.open(path, 'wb') {|file| file.write(request.raw_post)}
    @user.picture = purl
    if (@user.save)
      render :text=>"ok"
    else
      render :text => "Error!"
    end
  end

end
