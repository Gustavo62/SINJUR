class ApplicationController < ActionController::Base  
    protect_from_forgery with: :exception
    before_action :authenticate_admin!
    @local = nil 
    add_flash_types :info, :error, :warning  
    
end
