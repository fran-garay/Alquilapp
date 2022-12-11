class ReporteController < ApplicationController
    def listado_reportes
        @reporte = Reporte.all
    end
    def new
        @reporte = Reporte.new
    end
    def create
        @reporte = Reporte.new(reporte_params)
        @reporte.id_usuario = current_user.id
        @reporte.save
        redirect_to root_path
    end
    def show
        @reporte = Reporte.find(params[:id])
    end
    def edit
        @reporte = Reporte.find(params[:id])
    end
    def update
        @reporte = Reporte.find(params[:id])
        @reporte.update(reporte_params)
        redirect_to root_path
    end
    def destroy
        @reporte = Reporte.find(params[:id])
        @reporte.destroy
        redirect_to root_path
    end

    def reporte_params
        params.require(:reporte).permit(:descripcion)
    end

end
