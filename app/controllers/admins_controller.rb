class AdminsController < ApplicationController
  layout :layout_by_resource
  before_action :authenticate_admin!
  def index
  end

  def listar_usuarios
    @users = User.all
  end

  def listar_supervisores
    @supervisors = Admin.all.where(is_admin: false)
  end

  # GET /resource/edit
  def edit
    logger.debug "Editando admin"
    @admin = Admin.find(params[:id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :id, :is_admin, :first_name, :last_name, :phone, :birth_date])
  end

  def layout_by_resource
    if admin_signed_in?
      "for_admins"
    else
      "application"
    end
  end
end
