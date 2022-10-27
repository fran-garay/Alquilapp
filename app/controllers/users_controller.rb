class UsersController < ApplicationController
  # def signout
  #   sign_out_and_redirect("/")
  # end

  # def new
  #   if session[:duplication_notice].present?
  #     flash.now[:alert] = session[:duplication_notice]
  #     session.delete(:duplication_notice)
  #   end
  #   super
  # end
  before_action :authenticate_user!
  def index
    puts("ENTRO ACA")
  end
end
