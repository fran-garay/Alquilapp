class AutosController < ApplicationController

  layout "for_admins"
  before_action :authenticate_admin!
  before_action:set_search

  def set_search
    @q = Auto.ransack(params[:q])
  end

  def listadoDeAutos
    @q = Auto.ransack(params[:q])
    @autos = @q.result(distinct: true)
  end

  def new
    @auto = Auto.new
  end

  def create
    @auto = Auto.new(auto_params)
    if @auto.save
      redirect_to autos_path
    else
      render :new
    end
  end

  def edit
    @auto = Auto.find(params[:id])
  end

  def update
    @auto = Auto.find(params[:id])
    if @auto.update(auto_params)
      redirect_to autos_path
    else
      render :edit
    end
  end

  def destroy
    @auto = Auto.find(params[:id])
    @auto.destroy
    redirect_to autos_path
  end

  def auto_params
    params.require(:auto).permit(:patente, :modelo, :porcentaje_combustible, :estado, :anio, :tipo_de_caja, :tipo_de_combustible, :color)
  end
  
end
