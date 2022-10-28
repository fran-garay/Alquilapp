class AutosController < ApplicationController
  def listadoDeAutos
    @autos = Auto.all.order(id: :desc)
  end

  def auto
    @autos = Auto.find(params[:id])
  end
end
