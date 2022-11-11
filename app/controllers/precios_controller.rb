class PreciosController < ApplicationController

    layout "for_admins"
    before_action :authenticate_admin!

    def create
        @precio = Precio.new(precio_params)
        if @precio.save
            redirect_to precios_path
        else
            render :new
        end
    end

    def edit
        @precio = Precio.find(params[:id])
    end

    def update
        @precio = Precio.find(params[:id])
        if @precio.update(precio_params)
            redirect_to precios_path
        else
            render :edit
        end
    end

    def editarPrecio
        logger.debug "\n\n\n\nPrecio: #{@precio}\n\n\n\n"

        @precio = Precio.new(valor: precio_params[:valor], fecha_de_actualizacion: Time.now)
        @precio.save
        redirect_to precios_path
    end


    def index
        @precios = Precio.all.order(:fecha_de_actualizacion => 'desc')
        @precio = Precio.last
        @nuevo_precio = Precio.new
    end

    def destroy
        @precio = Precio.find(params[:id])
        @precio.destroy
        redirect_to precios_path
    end

    def precio_params
        params.require(:precio).permit(:valor, :fecha_de_actualizacion)
    end 
end
