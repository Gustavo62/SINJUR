class Restrito::WelcomeController < ApplicationController
  layout 'restrito' 
  before_action :authenticate_admin!
  def index
    @local = 'Home.'
  end
  def info
    @local = 'Informativos.'
  end
  def tutoriais
    @local = 'Tutoriais.'
  end
end
