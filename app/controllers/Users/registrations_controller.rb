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
    if @user.save
      @wallet = Wallet.new
      @wallet.user_id = @user.id
      @wallet.saldo = 0
      @wallet.ultima_carga = 0
      @wallet.ultimo_gasto = 0
      @wallet.save
    end
  end

  # GET /resource/edit
  def edit
    @user = current_user
    super
  end

  # PUT /resource
  # def update
  #   self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  #   prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

  #   resource_updated = update_resource(resource, account_update_params)
  #   yield resource if block_given?
  #   if resource_updated
  #     set_flash_message_for_update(resource, prev_unconfirmed_email)
  #     bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

  #     respond_with resource, location: after_update_path_for(resource)
  #   else
  #     clean_up_passwords resource
  #     set_minimum_password_length
  #     logger.debug "DEBUG: #{resource.errors.any?}"
  #     respond_with resource, location: after_update_path_for(resource)
  #     # render :edit
  #   end
  # end

  # PUT /resource/updateUser
  def updateUser
    is_logged_in?
    @user = current_user
    parameters = user_params

     # If current password is not valid then don't update
    if !@user.valid_password?(parameters[:current_password])
      @user.errors.add(:current_password, "no es correcta")
      render "/users/registrations/edit"
    else
      # if password is blank then don't update it
      if parameters[:password].blank?
        parameters[:password] = parameters[:current_password]
        parameters[:password_confirmation] = parameters[:current_password]
      end
      parameters.delete(:current_password)
      if @user.update(parameters)
        bypass_sign_in(@user)
        @user.is_being_validated = true
        @user.save
        redirect_to users_path, notice: "Se ha actualizado exitosamente su información"
      else
        render "/users/registrations/edit"
      end
    end
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

  def user_params
    params.require(:user).permit(:licencia, :first_name, :last_name, :email, :password, :password_confirmation, :current_password, :phone, :birth_date, :license_valid_until)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:licencia, :attribute, :first_name, :last_name, :phone, :birth_date, :license_valid_until])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:licencia, :attribute, :first_name, :last_name, :phone, :birth_date, :license_valid_until])
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

  def is_logged_in?
    if !user_signed_in?
      redirect_to root_path
    end
  end

  # define path after failed update in devise



  def after_update_path_for(resource)
    # check if update was successful
    if !resource.errors.any?
      users_path
    else
      logger.debug "ACTUALIZANDOOO "
      "/users/edit"
    end
  end
end
