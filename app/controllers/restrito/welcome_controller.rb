class Restrito::WelcomeController < ApplicationController
  layout 'restrito' 
  before_action :authenticate_admin!
  def index
    @local = 'Informativos'
  end
end
