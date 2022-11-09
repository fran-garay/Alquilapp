# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout :layout_by_resource
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :first_name, :last_name, :phone, :birth_date])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :first_name, :last_name, :phone, :birth_date])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  def layout_by_resource
    if user_signed_in?
      "for_users"
    else
      "application"
    end
  end

  def after_update_path_for(resource)
    # check if update was successful
    logger.debug "ACTUALIZANDOOOOOOOOOOOOOOOOOOOOOOO"
    if resource.errors.empty?
      user_path(resource)
    else
      render :edit
    end
  end
end
