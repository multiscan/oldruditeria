require 'fileutils'
class PicturesController < ApplicationController
  layout "pictures"

  def index
    @user = params[:id]
    session[:user_id]=params[:id]
  end

  def shot
    # File.open(tmp_pic_path(), 'wb') {|file| file.write(request.raw_post.scan(/../).map{ |b| b.to_i(16) }.pack('C*'))}
    File.open(tmp_pic_path(), 'wb') {|file| file.write(request.raw_post)}
  end

  def preview
    File.open(tmp_pic_path(), 'rb') do |f|
      send_data f.read, :type => "image/jpeg", :disposition => "inline"
    end
  end

  def save
    @user = User.find(params[:id])

    uid_string=sprintf "%04d", @user.id
    filename=Dir.glob("#{IMAGES_PATH}/people/#{uid_string}_*.jpg").sort.last
    pid = File.basename(filename, ".jpg").split("_")[1].to_i+1
    pid_string = filename ? sprintf("%04d", pid) : "000"
    name="/images/people/#{uid_string}_#{pid_string}.jpg"
    path="#{IMAGES_PATH}/people/#{uid_string}_#{pid_string}.jpg"
    FileUtils.mv(tmp_pic_path(), path)
    @user.picture = name
    unless @user.save
      puts "************************************** could not update picture infos for user #{@user.id}"
    end
    redirect_to :controller => "buy", :action => "show_state", :id => @user.id
  end

 private

  def tmp_pic_path()
    puts "params[:id]=#{params[:id]}  session[:id]=#{session[:user_id]}"
    res="/tmp/ruditeria_tmp_pic_#{params[:id]||session[:user_id]}.jpg"
    puts "tmp_pic_path=#{res}"
    return res
  end
end
