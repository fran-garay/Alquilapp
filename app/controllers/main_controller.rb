class MainController < ApplicationController
  before_action :check_if_logged_in

  def home
  end

  def check_if_logged_in
    if admin_signed_in?
      redirect_to "/admins"
    # elsif supervisor_signed_in?
    #   redirect_to :supervisors_root
    elsif user_signed_in?
      redirect_to "/users"
    else
      redirect_to "/users"
    end
  end
end
