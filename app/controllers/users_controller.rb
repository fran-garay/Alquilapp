class UsersController < ApplicationController
  layout "for_users"
  before_action :authenticate_user!

  def index

    # flash.keep
    @user = current_user
  end

  # def layout_by_resource
  #   if user_signed_in?
  #     "for_users"
  #   else
  #     "application"
  #   end
  # end

  def vista_mapa
    @autos = Auto.all
  end

end
