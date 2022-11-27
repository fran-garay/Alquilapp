class UsersController < ApplicationController
  layout "for_users"
  before_action :authenticate_user!

  def index
    @user = current_user
    @autos = Auto.all.order(anio: :desc)
  end

  def vista_alquiler
    logger.debug "user_is_not_renting? #{user_is_not_renting?}"
    if user_is_not_renting?
      redirect_to users_path and return
    end
    @alquiler = Alquiler.find(current_user.current_alquiler_id)
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

  def nuevo_alquiler
    parametros = alquiler_params
    @alquiler = Alquiler.new
    @alquiler.user_id = current_user.id
    @alquiler.auto_id = params[:auto_id]
    @alquiler.fecha_inicio = Date.today
    @alquiler.hora_inicio = Time.now
    @alquiler.save
    current_user.current_alquiler_id = @alquiler.id
    current_user.is_renting = true
    current_user.save
    @auto = Auto.find(@alquiler.auto_id)
    @auto.current_alquiler_id = @alquiler.id
    @auto.save
    redirect_to users_vista_alquiler_path
  end

  def finalizar_alquiler
    @alquiler = Alquiler.find(current_user.current_alquiler_id)
    @alquiler.fecha_devolucion = Date.today
    @alquiler.hora_devolucion = Time.now
    @alquiler.save
    @auto = Auto.find(@alquiler.auto_id)
    @auto.current_alquiler_id = nil
    @auto.save
    current_user.current_alquiler_id = nil
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
    current_user.current_alquiler_id.nil?
  end

end
