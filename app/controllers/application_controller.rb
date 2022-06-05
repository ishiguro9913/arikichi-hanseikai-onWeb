class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger, :notice
  # binding.pry
  # before_action :require_login

  # private
  # def not_authenticated
  #   redirect_to login_path, alert: "Please login first"
  # end 
  
end
