class PicturesController < ApplicationController
   layout "buy"

def index
   @user = params[:id]
end

def shot
    @user = params[:id]
    
    system "wget '#{WEBCAM_URL}?mode=single' -O #{IMAGES_PATH}/people/snap.jpg"
end

def save
    @user = User.find(params[:id])

    uid_string=sprintf "%04d", @user.id
    filename=Dir.glob("#{IMAGES_PATH}/people/#{uid_string}_*.jpg").sort.last
    pid_string= if filename 
                  sprintf "%04d", File.basename(filename, ".jpg").split("_")[1].to_i+1
                else
                  "000"
                end
    system "mv #{IMAGES_PATH}/people/snap.jpg #{IMAGES_PATH}/people/#{uid_string}_#{pid_string}.jpg"
    @user.picture = "/images/people/#{uid_string}_#{pid_string}.jpg"
    unless @user.save
      puts "************************************** could not update picture infos for user #{@user.id}"
    end
    redirect_to :controller => "buy", :action => "show_state", :id => @user.id
end

end
