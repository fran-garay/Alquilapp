class ReportesController < ApplicationController
    layout "for_admins"
    before_action :authenticate_admin!

    def index
        @reportes = Reporte.all.order("created_at")
        render '/admins/listado_reportes' and return
    end

    def newz
        @reporte = Reporte.new
    end

    def create
        @reporte = Reporte.new
        @reporte.descripcion = params[:reporte][:descripcion]
        @reporte.tipo = params[:reporte][:tipo]
        @reporte.user_id = current_user.id
        @reporte.title = params[:reporte][:title]
        @reporte.alquiler_id = Alquiler.where(user_id: current_user.id).last.id
        @reporte.auto_id = Alquiler.where(user_id: current_user.id).last.auto_id
        @reporte.save
        redirect_to root_path
    end

    def show
        @reporte = Reporte.find(params[:id])
        @user = User.find(@reporte.user_id)
        @alquiler = Alquiler.find(@reporte.alquiler_id)
        @auto = Auto.find(@alquiler.auto_id)
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
        params.require(:reporte).permit(:descripcion, :tipo, :id_usuario, :title, :id_alquiler)
    end
end
