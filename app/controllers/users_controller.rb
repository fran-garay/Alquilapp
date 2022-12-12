class UsersController < ApplicationController
  layout "for_users"
  before_action :authenticate_user!

  def index
    if current_user.is_renting?
      redirect_to "/users/vista_alquiler" and return
    end
    @user = current_user
    @autos = Auto.all.where(estado: "Disponible").order(:modelo)
    # sort cars by distance using haversine distance function and current user location GRANDE FRAN
    if (session[:lat] !=nil && session[:lng] != nil)
      @autos = @autos.sort_by { |auto| haversine_distance(session[:lat], session[:lng], auto.location_point.x, auto.location_point.y) }
      # invert the order of the array
      # @autos = @autos.reverse
    end

  end

  def vehiculo
    @user = current_user
    @auto = Auto.find(params[:id])
    @precio = Precio.last
    if @user.is_renting?
      render "/users/vehiculo_si_esta_alquilando" and return
    end
    @autos = Auto.all.where(estado: "Disponible").order(:modelo)

    if (session[:lat] !=nil && session[:lng] != nil)
      @autos = @autos.sort_by { |auto| haversine_distance(session[:lat], session[:lng], auto.location_point.x, auto.location_point.y) }
    else
      @autos = @autos.sort_by { |auto| haversine_distance(@auto.location_point.x, @auto.location_point.y, auto.location_point.x, auto.location_point.y) }
    end
    # set @auto at the beginning of the array
    @autos.delete(@auto)
    @autos.unshift(@auto)
  end

  def haversine_distance(lat1, lon1, lat2, lon2)
    dLat = (lat2 - lat1) * Math::PI / 180
    dLon = (lon2 - lon1) * Math::PI / 180
    lat1 = lat1 * Math::PI / 180
    lat2 = lat2 * Math::PI / 180

    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    d = 6371 * c;
    return d
  end

  def vista_alquiler
    logger.debug "user_is_not_renting? #{user_is_not_renting?}"
    if user_is_not_renting?
      redirect_to users_path and return
    end
    @alquiler = Alquiler.find(current_user.alquiler_id)
    @auto = Auto.find(@alquiler.auto_id)

    @tiempo_fin = @alquiler.hora_devolucion
    @tiempo_fin = Time.at(@tiempo_fin).strftime("%H:%M:%S")
    @minutos_restantes = calcular_deferencia_minutos(@alquiler.fecha_user_devolucion, @alquiler.hora_devolucion, Date.today, Time.now)
    logger.debug "\n\n\n\n MINUTOS RESTANTES #{@minutos_restantes}\n\n\n\n"
    # split @tiempo_fin to get hour, minutes and seconds
    # @hora_fin = @tiempo_fin.split(":")[0]
    # @minutos_fin = @tiempo_fin.split(":")[1]
    # @segundos_fin = @tiempo_fin.split(":")[2]
  end

  def resumen

    @alquiler = Alquiler.where(user_id: current_user.id).last
    @auto = Auto.find(@alquiler.auto_id)

    @tiempo = "0d " + @alquiler.duracion.strftime("%Hh %Mm %Ss")
  end

  def alquilar
    parametros = alquiler_params
    @user = current_user
    @auto = Auto.find(params[:auto_id])

    fecha_devolucion = Date.parse(parametros[:fecha_devolucion])
    hora_devolucion = Time.parse(parametros[:hora_devolucion])

    horas_totales = calcular_deferencia_horas_ceil(fecha_devolucion, hora_devolucion, Date.today, Time.now) # redondeadas hacia arriba
    precio_total = horas_totales * Precio.last.valor


    logger.debug "\n\n\n\n\n\nPRECIO TOTAL #{precio_total}"
    logger.debug "HORA DEVOLUCION: #{hora_devolucion}\HORA DEVOLUCION #{horas_totales}\n\n\n\n\n"

    # difference_in_hours_between_today_and_date_value = ((Date.parse(parametros[:fecha_devolucion]).to_time- Date.today.to_time) / 1.hours).to_i

    # # # console.
    # hora_devolucion = parametros[:hora_devolucion].split(":")[0].to_i
    # minutos_devolucion = parametros[:hora_devolucion].split(":")[1].to_i
    # # get current hour
    # hora_alquiler = Time.now.hour.to_i
    # minutos_alquiler = Time.now.min.to_f

    # horas = hora_devolucion - hora_alquiler
    # minutos =  ((minutos_devolucion.to_f - minutos_alquiler)/60)
    # minutos = (minutos).ceil
    # total_horas = horas + minutos + difference_in_hours_between_today_and_date_value


    # precio_total = total_horas * Precio.last.valor
    @alquiler = Alquiler.new

    if no_tiene_saldo?(precio_total)
      @precio = Precio.last
      @autos = Auto.all.where(estado: "Disponible").order(:modelo)
      if (session[:lat] !=nil && session[:lng] != nil)
        @autos = @autos.sort_by { |auto| haversine_distance(session[:lat], session[:lng], auto.location_point.x, auto.location_point.y) }
      end
      # set @auto at the beginning of the array
      @autos.delete(@auto)
      @autos.unshift(@auto)
      @user.errors.add(:base, "No tienes suficiente dinero para alquilar este auto")
      render "/users/vehiculo" and return
    end

    if la_hora_es_menor_a_la_actual_y_el_dia_es_hoy?(parametros[:fecha_devolucion], parametros[:hora_devolucion])
      @precio = Precio.last
      @autos = Auto.all.where(estado: "Disponible").order(:modelo)
      if (session[:lat] !=nil && session[:lng] != nil)
        @autos = @autos.sort_by { |auto| haversine_distance(session[:lat], session[:lng], auto.location_point.x, auto.location_point.y) }
      end
      # set @auto at the beginning of the array
      @autos.delete(@auto)
      @autos.unshift(@auto)
      @user.errors.add(:base, "La hora de devolución debe ser mayor a la hora actual")
      render "/users/vehiculo" and return
    end

    @alquiler.user_id = current_user.id
    @alquiler.auto_id = params[:auto_id]
    @alquiler.fecha_alquiler = Date.today
    @alquiler.hora_alquiler = Time.now
    # fecha y hora que después se actualizarán con la hora de devolución
    @alquiler.fecha_devolucion = Date.parse(parametros[:fecha_devolucion])
    @alquiler.hora_devolucion = Time.parse(parametros[:hora_devolucion])
    # fecha y hora en las que el usuario piensa inicialmente que va a devolver el auto
    @alquiler.hora_user_devolucion =  @alquiler.hora_devolucion
    @alquiler.fecha_user_devolucion = @alquiler.fecha_devolucion
    @alquiler.precio_total = precio_total
    @alquiler.precio_de_reserva = precio_total
    @alquiler.duracion_en_cant_horas = horas_totales
    @alquiler.save

    @user.alquiler_id = @alquiler.id
    @user.is_renting = true
    @user.save

    @auto.alquiler_id = @alquiler.id
    @auto.estado = "Ocupado"
    @auto.save
    redirect_to users_vista_alquiler_path
  end

  def finalizar_alquiler
    if user_is_not_renting?
      redirect_to users_path and return
    end

    @alquiler = Alquiler.find(current_user.alquiler_id)

    @alquiler.fecha_devolucion = Date.today
    @alquiler.hora_devolucion = Time.now.utc

    @precio = calcular_precio_post_alquiler(@alquiler)

    @alquiler.precio_total = @precio
    @alquiler.save

    @wallet = current_user.wallet
    @wallet.saldo = @wallet.saldo - @precio
    @wallet.ultimo_gasto = @precio
    @wallet.save

    logger.debug "\n\n\n\n Duracion final #{Time.at(@alquiler.hora_devolucion - @alquiler.hora_alquiler).utc.strftime("%H:%M:%S")}\n\n\n\n"

    @alquiler.duracion = Time.at(@alquiler.hora_devolucion - @alquiler.hora_alquiler).utc
    @alquiler.save

    @auto = Auto.find(@alquiler.auto_id)
    @auto.alquiler_id = nil
    @auto.estado = "Disponible"
    @auto.save

    current_user.alquiler_id = nil
    current_user.is_renting = false
    current_user.save

    redirect_to resumen_path
  end

  def alquiler_params
    params.require(:alquiler).permit(:user_id, :auto_id, :fecha_inicio, :hora_inicio, :fecha_devolucion, :hora_devolucion)
  end

  def abrir_cerrar
    @auto = Auto.find(params[:id])
    if @auto.is_open?
      @auto.is_open = false
    else
      @auto.is_open = true
    end
    @auto.save
    redirect_to users_path
  end


  # def layout_by_resource
  #   if user_signed_in?
  #     "for_users"
  #   else
  #     "application"
  #   end
  # end

  def vista_mapa
    if current_user.is_renting?
      @alquiler = Alquiler.find(current_user.alquiler_id)
      @autos = Auto.where(id: @alquiler.auto_id)
      # @autos = Auto.where(current_user.alquiler_id.auto_id)
    else
      @autos = Auto.all.where(estado: "Disponible").order(:modelo)
    end
  end

  def user_is_not_renting?
    current_user.alquiler_id.nil?
  end

  def certificado
    @alquiler = Alquiler.find(current_user.alquiler_id)
    @fecha = @alquiler.fecha_devolucion.strftime("%d/%m/%Y")
    @tiempo = Time.at(@alquiler.hora_devolucion).utc.strftime("%H:%M hs")
    @auto = Auto.find(@alquiler.auto_id)
    @user = current_user
  end

  def no_tiene_saldo?(total_precio)
    current_user.wallet.saldo < total_precio
  end

  def la_hora_es_menor_a_la_actual_y_el_dia_es_hoy?(fecha_devolucion, hora_devolucion)
    # logger.debug "DEBUGS "
    # logger.debug "fecha_devolucion #{fecha_devolucion}"
    # logger.debug "fecha_devolucion.to_date #{fecha_devolucion.to_date}"
    # logger.debug "hora_devolucion #{hora_devolucion}"
    # logger.debug "Date.today #{Date.today.to_s}"
    # logger.debug "Date.today #{Date.today.to_s == fecha_devolucion}"
    # logger.debug "Time.now #{Time.now.getlocal }"
    # logger.debug "Time.now #{Time.parse(hora_devolucion) - Time.now}"
    # Date.today.
    # Time now based on the time zone of the server

    fecha_devolucion == Date.today.to_s && Time.parse(hora_devolucion)  < Time.now.getlocal
  end

  def calcular_deferencia_horas_ceil(fecha_devolucion, hora_devolucion, fecha_inicio, hora_inicio)
    (calcular_deferencia_minutos(fecha_devolucion, hora_devolucion, fecha_inicio, hora_inicio).to_f / 60).ceil
  end

  def calcular_deferencia_minutos(fecha_devolucion, hora_devolucion, fecha_inicio, hora_inicio)

    diff_in_hours_between_today_and_date_value = ((fecha_devolucion.to_time- fecha_inicio.to_time) / 60.minutes).to_i

    diff_horas = (hora_devolucion.hour - hora_inicio.hour) * 60
    diff_minutos = (hora_devolucion.min - hora_inicio.min)
    # debug and print every variable in this function
    # logger.debug "\n\n\n\n\nDEBUGS "
    # logger.debug "fecha_devolucion #{fecha_devolucion}"
    # logger.debug "fecha_devolucion.to_date #{fecha_devolucion.to_date}"
    # logger.debug "hora_devolucion #{hora_devolucion}"
    # logger.debug "diff_in_hours #{diff_in_hours_between_today_and_date_value}"
    # logger.debug "diff_horas #{diff_horas}"
    # logger.debug "diff_horas #{hora_devolucion.hour}"
    # logger.debug "diff_horas #{hora_inicio.hour}"
    # logger.debug "diff_minutos #{diff_minutos}\n\n\n\n"


    return diff_horas + diff_minutos + diff_in_hours_between_today_and_date_value
  end

  def calcular_precio_post_alquiler(alquiler)
    minutos_que_se_paso = calcular_deferencia_minutos(@alquiler.fecha_devolucion, @alquiler.hora_devolucion, @alquiler.fecha_user_devolucion, @alquiler.hora_user_devolucion)

    logger.debug "\n\n\n\n #{alquiler} \n\n\n\n"
    @alquiler.precio_por_demora = 0
    if minutos_que_se_paso > 0
      cantidad_de_15_mins_que_se_paso = (minutos_que_se_paso.to_f / 15).ceil
      @alquiler.tiempo_de_demora = Time.at(@alquiler.hora_devolucion - @alquiler.hora_user_devolucion).utc
      @alquiler.precio_por_demora = cantidad_de_15_mins_que_se_paso * (Precio.last.valor / 2)
    end
    precio_total = @alquiler.duracion_en_cant_horas * Precio.last.valor + @alquiler.precio_por_demora
  end

  def calcular_precio_pre_alquiler(fecha_devolucion, hora_devolucion, fecha_inicio, hora_inicio)
    # precio_actual = calcular_precio_post_alquiler(Alquiler.find(current_user.alquiler_id))
    precio = (calcular_deferencia_minutos(fecha_devolucion, hora_devolucion, fecha_inicio, hora_inicio).to_f / 60).ceil * (Precio.last.valor)
    # precio = precio_actual + precio_nuevo_intervalo
    if precio > current_user.wallet.saldo
      return "No tiene suficiente saldo"
    else
      return precio
    end
  end

  # function that given a number of minutes returns a time object with days hours and minutes
  def minutes_to_time(minutes)
    days = minutes / 1440
    hours = (minutes % 1440) / 60
    minutes = (minutes % 1440) % 60
    Time.new(0, 1, 1, hours, minutes, 0)
  end

  def prolongar_alquiler
    parametros = prolongar_params
    @alquiler = Alquiler.find(current_user.alquiler_id)

    fecha_devolucion = Date.parse(parametros[:fecha_devolucion])
    hora_devolucion = Time.parse(parametros[:hora_devolucion]).utc

    # logger.debug.

    logger.debug "\n\n\n\n\n DEBUG HORAS #{@alquiler.hora_devolucion.to_time}\n #{hora_devolucion.to_time}\n#{hora_devolucion.to_time  <= @alquiler.hora_devolucion.to_time}\n\n\n\n"
    logger.debug "\n\n\n\n  #{@alquiler.fecha_devolucion} \n \n#{fecha_devolucion}\n #{fecha_devolucion <= @alquiler.fecha_devolucion}\n"


    if (fecha_devolucion <= @alquiler.fecha_devolucion && hora_devolucion.to_time.strftime( "%H%M%S%N" ) <= @alquiler.hora_devolucion.to_time.strftime( "%H%M%S%N" ) )
      current_user.errors.add(:base, "La fecha de devolucion debe ser mayor a la actual")

      @auto = Auto.find(@alquiler.auto_id)
      @tiempo_fin = Time.at(@alquiler.hora_devolucion).strftime("%H:%M:%S")
      @minutos_restantes = calcular_deferencia_minutos(@alquiler.fecha_user_devolucion, @alquiler.hora_devolucion, Date.today, Time.now)

      render "/users/vista_alquiler" and return
    end

    horas_totales = calcular_deferencia_horas_ceil(fecha_devolucion, hora_devolucion, Date.today, Time.now.utc) # redondeadas hacia arriba
    precio_total = horas_totales * Precio.last.valor

    if no_tiene_saldo?(precio_total)
      current_user.errors.add(:base, "No tiene suficiente saldo")

      @auto = Auto.find(@alquiler.auto_id)
      @tiempo_fin = Time.at(@alquiler.hora_devolucion).strftime("%H:%M:%S")
      @minutos_restantes = calcular_deferencia_minutos(@alquiler.fecha_user_devolucion, @alquiler.hora_devolucion, Date.today, Time.now)

      render "/users/vista_alquiler" and return
    end

    @alquiler.fecha_devolucion = Date.parse(parametros[:fecha_devolucion])
    @alquiler.hora_devolucion = Time.parse(parametros[:hora_devolucion])
    @alquiler.duracion_en_cant_horas = horas_totales + @alquiler.duracion_en_cant_horas
    @alquiler.precio_total = precio_total + @alquiler.precio_total
    @alquiler.save

    redirect_to "/users/vista_alquiler" and return
  end

  def prolongar_params
    params.require(:alquiler).permit(:fecha_devolucion, :hora_devolucion)
  end
end
