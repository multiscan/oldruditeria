# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require_dependency "login_system"

class ApplicationController < ActionController::Base
#    include ExceptionNotifiable
    include LoginSystem
#    model :secure_user
end
