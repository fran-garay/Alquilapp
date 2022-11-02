# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :check_if_admin_logged_in, only: [:new, :create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def check_if_admin_logged_in
    if admin_signed_in?
      redirect_to :admins_root
      flash[:alert] = "Ya hay un administrador logueado"
    end
  end

end
