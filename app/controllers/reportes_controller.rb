class ReportesController < ApplicationController

    layout :by_resource
    before_action :authenticate_persona!

    def index
        @reportes = Reporte.all
        render '/admins/listado_reportes' and return
    end
    
    def new
        @reporte = Reporte.new
    end

    def create
        @reporte = Reporte.new
        @reporte.descripcion = params[:reporte][:descripcion]
        @reporte.tipo = params[:reporte][:tipo]
        @reporte.id_usuario = current_user.id
        @reporte.title = params[:reporte][:title]
        @reporte.id_alquiler = Alquiler.where(user_id: current_user.id).last.id
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

    def by_resource
        if user_signed_in?
            "for_users"
        elsif admin_signed_in?
            "for_admins"
        end
    end

    def authenticate_persona!
        if user_signed_in?
            authenticate_user!
        elsif admin_signed_in?
            authenticate_admin!
        end
    end

end
