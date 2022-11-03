class AutosController < ApplicationController

  before_action:set_search

  def set_search
    @q = Auto.ransack(params[:q])
  end

  def listadoDeAutos
    @q = Auto.ransack(params[:q])
    @autos = @q.result(distinct: true)
  end

  # def listadoDeAutos
  #   @autos = Auto.all.order(id: :desc)
  # end

  # def auto
  #   @autos = Auto.find(params[:id])
  # end

  # def auto
  #   @autos = Auto.find(params[:id])
  # end

  def new
    @auto = Auto.new
  end
  
end
