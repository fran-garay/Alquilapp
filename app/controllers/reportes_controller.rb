class ReportesController < ApplicationController

    layout :by_resource
    before_action :authenticate_persona!

    def index_atendidos
        @reportes = Reporte.all.where(status: "Atendido").order("fecha_reporte ASC")
        #render '/admins/listado_reportes' and return
    end

    def index_pendientes
        @reportes = Reporte.all.where(status: "Pendiente").order("fecha_reporte ASC")
        #render '/admins/listado_reportes' and return
    end

    def index_finalizados
        @reportes = Reporte.all.where(status: "Finalizado").order("fecha_reporte DESC")
        #render '/admins/listado_reportes' and return
    end

    def new
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
        @reporte.fecha_reporte = Date.today
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

    def atender_reporte
        @reporte = Reporte.find(params[:id])
        @reporte.status = "Atendido"
        @reporte.admin_id = current_admin.id
        @admin = Admin.find(current_admin.id)
        @admin.is_handling_report = true
        @admin.save
        @reporte.save
        redirect_to "/reportes/#{params[:id]}"
    end

    def finalizar_reporte
        @reporte = Reporte.find(params[:id])
        @reporte.status = "Finalizado"
        @admin.is_handling_report = false
        @admin.save
        @reporte.save
        redirect_to "/reportes/#{params[:id]}"
    end

    def reporte_params
        params.require(:reporte).permit(:descripcion, :tipo, :id_usuario, :title, :id_alquiler)
    end

    def by_resource
        if user_signed_in?
            "for_users"
        elsif admin_signed_in?
            "for_admins"
        else
            "application"
        end
    end

    def authenticate_persona!
        if user_signed_in?
            authenticate_user!
        elsif admin_signed_in?
            authenticate_admin!
        else
            redirect_to root_path
        end
    end

end
