# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  skip_before_action :set_minimum_password_length, only: [:edit, :update]
  skip_before_action :require_no_authentication
  before_action :authenticate_admin!
  before_action :configure_sign_up_params, only: [:create]
  before_action :check_if_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :configure_account_update_params, only: [:update]
  layout "for_admins"

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
    notice = "Admin creado exitosamente"
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
    notice = "Admin actualizado exitosamente"
  end

  # GET /resource/edit/:id
  def editSupervisor
    @admin = Admin.find(params[:id])
    render "/admins/registrations/edit_supervisor"
  end

  # PUT /resource/updateSupervisor/:id
  def updateSupervisor
    @admin = Admin.find(params[:id])
    parameters = admin_params

     # If current password is not valid then don't update
    if !@admin.valid_password?(parameters[:current_password])
      @admin.errors.add(:current_password, "Contraseña inválida")
      render "/admins/registrations/edit_supervisor"
    else
      # if password is blank then don't update it
      if parameters[:password].blank?
        parameters[:password] = parameters[:current_password]
        parameters[:password_confirmation] = parameters[:current_password]
      end
      parameters.delete(:current_password)
      if @admin.update(parameters)
        redirect_to admins_path, notice: "Supervisor actualizado exitosamente"
      else
        render "/admins/registrations/edit_supervisor"
      end
    end
  end

  # DELETE /resource/deleteSupervisor/:id
  def deleteSupervisor
    logger.debug "Deleting supervisor"
    @admin = Admin.find(params[:id])
    # destroy admin only if he is not handling any report
    if  !current_admin.is_admin
      redirect_to admins_path
    else
      if !@admin.is_handling_report
        @admin.destroy
        redirect_to "/admins/listar_supervisores", notice: "Supervisor eliminado exitosamente"
      else
        redirect_to "/admins/listar_supervisores", alert: "No se puede eliminar a #{@admin.first_name} porque está manejando un reporte"
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

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :is_admin, :first_name, :last_name, :phone, :birth_date, :current_password, :dni)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :is_admin, :first_name, :last_name, :phone, :birth_date, :dni])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :id, :is_admin, :first_name, :last_name, :phone, :birth_date, :dni])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    :admins_root
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    :admins_root
  end

  def check_if_admin
    if (current_admin == nil) || (!current_admin.is_admin)
      redirect_to :admins_root
    end
  end

  def sign_up(resource_name, resource)
    notice = "Admin created successfully"
    true
  end

end
