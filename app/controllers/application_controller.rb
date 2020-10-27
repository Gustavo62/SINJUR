class ApplicationController < ActionController::Base 
    add_flash_types :error, :warning, :success
    protect_from_forgery with: :exception
    before_action :authenticate_admin!
    @local = nil 
end
