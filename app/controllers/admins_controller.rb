class AdminsController < ApplicationController
  layout "for_admins"
  before_action :authenticate_admin!
  def index
    # flash.keep
  end

  def listar_usuarios
    @users = User.all.order(:first_name)
  end

  def listar_supervisores
    @supervisors = Admin.all.where(is_admin: false).order(:first_name)
  end

  # GET /resource/edit
  def edit
    logger.debug "Editando admin"
    @admin = Admin.find(params[:id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :id, :is_admin, :first_name, :last_name, :phone, :birth_date])
  end

  def showUser
    @user = User.find(params[:id])
  end

  # def layout_by_resource
  #   if admin_signed_in?
  #     "for_admins"
  #   else
  #     "application"
  #   end
  # end

  def updateUserStatus
    logger.debug "Actualizando estado de usuario"
    logger.debug "DEBUG : #{params[:id]}"
    @user = User.find(params[:id])
    @user.status = user_params[:status]
    if !@user.save
      @user.errors.add(:status, "No se pudo actualizar, intenta mas tarde")
    end
    redirect_to "admins/showUser/#{params[:id]}"
  end

  def user_params
    params.require(:user).permit(:status)
  end

end
