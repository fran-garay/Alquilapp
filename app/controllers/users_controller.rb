class UsersController < ApplicationController
  layout "for_users"
  before_action :authenticate_user!

  def index
    @user = current_user
    @autos = Auto.all.order(anio: :desc)
  end

  def vehiculo
    @user = current_user
    @auto = Auto.find(params[:id])
    @precio = Precio.last
    @alquiler = Alquiler.new
  end

  def vista_alquiler
    logger.debug "user_is_not_renting? #{user_is_not_renting?}"
    if user_is_not_renting?
      redirect_to users_path and return
    end
    @alquiler = Alquiler.find(current_user.alquiler_id)
    @auto = Auto.find(@alquiler.auto_id)
    @tiempo_restante = @alquiler.hora_devolucion - Time.now
    # change tiempo_restante to format hh:mm:ss
    @tiempo_restante = Time.at(@tiempo_restante).utc.strftime("%H:%M:%S")
    @tiempo_fin = @alquiler.hora_devolucion - 3.hours
    @tiempo_fin = Time.at(@tiempo_fin).utc.strftime("%H:%M:%S")

    # split @tiempo_fin to get hour, minutes and seconds
    # @hora_fin = @tiempo_fin.split(":")[0]
    # @minutos_fin = @tiempo_fin.split(":")[1]
    # @segundos_fin = @tiempo_fin.split(":")[2]
  end

  def alquilar
    parametros = alquiler_params
    @user = current_user
    @auto = Auto.find(params[:auto_id])
    total_horas = (parametros[:fecha_devolucion].to_d - parametros[:fecha_alquiler].to_d).to_i * 24
    total_precio = total_horas * Precio.last.valor
    if no_tiene_saldo?(total_precio)
      @precio = Precio.last
      @user.errors.add(:base, "No tienes suficiente dinero para alquilar este auto")
      render "/users/vehiculo" and return
    end
    if la_hora_es_menor_a_la_actual_y_el_dia_es_hoy?(parametros[:fecha_devolucion], parametros[:hora_devolucion])
      @precio = Precio.last
      @user.errors.add(:base, "La hora de devolución debe ser mayor a la hora actual")
      render "/users/vehiculo" and return
    end
    @alquiler = Alquiler.new
    @alquiler.user_id = current_user.id
    @alquiler.auto_id = params[:auto_id]
    @alquiler.fecha_alquiler = Date.today
    @alquiler.fecha_alquiler = Time.now
    @alquiler.fecha_devolucion = parametros[:fecha_devolucion]
    @alquiler.hora_devolucion = parametros[:hora_devolucion]
    @alquiler.save
    @user.alquiler_id = @alquiler.id
    @user.is_renting = true
    @user.save
    @auto.alquiler_id = @alquiler.id
    @auto.estado = "Ocupado"
    @auto.save
    @wallet = @user.wallet
    @wallet.saldo = @wallet.saldo - total_precio
    @wallet.save
    redirect_to users_vista_alquiler_path
  end

  def finalizar_alquiler
    @alquiler = Alquiler.find(current_user.alquiler_id)
    @alquiler.fecha_devolucion = Date.today
    @alquiler.hora_devolucion = Time.now
    @alquiler.save
    @auto = Auto.find(@alquiler.auto_id)
    @auto.alquiler_id = nil
    @auto.estado = "Disponible"
    @auto.save
    current_user.alquiler_id = nil
    current_user.is_renting = false
    current_user.save
    redirect_to users_path
  end

  def alquiler_params
    params.require(:alquiler).permit(:user_id, :auto_id, :fecha_inicio, :hora_inicio, :fecha_devolucion, :hora_devolucion)
  end



  # def layout_by_resource
  #   if user_signed_in?
  #     "for_users"
  #   else
  #     "application"
  #   end
  # end

  def vista_mapa
    @autos = Auto.all
  end

  def user_is_not_renting?
    current_user.alquiler_id.nil?
  end

  def certificado
    @alquiler = Alquiler.find(current_user.alquiler_id)
    @auto = Auto.find(@alquiler.auto_id)
    @user = current_user
  end

  def no_tiene_saldo?(total_precio)
    current_user.wallet.saldo < total_precio
  end

  def la_hora_es_menor_a_la_actual_y_el_dia_es_hoy?(fecha_devolucion, hora_devolucion)
    logger.debug "DEBUGS "
    logger.debug "fecha_devolucion #{fecha_devolucion}"
    logger.debug "fecha_devolucion.to_date #{fecha_devolucion.to_date}"
    logger.debug "Date.today #{Date.today.to_s}"
    logger.debug "Date.today #{Date.today.to_s == fecha_devolucion}"
    logger.debug "Time.now #{Time.now > hora_devolucion}"
    # Date.today.
    fecha_devolucion == Date.today.to_s && hora_devolucion < Time.now
  end

end
