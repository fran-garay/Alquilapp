class AdminsController < ApplicationController
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

  # PUT /resource
  # def update
  #   logger.debug "Actualizando admin"
  #   @admin = Admin.find(params[:id])
  #   if @admin.update(admin_params)
  #     redirect_to admins_listar_supervisores_path, notice: "Supervisor actualizado exitosamente"
  #   else
  #     render :edit
  #   end
  # end

  # def agregar_supervior
  #   if (!current_admin.is_admin?)
  #     redirect_to admins_path
  #   @supervisor = Admin.new
  # end

  # def crear_supervisor
  #   @supervisor = Admin.new(admin_params)
  #   @supervisor.is_admin = true
  #   if @supervisor.save
  #     redirect_to admins_path
  #   else
  #     render :agregar_supervisor
  #   end
  # end

  # def admin_params
  #   params.require(:admin).permit(:email, :password, :password_confirmation)
  # end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :id, :is_admin, :first_name, :last_name, :phone, :birth_date])
  end
end
