class UsersController < ApplicationController
  layout :layout_by_resource
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def layout_by_resource
    if user_signed_in?
      "for_users"
    else
      "application"
    end
  end

end
