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
end
