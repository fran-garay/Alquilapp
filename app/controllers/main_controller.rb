class MainController < ApplicationController
  before_action :check_if_logged_in

  def home
  end

  def check_if_logged_in
    if admin_signed_in?
      redirect_to :admins_root
    # elsif supervisor_signed_in?
    #   redirect_to :supervisors_root
    else
      redirect_to :users_root
    end
  end
end
