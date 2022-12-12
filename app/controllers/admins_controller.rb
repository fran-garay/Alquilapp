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

  def listar_no_validados
    @users = User.all.order(:created_at).where(status: "1")
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

  def estadisticas
    @autos = Auto.all
    @alquileres = Alquiler.all
    @alquileres_hoy = Alquiler.all.where(fecha_alquiler: Date.today)
    @usuarios = User.all

    if @alquileres_hoy.empty?
      
      @mas_alquilado_hoy = nil
      @dinero_recaudado_hoy = 0
      @mas_usado_hoy = nil
      @reportes_hoy = 0

    else
      @id_mas_alquilado_hoy = @alquileres_hoy.group(:auto_id).count.max_by{|k,v| v}[0]
      @mas_alquilado_hoy = Auto.find(@id_mas_alquilado_hoy)

      @dinero_recaudado_hoy = 0
      @alquileres_hoy.each do |alquiler|
        @dinero_recaudado_hoy += alquiler.precio_total
      end

      # @id_mas_usado_hoy = @alquileres_hoy.group(:auto_id).sum(:duracion).max_by{|k,v| v}[0]
      # @mas_usado_hoy = Auto.find(@id_mas_usado_hoy)

    end

    @usuarios_alquilando = Array.new
    for usuario in @usuarios
      if usuario.is_renting?
        @usuarios_alquilando.append(usuario)
      end
    end

  end

  def estadisticas_alquileres
    @autos = Auto.all
    @alquileres = Alquiler.all
    @id_mas_alquilado = @alquileres.group(:auto_id).count.max_by{|k,v| v}[0]
    logger.debug "ID MAS ALQUILADO: #{@id_mas_alquilado}"
    @mas_alquilado = Auto.find(@id_mas_alquilado)
    @id_menos_alquilado = @alquileres.group(:auto_id).count.min_by{|k,v| v}[0]
    logger.debug "ID MENOS ALQUILADO: #{@id_menos_alquilado}"
    @menos_alquilado = Auto.find(@id_menos_alquilado)
  end

  def estadisticas_ganancias
    @autos = Auto.all
    @alquileres = Alquiler.all
    @recaudado_mes = 0
    @alquileres.each do |alquiler|
      if alquiler.created_at.month == Date.today.month
        @recaudado_mes += alquiler.precio_total
      end
    end
  end

  def estadisticas_uso
    @autos = Auto.all
    @alquileres = Alquiler.all
  end

  def estadisticas_reportes
    @autos = Auto.all
    @alquileres = Alquiler.all
    @reportes = Reporte.all
    @reportes_mes = 0
    @reportes.each do |reporte|
      if reporte.created_at.month == Date.today.month
        @reportes_mes += 1
      end
    end

  end

  def estadisticas_en_curso
    @alquileres = Alquiler.all
    @autos = Auto.all
    @usuarios = User.all

    @usuarios_alquilando = Array.new
    for usuario in @usuarios
      if usuario.is_renting?
        @usuarios_alquilando.append(usuario)
      end
    end

    @alquileres_en_curso = Array.new
    for usuario in @usuarios_alquilando
      @alquileres_en_curso.append(@alquileres.where(user_id: usuario.id).last)
    end

  end

  def updateUserStatus
    @user = User.find(params[:user_id])

    if @user.is_renting?
      @user.errors.add(:base, "No se puede modificar el estado del Usuario dado que tiene un alquiler en curso")
    else
      @user.status = user_params[:status]
      if !@user.save
        @user.errors.add(:status, "No se pudo actualizar, intenta mas tarde")
      end
    end
    render "/admins/showUser"
  end

  def user_params
    params.require(:user).permit(:status)
  end

end
